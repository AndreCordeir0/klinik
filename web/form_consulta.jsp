<%@page import="java.util.List"%>
<%@page import="model.Usuario"%>
<%@page import="controller.GerenciarLogin"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.ServicoConsulta"%>
<%@page import="model.ClienteDAO"%>
<%@page import="model.Cliente"%>
<%@page import="model.Consulta"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>KLINIK | Nova Consulta</title>

        <!-- Custom fonts for this template-->
        <link href="assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="assets/css/sb-admin-2.min.css" rel="stylesheet">

    </head>

    <body id="page-top">

        <!-- Page Wrapper -->
        <div id="wrapper">

            <jsp:include page="menu.jsp"/>
            
            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">
                    
                    <jsp:include page="topbar.jsp"/>

            <!-- Begin Page Content -->
            <div class="container-fluid">

                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="gerenciar_index.do?acao=index">Home</a></li>
                        <li class="breadcrumb-item"><a href="gerenciar_cliente.do?acao=listar">Clientes</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Nova Consulta</li>
                    </ol>
                </nav>

                <!-- DataTales Example -->
                <div class="card shadow mb-4">

                    <div class="card-body">
                                         
                        <%
                            
                            Usuario usuarioLogado = GerenciarLogin.verificarAcesso(request, response);
                            request.setAttribute("usuarioLogado", usuarioLogado);
                            
                            Consulta con = new Consulta();
                            Cliente cliente = new Cliente();
                            try {
                                    
                                String acao = request.getParameter("acao");
                                ClienteDAO cDAO = new ClienteDAO();
                                
                                if (acao.equals("novo")) {
                                    int idCliente = Integer.parseInt(request.getParameter("idCliente"));
                                    cliente = cDAO.getCarregaPorId(idCliente);
                                    
                                    con.setCliente(cliente);
                                    con.setAtendente(usuarioLogado);
                                    con.setCarrinho(new ArrayList<ServicoConsulta>());
                                    session.setAttribute("consulta", con);
                                    
                                } else {
                                    con = (Consulta) session.getAttribute("consulta");
                                }
                                
                            } catch (Exception e) {
                                out.println("Erro: "+ e);
                            }
                        %>
                        
                        <h5><i class="fas fa-user-tie"></i> <strong>Atendente:</strong> <%=con.getAtendente().getNome()%></h5>
                        
                        <h5><i class="fas fa-user-tag"></i> <strong>Cliente:</strong> <%=con.getCliente().getNome()%></h5>
                        
                        <h5><i class="fas fa-shopping-cart"></i> <strong>Carrinho:</strong> (<%=con.getCarrinho().size()%> Serviços)</h5>
                        
                        
                        <jsp:useBean class="model.ServicoDAO" id="servicoDAO"/>
                        <table class="table">
                            <thead class="text-primary">
                                <tr>
                                    <th>ID</th>
                                    <th>Nome</th>
                                    <th>Quantidade</th>
                                    <th class="text-center">Adicionar</th>
                                </tr>
                            </thead>
                        <c:forEach var="servico" items="${servicoDAO.lista}">
                            <c:if test="${servico.status == 1}">
                                <div id="serv${servico.idServico}">
                                    <form action="gerenciar_carrinho_consulta.do" method="GET">
                                            <tbody>
                                                <tr>
                                                    <td>${servico.idServico}</td>
                                                    <td>${servico.nome}</td>
                                                    <td><input class="form-control text-center" style="width: 100px;" name="quantidade" value="${servico.quantidade}"></td>
                                                    <td class="text-center"><button type="submit" class="btn btn-primary btn-sm"><i class="fas fa-plus"></i></button></td>
                                                </tr>
                                            </tbody>
                                        <input type="hidden" name="acao" value="add">
                                        <input type="hidden" name="idServico" value="${servico.idServico}">

                                    </form>
                                </div>
                            </c:if>
                        </c:forEach>
                        </table>
                        
                        <a title="Finalizar Consulta" href="form_finalizar_consulta.jsp?acao=finalizar" class="btn btn-primary btn-sm float-right ml-2"><i class="fas fa-save"></i>&nbsp;Finalizar Consulta</a>
                        <a title="Voltar" href="gerenciar_cliente.do?acao=listar" class="btn btn-success btn-sm float-right"><i class="fas fa-arrow-left"></i>&nbsp;Voltar</a>                  
                    </div>
                </div>

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- End of Main Content -->

        <jsp:include page="footer.jsp"/>

    </div>
    <!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                <a class="btn btn-primary" href="login.html">Logout</a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript-->
<script src="assets/vendor/jquery/jquery.min.js"></script>
<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="assets/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="assets/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="assets/vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts -->
<script src="assets/js/demo/chart-area-demo.js"></script>
<script src="assets/js/demo/chart-pie-demo.js"></script>

</body>

</html>

