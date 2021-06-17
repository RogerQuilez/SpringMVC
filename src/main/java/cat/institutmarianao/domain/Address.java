package cat.institutmarianao.domain;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

public class Address {

	private String recipientName;
	
	@Size(max = 50)
	@NotBlank
	private String address;
	
	@Size(max = 10)
	@NotBlank
	private String zipCode;
	
	@Size(max = 50)
	@NotBlank
	private String city;
	
	@Size(max = 20)
	@NotBlank
	private String state;
	
	@Size(max = 20)
	@NotBlank
	private String country;

	public String getRecipientName() {
		return recipientName;
	}

	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}
}
