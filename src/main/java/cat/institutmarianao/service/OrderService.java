package cat.institutmarianao.service;

import java.util.Set;

import cat.institutmarianao.domain.*;

public interface OrderService {

	/* TO ADMIN*/
	public Set<Order> getAllOrders();
	public Order getByReference(Integer reference);
	
	/*TO USER*/
	public Set<Order> getAllOrders(User client);
	public void save(Order order);
	
}
