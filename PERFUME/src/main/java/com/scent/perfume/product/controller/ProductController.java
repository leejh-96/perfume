package com.scent.perfume.product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.scent.perfume.common.util.PageInfo;
import com.scent.perfume.planning.model.vo.Member;
import com.scent.perfume.product.model.service.ProductService;
import com.scent.perfume.product.model.vo.Option;
import com.scent.perfume.product.model.vo.Product;
import com.scent.perfume.product.model.vo.ProductBoard;
import com.scent.perfume.product.model.vo.ProductBoardCategory;
import com.scent.perfume.product.model.vo.ProductBoardReply;
import com.scent.perfume.product.model.vo.TopCate;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
//@RequestMapping("/product")
public class ProductController {
	
	@Autowired
	private ProductService service;
	
	
	// 전체 상품 페이지
	
	@GetMapping("/product/list")
	public ModelAndView list(ModelAndView modelAndView, @RequestParam(defaultValue = "1") int page
			, @RequestParam(required = false) String gender, @RequestParam(required = false) String bn
			, @RequestParam(required = false) String sort , @RequestParam(required = false) String keyword
			) {

		
		// PRODUCT 리스트
		int listCount = service.getProductCount(gender, bn, sort, keyword);
		
		
		PageInfo pageInfo = new PageInfo(page, 10, listCount, 12);
		List<Product> list = service.getProductList(pageInfo,gender,sort,bn,keyword);		
		
		// BRAND 리스트
		List<Product> brand = service.getBrandList();
		
		// SCENT 리스트
				int listCount2 = service.getTopCateCount();
				List<TopCate> topcate = service.getTopCateList();
				
			
		
		// TOPCATEGORY modelAndView
		modelAndView.addObject("listCount2",listCount2);
		modelAndView.addObject("topcate",topcate);

		// BRAND modelAndView
		modelAndView.addObject("brand",brand);
		
		
		
		// PRODUCT modelAndView
		modelAndView.addObject("pageInfo", pageInfo);
		modelAndView.addObject("list",list);
		modelAndView.addObject("gender", gender);
		modelAndView.addObject("bn", bn);
		modelAndView.addObject("sort",sort);
		
		modelAndView.setViewName("product/list");
		
		
		return modelAndView;
		
	}
	
	// 상품 상세페이지 이동
	
	@GetMapping("/product/detail")
	public ModelAndView view(ModelAndView modelAndView, @RequestParam int no, @RequestParam(defaultValue = "1") int page
			) {
	   
		
		List<Product> list= service.findProductByNo(no);
		 
		
		
		List<Option> option = service.findProductOptionByNo(no);
		
		
		int listCount = service.getProductBoardCount(no);
		int qnalistCount = service.getProductQnaCount(no);
		
		
		List<ProductBoardCategory> boardcate = service.getBoardCategoryList();
		
		System.out.println("보드 카테" + boardcate);
	
		PageInfo pageInfo = new PageInfo(page, 10, listCount, 5);
		PageInfo qnapageInfo = new PageInfo(page, 10, qnalistCount, 5);
		
		List<ProductBoard> board = service.findProductBoardByNo(pageInfo, no);
		
		List<ProductBoard> qnaboard = service.findProductQnaByNo(qnapageInfo, no);
		
		List<ProductBoard> grade = service.findGradebyNo(no);
			
		
		System.out.println(board);		
	
		modelAndView.addObject("boardcate", boardcate);
		modelAndView.addObject("grade", grade);
		modelAndView.addObject("list", list);
		modelAndView.addObject("no", no);
		modelAndView.addObject("pageInfo", pageInfo);
		modelAndView.addObject("qnapageInfo", qnapageInfo);
		modelAndView.addObject("board", board);
		modelAndView.addObject("qnaboard", qnaboard);
		modelAndView.addObject("option", option);
		modelAndView.setViewName("product/detail");
			
		return modelAndView;
			
		}	
		
	
	

	
	@GetMapping("/scent")
	public ModelAndView scent(ModelAndView modelAndView, @RequestParam(defaultValue = "1") int page, @RequestParam int no,
			 @RequestParam(required = false) String gender, @RequestParam(required = false) String bn
			, @RequestParam(required = false) String sort , @RequestParam(required = false) String keyword) {
		
		
		int listCount = service.getScentProductCountByNo(no, gender, bn, keyword);
		TopCate scent =  service.findScentByNo(no);
		
		int listCount2 = service.getTopCateCount();
		List<TopCate> topcate = service.getTopCateList();
		
		List<Product> brand = service.getBrandList();
		
		PageInfo pageInfo = new PageInfo(page, 10, listCount, 10);
		List<Product> list = service.getScentProductList(pageInfo, no, gender, bn, sort, keyword);
		
	
		modelAndView.addObject("listCount2",listCount2);
		modelAndView.addObject("topcate",topcate);
		
		modelAndView.addObject("no", no);
		
		modelAndView.addObject("scent", scent);
		modelAndView.addObject("list", list);
		modelAndView.addObject("brand",brand);
		modelAndView.addObject("gender", gender);
		modelAndView.addObject("bn", bn);
		modelAndView.addObject("sort",sort);
		modelAndView.setViewName("product/scent");
		
		return modelAndView;
		
	}
	
	
	@GetMapping("/paper")
	public ModelAndView modelAndView(ModelAndView modelAndView, @RequestParam(defaultValue = "1") int page,
			@RequestParam(required = false) String sort) {
		
		System.out.println(sort);
		int listCount = service.getProductPaperCount();
		
		
	
		
		
		PageInfo pageInfo = new PageInfo(page, 10, listCount, 12);
		List<Product> list = service.getProductPaperList(pageInfo, sort);
		

		
		
		modelAndView.addObject("list", list);
		modelAndView.setViewName("product/paper");
		
		return modelAndView;
	}
	
	
	@GetMapping("/salelist")
	public ModelAndView modelAndView(ModelAndView modelAndView, @RequestParam(defaultValue = "1") int page) {
		
		int listCount = service.getSaleProductCount();
		
		
		PageInfo pageInfo = new PageInfo(page, 10, listCount, 12);
		List<Product> list = service.getSaleProductList(pageInfo);
		
	
		modelAndView.addObject("list", list);
		modelAndView.setViewName("product/salelist");
		return modelAndView;
	}
	
//	
//	@GetMapping("/reviewReply")
//	public String reviewReply(@RequestParam int no) {
//		log.info("댓글 작성 페이지 요청");
//		System.out.println(no);
//		return "/product/detail?no="+no;
//	}
	
	
	@ResponseBody
	@GetMapping("/reviewRe")
	public List<ProductBoardReply> reply(@RequestParam int pbNo) {
		
//		System.out.println(pbNo);
		List<ProductBoardReply> reply = service.findBypbNo(pbNo);
		
//		System.out.println(reply);
		
		return reply;
	}
	
	@ResponseBody
	@PostMapping("/reviewReply")
	public ProductBoardReply replyenroll( @ModelAttribute ProductBoardReply reply) {
		int result = 0;

		//모델로만들어서 인설트 하면 댓글에 해당하는프라이러미리 키 조회 
		// 모델어트리뷰트로 만들기.
		ProductBoardReply replySet = null;
		result = service.save(reply);
		
		if(result > 0) {
			replySet = service.findBypbrNo(reply.getPbrNo());    
		} else {  
		}	
		System.out.println(replySet);
		
		return replySet;
	}
	
	
	@ResponseBody
	@PostMapping("/reviewWrite") 
	public ProductBoard reviewWrite(@ModelAttribute ProductBoard review) {
		int result = 0;

		System.out.println("리뷰" + review);
		result = service.save(review);
	
		return review;
	}
	
		
	
	
	
	
	
	
	
	
	
	}
	
	
	
	
		
	
	
	
	
	
	
	
	

