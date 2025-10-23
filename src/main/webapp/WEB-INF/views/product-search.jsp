<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>
<%@ taglib prefix="t"   tagdir="/WEB-INF/tags"  %>
<fmt:setLocale value="${empty lang ? 'vi' : lang}"/>
<fmt:setBundle basename="app_i18n.messages"/>
<!doctype html>
<html lang="${empty lang ? 'vi' : lang}">
<head>
    <meta charset="utf-8">
    <title><fmt:message key="products.search.title"/> - <fmt:message key="app.title"/></title>
</head>
<body>
<%@ include file="/WEB-INF/views/_layout.jspf" %>

<div class="container my-4">
    <!-- Search Form -->
    <div class="row mb-4">
        <div class="col">
            <form class="d-flex" action="<t:urlWithLang value='/products/search'/>" method="get" style="max-width:600px;">
                <input class="form-control me-2" type="search" name="q"
                       placeholder="<fmt:message key='products.search.placeholder'/>"
                       value="${keyword}" required>
                <button class="btn btn-primary" type="submit">
                    <fmt:message key="btn.search"/>
                </button>
            </form>
        </div>
    </div>

    <!-- Search Results Header -->
    <div class="row mb-3">
        <div class="col">
            <h5>
                <fmt:message key="products.search.results"/>:
                <span class="text-muted">"${keyword}"</span>
            </h5>
            <p class="text-muted">
                <fmt:message key="products.search.found"/> ${resultCount}
                <fmt:message key="products.search.product${resultCount != 1 ? 's' : ''}"/>
            </p>
        </div>
    </div>

    <!-- Results -->
    <div class="row">
        <div class="col">
            <c:choose>
                <c:when test="${empty products}">
                    <div class="alert alert-info">
                        <fmt:message key="products.search.noresults"/>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-4">
                        <c:forEach var="p" items="${products}">
                            <div class="col-md-6 col-lg-4">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <h6 class="card-title mb-1">${p.name}</h6>
                                        <div class="text-muted small mb-2">
                                            #${p.id} | ${p.categoryName}
                                        </div>
                                        <p class="text-muted" style="min-height:60px; font-size:0.9rem;">
                                            <c:out value="${p.description}"/>
                                        </p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <strong class="text-primary">₫${p.price}</strong>
                                            <span class="badge bg-light text-dark">⚖ ${p.weight} g</span>
                                        </div>
                                    </div>
                                    <div class="card-footer bg-white">
                                        <a class="btn btn-sm btn-primary w-100"
                                           href="<t:urlWithLang value='/products/detail?id=${p.id}'/>">
                                            <fmt:message key="btn.details"/>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Back Link -->
    <div class="row mt-4">
        <div class="col">
            <a href="<t:urlWithLang value='/home'/>" class="btn btn-outline-secondary">
                ← <fmt:message key="btn.back"/>
            </a>
        </div>
    </div>
</div>

</body>
</html>