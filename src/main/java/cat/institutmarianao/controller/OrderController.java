
package cat.institutmarianao.controller;

import java.io.IOException;

import java.util.Date;

import javax.servlet.ServletException;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import cat.institutmarianao.domain.Item;
import cat.institutmarianao.domain.Order;
import cat.institutmarianao.service.*;
import cat.institutmarianao.domain.User;

@Controller
@RequestMapping("/users/orders")
@SessionAttributes("order")
public class OrderController {

	@Autowired
	private UserDetailsService userDetailsService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private ItemService itemService;

	@ModelAttribute("order")
	public Order setupOrder() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		User client = (User) userDetailsService.loadUserByUsername(username);

		Order order = new Order();
		order.setClient(client);
		return order;
	}

	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView orders() throws ServletException, IOException {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		User client = (User) userDetailsService.loadUserByUsername(username);

		ModelAndView modelview = new ModelAndView("orders");
		modelview.getModelMap().addAttribute("orders", orderService.getAllOrders(client));
		modelview.getModelMap().addAttribute("states", Order.STATES);
		return modelview;
	}

	@RequestMapping(value = "/newOrder", method = RequestMethod.GET)
	public ModelAndView newOrder(@SessionAttribute("order") Order order) throws ServletException, IOException {

		ModelAndView modelview = new ModelAndView("newOrder");
		modelview.getModelMap().addAttribute("items", itemService.getAllItems());

		return modelview;
	}

	@RequestMapping(value = "/newOrder/clearItems", method = RequestMethod.GET)
	public String newOrderClearItems(@SessionAttribute("order") Order order) throws ServletException, IOException {

		order.clearItems();
		return "redirect:/users/orders/newOrder";
	}

	@RequestMapping(value = "/newOrder/increaseItem", method = RequestMethod.GET)
	public String newOrderIncreaseItem(@SessionAttribute("order") Order order,
			@RequestParam("reference") String reference) throws ServletException, IOException {

		Item item = itemService.get(reference);
		order.increaseQuantity(item);
		return "redirect:/users/orders/newOrder";
	}

	@RequestMapping(value = "/newOrder/decreaseItem", method = RequestMethod.GET)
	public String newOrderDecreaseItem(@SessionAttribute("order") Order order,
			@RequestParam("reference") String reference) throws ServletException, IOException {

		Item item = itemService.get(reference);
		order.decreaseQuantity(item);
		return "redirect:/users/orders/newOrder";
	}

	@RequestMapping(value = "/newOrder/finishOrder", method = RequestMethod.GET)
	public String finishOrder() throws ServletException, IOException {
		return "finishOrder";
	}

	@InitBinder
	public void initialiseBinder(WebDataBinder binder) {
	}

	@RequestMapping(value = "/newOrder/finishOrder", method = RequestMethod.POST)
	public String finishOrder(@Valid @ModelAttribute("order") Order newOrderToAdd, BindingResult bindingResult,
			SessionStatus sessionStatus) {

		if (bindingResult.hasErrors()) {
			return "finishOrder";
		}
		
		newOrderToAdd.setReference(Order.incReferenceSequence());
	
		newOrderToAdd.setStartDate(new Date());

		orderService.save(newOrderToAdd);
		sessionStatus.setComplete();

		return "redirect:/users/orders/";
	}
}
