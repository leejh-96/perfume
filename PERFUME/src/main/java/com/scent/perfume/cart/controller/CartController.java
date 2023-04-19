package com.scent.perfume.cart.controller;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonArrayFormatVisitor;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.scent.perfume.cart.model.service.CartService;
import com.scent.perfume.cart.model.vo.Cart;
import com.scent.perfume.cart.model.vo.CartList;
import com.scent.perfume.cart.model.vo.CartProduct;
import com.scent.perfume.cart.model.vo.CartMember;
import com.scent.perfume.cart.model.vo.Order;
import com.scent.perfume.cart.model.vo.OrderList;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CartController {

	@Autowired
	private CartService cartService;
	
	@RequestMapping("/cartTest")
	public String test() {
		
		return "cart/test";
	}
	
	@RequestMapping("/cart")
	public String cartAll(@RequestParam("memberNo") int memberNo,
						  Model model) {
	
		CartMember memberInfo = null;
		List<Cart> clist = null;
		
		//로그인체크로직작성
		
		//회원의 장바구니 상품과 혜택정보를 불러온다.	
		clist = cartService.selectCartInfo(memberNo);
		
		//검증로직작성
		
		//회원의 혜택정보를 불러온다.
		memberInfo = cartService.selectCartMemberInfo(memberNo);
		
		//검증로직작성
		
		model.addAttribute("memberInfo", memberInfo);
		model.addAttribute("clist", clist);
		
		return "cart/cart";
	}

	/*
	 * @ResponseBody
	 * 
	 * @GetMapping("/amountUpdate") public int amountUpdate(@RequestParam("cartNo")
	 * int cartNo,@RequestParam("result") int cartProductCount) {
	 * 
	 * System.out.println(cartNo); System.out.println(cartProductCount);
	 * 
	 * int result = 0;
	 * 
	 * result = cartService.amountUpdate(cartNo,cartProductCount);
	 * 
	 * if (result > 0) { System.out.println("성공"); }else { System.out.println("실패");
	 * } return result;
	 * 
	 * };
	 */
	
	@ResponseBody
	@PostMapping("cart/couponUpdate")
	public int couponUpdate(@RequestParam("memberNo") int memberNo,
							@RequestParam("benefitNo") int benefitNo) {
		
		int result = cartService.couponUpdate(memberNo,benefitNo);
		
		return result;
		
	}
	@ResponseBody
	@PostMapping("cart/couponReset")
	public int couponReset(@RequestParam("memberNo") int memberNo,
						   @RequestParam("benefitNo") int benefitNo) {
		
		int result = cartService.couponReset(memberNo,benefitNo);
		
		return result;
		
	}
	@ResponseBody
	@PostMapping("cart/cartDelete")
	public int cartDelete(@RequestParam("memberNo")int memberNo,
						  @RequestParam("cartNo") int cartNo){
		
		System.out.println("memberNo : "+memberNo+", "+"carNo : "+cartNo);
		
		int result = cartService.cartDelete(memberNo,cartNo);
		
		if (result > 0) {
			System.out.println("성공");
			return result;
		}else {
			System.out.println("실패");
			return result;
		}
	}

	@ResponseBody
	@RequestMapping(value="cart/orderDetail", method=RequestMethod.POST, produces="application/json;")
	public Order orderDetail(@RequestBody Order order) {
		
	    String orderNo = order.getOrderNo(); 
		
		int result = cartService.orderInsert(order);
		
		order.setOrderNo(orderNo);
		
		System.out.println(order);
		
		if (result > 0) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
		return order;
	}
	
	@ResponseBody
	@RequestMapping(value="cart/order", method=RequestMethod.POST, produces="application/json;")
	public int order(@RequestBody OrderList orderList) {
		
		System.out.println("orderList : "+orderList);
		
		int result = cartService.orderListInsert(orderList);
		
		if (result > 0) {
			System.out.println("성공");
			return result;
		}else {
			System.out.println("실패");
			return result;
		}
	}
	
	@ResponseBody
	@PostMapping(value="/verifyIamport/{imp_uid}")
	public IamportResponse<Payment> paymentByImpUid(  Model model
													, Locale locale
													, HttpSession session
													, @PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException{	
		
			IamportClient iamport = new IamportClient("1800245033135003","tgBOxjYHrfyYGoGlA8oAOVutDILLtedqsru69Vzmzvcfu9oEyHOqhFpuIkkX4s0Hx68Ryy44QepSvK2O");
			
			return iamport.paymentByImpUid(imp_uid);
	}
	
	/*
	 * @GetMapping("/cart/orderList") public String
	 * orderList(@RequestParam("memberNo") int memberNo) {
	 * 
	 * System.out.println("memberNo : "+memberNo);
	 * 
	 * return "cart/orderList"; }
	 */
	/*
	 * /cart/orderList/'+order.point+'/'+order.orderNo+'/'+order.finalPrice+'/'/{n}/
	 * {gender}/{email}
	 * 
	 */	
	@RequestMapping("/cart/orderList/{orderNo}/{memberNo}/{plusPoint}")
	public String orderList(@PathVariable("orderNo") String orderNo,
							@PathVariable("memberNo") int memberNo,
							@PathVariable("plusPoint") int plusPoint,
							Model model) {
		Order order = null;
		
		order = cartService.orderList(orderNo);
		
		model.addAttribute("order", order);
		model.addAttribute("plusPoint", plusPoint);
		
		return "cart/orderList";
	}
	
	@ResponseBody
	@RequestMapping("/order/pointUpdate/{point}/{memberNo}")
	public int pointUpdate(@PathVariable("point") int point,
						   @PathVariable("memberNo") int memberNo) {
		
		log.info("point : {}",point);
		log.info("memberNo : {}",memberNo);
		
		return cartService.memberPointUpdate(point,memberNo);
	}
	
	@ResponseBody
	@RequestMapping("/order/plusPoint/{plusPoint}/{memberNo}")
	public int plusPoint(@PathVariable("plusPoint") int plusPoint,
						 @PathVariable("memberNo") int memberNo) {
		
		log.info("plusPoint : {}",plusPoint);
		log.info("memberNo : {}",memberNo);
		
		return cartService.memberPlusPoint(plusPoint,memberNo);
	}
	
}
