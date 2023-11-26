package com.xadmin.vmanagement.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.List;
import java.util.ArrayList;

import com.xadmin.vmanagement.bean.VService;

public class VServiceDao {
	
	private String jdbcURL = "jdbc:mysql://172.187.178.153:3306/isec_assessment2?useSSL=false";
	private String jdbcUsername = "isec";
	private String jdbcPassword = "EUHHaYAmtzbv";
	private String jdbcDriver = "com.mysql.jdbc.Driver";
	
	private static final String INSERT_VSERVICE_SQL = "INSERT INTO vehicle_service" + "  (date, time, location, vehicle_no, mileage, message, username) VALUES "
			+ " (?, ?, ?, ?, ?, ?, ?);";

	private static final String SELECT_ALL_VSERVICE_BY_EMAIL = "select * from vehicle_service where username =?";
	
	private static final String DELETE_VSERVICE_SQL = "delete from vehicle_service where booking_id = ?;";

	public VServiceDao() {
		
	}

	protected Connection getConnection() {
	
	Connection connection = null;
	try {
		Class.forName(jdbcDriver);
		connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return connection;
	
	}
	
	//insert vehicle service
	public void insertVehicleService( VService vehicleService) {
		System.out.println(INSERT_VSERVICE_SQL);
		// try-with-resource statement will auto close the connection.
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(INSERT_VSERVICE_SQL)) {
			java.sql.Date sqlDate = java.sql.Date.valueOf(vehicleService.getDate());
	        preparedStatement.setDate(1, sqlDate);			
			preparedStatement.setTime(2, Time.valueOf(vehicleService.getTime()));// Assuming 'getTime' returns a String in 'HH:mm:ss' format
			preparedStatement.setString(3, vehicleService.getLocation());
			preparedStatement.setString(4, vehicleService.getVehicle_no());
			preparedStatement.setInt(5, vehicleService.getMileage());
			preparedStatement.setString(6, vehicleService.getMessage());
			preparedStatement.setString(7, vehicleService.getUsername());
	
			System.out.println(preparedStatement);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			printSQLException(e);
		}
	}
	
	//select vehicle services by email
		public List<VService> selectAllVehicleServices(String username) {
		
			// using try-with-resources to avoid closing resources 
			List<VService> vehicleServices = new ArrayList<>();
	
	
			// Establishing a Connection
			try (Connection connection = getConnection();
					// Create a statement using connection object
					PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_VSERVICE_BY_EMAIL);) {
				preparedStatement.setString(1, username);
				System.out.println(preparedStatement);
				// Execute the query or update query
				ResultSet rs = preparedStatement.executeQuery();

				// Process the ResultSet object.
				while (rs.next()) {
					int booking_id = rs.getInt("booking_id");
					String date = rs.getString("date");
					String time = rs.getString("time");
					String location = rs.getString("location");
					String vehicle_no = rs.getString("vehicle_no");
					int mileage = rs.getInt("mileage");
					String message = rs.getString("message");
					String email = rs.getString("username");
					
					vehicleServices.add(new VService(booking_id, date, time, location, vehicle_no, mileage,message, email));
					
				}
			} catch (SQLException e) {
				printSQLException(e);
			}
			return vehicleServices;
		}
		
		//delete vehicle service
		public boolean deleteVehicleService(int booking_id) throws SQLException {
			boolean rowDeleted;
			try (Connection connection = getConnection();
					PreparedStatement statement = connection.prepareStatement(DELETE_VSERVICE_SQL);) {
				statement.setInt(1, booking_id);
				rowDeleted = statement.executeUpdate() > 0;
			}
			return rowDeleted;
		}
	
	
		private void printSQLException(SQLException ex) {
			for (Throwable e : ex) {
				if (e instanceof SQLException) {
					e.printStackTrace(System.err);
					System.err.println("SQLState: " + ((SQLException) e).getSQLState());
					System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
					System.err.println("Message: " + e.getMessage());
					Throwable t = ex.getCause();
					while (t != null) {
						System.out.println("Cause: " + t);
						t = t.getCause();
					}
				}
			}
	}	

}
