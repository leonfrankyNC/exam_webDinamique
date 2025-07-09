package Controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Lieu;
import dao.LieuDao;


public class FormVolServlet extends HttpServlet {

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    List<Lieu> lieux;
    try {
      lieux = LieuDao.findAll();
      request.setAttribute("lieux", lieux);
    }

    catch (Exception e) {

      e.printStackTrace();
    }

    request.getRequestDispatcher("View/formvol.jsp").forward(request, response);
  }


}
