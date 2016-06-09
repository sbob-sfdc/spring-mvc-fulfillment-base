package com.force.example.fulfillment.order.service;

import java.util.List;

import canvas.CanvasRequest;
import com.force.example.fulfillment.order.model.Invoice;

public interface InvoiceService {
	public void addInvoice(Invoice invoice);
    public List<Invoice> listInvoices();
    public Invoice findInvoice(String id);
    public void removeInvoice(String id);
    public void setSignedRequest(CanvasRequest cr);
}
