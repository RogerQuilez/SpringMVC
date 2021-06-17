package cat.institutmarianao.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cat.institutmarianao.domain.Order;
import cat.institutmarianao.service.OrderService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private OrderService orderService;
	
	@RequestMapping(value = "/orders", method = RequestMethod.GET)
	public ModelAndView orders() throws ServletException, IOException {

		ModelAndView modelview = new ModelAndView("orders");
		modelview.getModelMap().addAttribute("orders", orderService.getAllOrders());
		modelview.getModelMap().addAttribute("states", Order.STATES);
		return modelview;
	}

	@RequestMapping(value = "/orders/setDeliveryDate", method = RequestMethod.POST)
	public String setDeliveryDate(@RequestParam("reference") String reference, 
			@RequestParam("deliveryDate") String deliveryDate) throws ServletException, IOException {
		
		try {
			
			Order order = orderService.getByReference(Integer.parseInt(reference));
			Date deliveryDateDate;
			deliveryDateDate = new SimpleDateFormat("yyyy-MM-dd").parse(deliveryDate);
			order.setDeliveryDate(deliveryDateDate);
			orderService.save(order);
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
				
		return "redirect:/admin/orders";
	}
	
	@RequestMapping(value = "/orders/setState", method = RequestMethod.POST)
	public String setState(@RequestParam("reference") String reference, 
			@RequestParam("state") int state) throws ServletException, IOException {
		
		Order order = orderService.getByReference(Integer.parseInt(reference));

		order.setState(state);

		orderService.save(order);
		return "redirect:/admin/orders";
	}
}
