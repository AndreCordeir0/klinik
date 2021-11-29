<%@page import="model.Usuario"%>
<%@page import="controller.GerenciarLogin"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Usuario usuarioLogado = GerenciarLogin.verificarAcesso(request, response);
    request.setAttribute("usuarioLogado", usuarioLogado);
%>
<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="gerenciar_index.do?acao=index">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">KLINIK</div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item <c:if test="${!empty(activeI)}">active</c:if>">
            <a class="nav-link" href="gerenciar_index.do?acao=index">
                <i class="fas fa-home"></i>
                <span>Home</span></a>
        </li>

        <!-- Divider -->
        <hr class="sidebar-divider">

        <!-- Heading -->
        <div class="sidebar-heading">
            Modulos
        </div>
        
        <c:if test="${usuarioLogado != null && usuarioLogado.idPerfil != null}">
            <c:forEach var="menu" items="${usuarioLogado.idPerfil.menus}">
                <c:if test="${menu.exibir == 1}">
                    <!-- Nav Item - Tables -->
                    <li class="nav-item ${menu.active}">
                        <a class="nav-link" href="${menu.link}">
                            <i class="${menu.icone}"></i>
                            <span>${menu.nome}</span>
                        </a>
                    </li>
                </c:if>
            </c:forEach>
        </c:if>
        
        <!-- Divider -->
        <hr class="sidebar-divider">

        <!-- Heading -->
        <div class="sidebar-heading">
            Configura��es
        </div>
        
        <c:if test="${usuarioLogado != null && usuarioLogado.idPerfil != null}">
            <c:forEach var="menu" items="${usuarioLogado.idPerfil.menus}">
                <c:if test="${menu.nome == 'Usuarios'}">
                    <!-- Nav Item - Tables -->
                    <li class="nav-item <c:if test="${!empty(activeU)}">active</c:if>">
                        <a class="nav-link" href="gerenciar_usuarios.do?acao=listar">
                            <i class="fas fa-users"></i>
                            <span>Usu�rios</span>
                        </a>
                    </li>
                </c:if>
            </c:forEach>
        </c:if>
        
        <c:if test="${usuarioLogado != null && usuarioLogado.idPerfil != null}">
            <c:forEach var="menu" items="${usuarioLogado.idPerfil.menus}">
                <c:if test="${menu.nome == 'Menus'}">
                    <!-- Nav Item - Tables -->
                    <li class="nav-item <c:if test="${!empty(activeM)}">active</c:if>">
                        <a class="nav-link" href="gerenciar_menu.do?acao=listar">
                            <i class="fas fa fa-list"></i>
                            <span>Menus</span>
                        </a>
                    </li>
                </c:if>
            </c:forEach>
        </c:if>
        
        <c:if test="${usuarioLogado != null && usuarioLogado.idPerfil != null}">
            <c:forEach var="menu" items="${usuarioLogado.idPerfil.menus}">
                <c:if test="${menu.nome == 'Perfil'}">
                    <!-- Nav Item - Tables -->
                    <li class="nav-item <c:if test="${!empty(activeP)}">active</c:if>">
                        <a class="nav-link" href="gerenciar_perfil.do?acao=listar">
                            <i class="fas fa-user-alt"></i>
                            <span>Perfis</span>
                        </a>
                    </li>
                </c:if>
            </c:forEach>
        </c:if>

    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>

</ul>
<!-- End of Sidebar -->
