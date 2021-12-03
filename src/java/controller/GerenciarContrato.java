/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Contrato;

/**
 *
 * @author Danilo
 */
public class GerenciarContrato extends HttpServlet {


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        String idCliente = request.getParameter("idCliente");
        String acao = request.getParameter("acao");
        String mensagem = "";
        
        Contrato contrato = new Contrato();
        
        if (acao.equals("contrato")) {
            if (GerenciarLogin.verificarPermissao(request, response)) {
                RequestDispatcher disp = getServletContext().getRequestDispatcher("/form_contrato.jsp");
                request.setAttribute("titulo", "Cadastrar Contrato");
                request.setAttribute("idCliente", idCliente);
                request.setAttribute("activeCon", "active");
                request.setAttribute("acao", "contrato");
                disp.forward(request, response);
            } else {
                mensagem = "Acesso Negado a está função!";
            }
        }
        
    }

    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
