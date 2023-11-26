package com.xadmin.vmanagement.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.text.StringEscapeUtils;


import com.xadmin.vmanagement.bean.VService;
import com.xadmin.vmanagement.dao.VServiceDao;

/**
 * Servlet implementation class VServiceServlet
 */
@WebServlet("/")
public class VServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VServiceDao vehicleServiceDao;  
   

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init() throws ServletException {
		vehicleServiceDao = new VServiceDao();
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method 
		doGet(request, response);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getServletPath();

		
		try {
			switch (action) {
			case "/new":
				showNewForm(request, response);
				break;
				
			case "/insert":
				insertVehicleService(request, response);
				break;
				
			case "/delete":
				deleteVehicleService(request, response);
				break;
	
			default:
				String email = request.getParameter("email"); // retrieving the user email fom the home page.
				listVehicleService(request, response,email);
				break;
			}
		} catch (SQLException ex) {
			throw new ServletException(ex);
		}
		
	}
	
	private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		RequestDispatcher dispatcher = request.getRequestDispatcher("VServiceForm.jsp");
		dispatcher.forward(request, response);
		
	}
	
	
	//insert vehicle service
		private void insertVehicleService(HttpServletRequest request, HttpServletResponse response)throws SQLException, IOException 
		{	   
			
			  String date = StringEscapeUtils.escapeHtml4(request.getParameter("date").replaceAll("'", "''")); 
			  
			  String time = StringEscapeUtils.escapeHtml4(request.getParameter("time").replaceAll("'", "''"));
			 
			  String location = StringEscapeUtils.escapeHtml4(request.getParameter("location").replaceAll("'", "''"));
			  
			  String vehicle_no = StringEscapeUtils.escapeHtml4(request.getParameter("vehicle_no").replaceAll("'", "''"));
			  
			  int mileage = Integer.parseInt(request.getParameter("mileage"));
			  
			  String message = StringEscapeUtils.escapeHtml4(request.getParameter("message").replaceAll("'", "''"));

			  String username = StringEscapeUtils.escapeHtml4(request.getParameter("username").replaceAll("'", "''"));
			
			VService newVehicleService = new VService(date, time, location, vehicle_no, mileage, message, username);
			
			vehicleServiceDao.insertVehicleService(newVehicleService);
			
			response.sendRedirect("list");
			
		}
		
		//delete vehicle service
		private void deleteVehicleService(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException 
		{
			int booking_id = Integer.parseInt(request.getParameter("booking_id"));
			try {
			
				vehicleServiceDao.deleteVehicleService(booking_id);
			
			}catch(Exception e){
				e.printStackTrace();
			}
			response.sendRedirect("list");
		}
		
		//default
		private void listVehicleService(HttpServletRequest request, HttpServletResponse response,String email)throws SQLException, IOException, ServletException 
		{ 

			String username = email;
			try {
				List<VService> listVehicleService = vehicleServiceDao.selectAllVehicleServices(username);
				request.setAttribute("listVehicleService", listVehicleService);
				RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
				dispatcher.forward(request, response);
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}	

}
