package cat.institutmarianao.service.impl;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cat.institutmarianao.domain.Order;
import cat.institutmarianao.domain.User;
import cat.institutmarianao.domain.repository.OrderRepository;
import cat.institutmarianao.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderRepository orderRepository;
	
	@Override
	public Set<Order> getAllOrders() {
		return orderRepository.getAll();
	}

	@Override
	public Set<Order> getAllOrders(User client) {
		return orderRepository.findByUser(client);
	}
	
	@Override
	public void save(Order order) {
		orderRepository.save(order);		
	}

	@Override
	public Order getByReference(Integer reference) {
		return orderRepository.getByReference(reference);
	}

}
