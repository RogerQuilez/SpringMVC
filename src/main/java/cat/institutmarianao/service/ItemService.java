package cat.institutmarianao.service;

import java.util.List;

import cat.institutmarianao.domain.Item;

public interface ItemService {
	
	List<Item> getAllItems();
	
	Item get(String reference);

}
