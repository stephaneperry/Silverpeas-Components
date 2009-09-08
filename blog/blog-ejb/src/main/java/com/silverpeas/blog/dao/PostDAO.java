package com.silverpeas.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import com.stratelia.webactiv.util.DBUtil;

public class PostDAO
{
	static SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");

	public static void createDateEvent(Connection con, String pubId, Date dateEvent, String instanceId) throws SQLException
	{
		// Cr�ation 
		PreparedStatement prepStmt = null;
		try
		{
			// cr�ation de la requete
			String query = "insert into SC_Blog_Post (pubId, dateEvent, instanceId) values (?, ?, ?)";
			// initialisation des param�tres
			prepStmt = con.prepareStatement(query);
			prepStmt.setInt(1, new Integer(pubId).intValue());
			prepStmt.setString(2, Long.toString((dateEvent).getTime()));
			prepStmt.setString(3, instanceId);
			prepStmt.executeUpdate();
		}
		finally
		{
			// fermeture
			DBUtil.close(prepStmt);
		}
	}

	public static Date getDateEvent(Connection con, String pubId) throws SQLException
	{
		// r�cup�rer la date
		String query = "select dateEvent from SC_Blog_Post where pubId = ? ";
		Date dateEvent = new Date();
		PreparedStatement prepStmt = null;
		ResultSet rs = null;
		try
		{
			prepStmt = con.prepareStatement(query);
			prepStmt.setInt(1, Integer.parseInt(pubId));
			rs = prepStmt.executeQuery();
			while (rs.next())
			{
				// recuperation de la date
				dateEvent = new Date(Long.parseLong(rs.getString("dateEvent")));
			}
		} 
		finally
		{
			// fermeture
			DBUtil.close(rs, prepStmt);
		}
		return dateEvent;
	}
	
	public static void deleteDateEvent(Connection con, String pubId) throws SQLException
	{
		PreparedStatement prepStmt = null;
		try
		{
			String query = "delete from SC_Blog_Post where pubId = ? ";
			prepStmt = con.prepareStatement(query);
			prepStmt.setInt(1, Integer.parseInt(pubId));
			prepStmt.executeUpdate();
		}
		finally
		{
			// fermeture
			DBUtil.close(prepStmt);
		}
	}
	
	public static void updateDateEvent(Connection con, String pubId, Date dateEvent) throws SQLException
	{
		PreparedStatement prepStmt = null;
		try
		{
			// mettre � jour la date d'�v�nement 
			String query = "update SC_Blog_Post set dateEvent = ? where pubId = ?";
			// initialisation des param�tres
			prepStmt = con.prepareStatement(query);
			prepStmt.setString(1, "" + dateEvent.getTime());
			prepStmt.setInt(2, Integer.parseInt(pubId));
			prepStmt.executeUpdate();
		}
		finally
		{
			// fermeture
			DBUtil.close(prepStmt);
		}
	}
	
	public static String getOldestEvent(Connection con, String instanceId) throws SQLException
	{
		// r�cup�rer le dernier post par date d'�v�nement
		String query = "select pubId from SC_Blog_Post where instanceId = ? order by dateEvent ASC";
		PreparedStatement prepStmt = null;
		ResultSet rs = null;
		String pubId = "";
		try
		{
			prepStmt = con.prepareStatement(query);
			prepStmt.setString(1, instanceId);
			rs = prepStmt.executeQuery();
			if (rs.next())
			{
				pubId = "" + rs.getInt("pubId");
			}
		}
		finally
		{
			// fermeture
			DBUtil.close(rs, prepStmt);
		}
		return pubId;
	}
	
	public static Collection<String> getLastEvents(Connection con, String instanceId, int nbReturned) throws SQLException
	{
		// r�cup�rer les "nbReturned" derniers posts par date d'�v�nement
		ArrayList<String> listEvents = new ArrayList<String>();
		String query = "select pubId from SC_Blog_Post where instanceId = ? order by dateEvent DESC";
		PreparedStatement prepStmt = null;
		ResultSet rs = null;
		try
		{
			prepStmt = con.prepareStatement(query);
			prepStmt.setString(1, instanceId);
			rs = prepStmt.executeQuery();
			while (rs.next() && nbReturned > 0)
			{
				nbReturned = nbReturned - 1; 
				String pubId = "" + rs.getInt("pubId");
				listEvents.add(pubId);
			}
		}
		finally
		{
			// fermeture
			DBUtil.close(rs, prepStmt);
		}
		return listEvents;
	}
	
	public static Collection<String> getAllEvents(Connection con, String instanceId) throws SQLException
	{
		// r�cup�rer les derniers posts par date d'�v�nement
		ArrayList listEvents = new ArrayList<String>();
		String query = "select pubId from SC_Blog_Post where instanceId = ? order by dateEvent DESC";
		PreparedStatement prepStmt = null;
		ResultSet rs = null;
		try
		{
			prepStmt = con.prepareStatement(query);
			prepStmt.setString(1, instanceId);
			rs = prepStmt.executeQuery();
			while (rs.next())
			{
				String pubId = "" + rs.getInt("pubId");
				listEvents.add(pubId);
			}
		}
		finally
		{
			// fermeture
			DBUtil.close(rs, prepStmt);
		}
		return listEvents;
	}
	
	public static Collection<Date> getAllDateEvents(Connection con, String instanceId) throws SQLException
	{
		ArrayList<Date> dateEvents = null;
		String query = "select dateEvent from SC_Blog_Post where instanceId = ? order by dateEvent DESC";
		PreparedStatement prepStmt = null;
		ResultSet rs = null;
		try
		{
			prepStmt = con.prepareStatement(query);
			prepStmt.setString(1, instanceId);
			rs = prepStmt.executeQuery();
			dateEvents = new ArrayList<Date>();
			while (rs.next())
			{
				dateEvents.add(new Date(Long.parseLong((String) rs.getString("dateEvent"))));
			}
		}
		finally
		{
			// fermeture
			DBUtil.close(rs, prepStmt);
		}
		return dateEvents;
	}
	
	public static Collection<String> getEventsByDates(Connection con, String instanceId, String beginDate, String endDate) throws SQLException, ParseException
	{
		// r�cup�rer les posts par date d'�v�nement entre 2 dates
		ArrayList<String> listEvents = null;

		String query = "select pubId from SC_Blog_Post where instanceId = ? and dateEvent >= ? and dateEvent <= ? order by dateEvent DESC";
		PreparedStatement prepStmt = null;
		ResultSet rs = null;
		try
		{
			prepStmt = con.prepareStatement(query);
			prepStmt.setString(1, instanceId);
			prepStmt.setString(2, Long.toString((formatter.parse(beginDate)).getTime()));
			prepStmt.setString(3, Long.toString((formatter.parse(endDate)).getTime()));
			rs = prepStmt.executeQuery();
			listEvents = new ArrayList<String>();
			while (rs.next())
			{
				String pubId = "" + rs.getInt("pubId");
				listEvents.add(pubId);
			}
		}
		finally
		{
			// fermeture
			DBUtil.close(rs, prepStmt);
		}
		return listEvents;
	}
}