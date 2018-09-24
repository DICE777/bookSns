<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
   <title> 책 등록 </title>

      <!-- jquery -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   
   <!-- semantic UI -->
   <link rel="stylesheet" type="text/css" href="http://localhost:8888/sns/resources/semanticUI/semantic.css">
   <script src="http://localhost:8888/sns/resources/semanticUI/semantic.js"></script>
   
   <!-- CSS & JavaScript -->
   <script src="http://localhost:8888/sns/resources/js/bookAdd.js"></script>
   <link rel="stylesheet" href="http://localhost:8888/sns/resources/css/bookAdd.css">
   
   <!-- 폰트 -->
   <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
   
   <style type="text/css">
      .defaultMain {
         background-color: #f8f8f8;
         padding: 3rem;
      }
      
      .wrapper {
         position : relative;
         display: grid;
         grid-template-columns: repeat(3, 1fr);
         grid-column-gap: 60px;
         grid-row-gap: 2em;
         
         width: 100%;
         height: 100vh;
         max-width: 650px;
         max-height: 500px;
         position: absolute;
         top: 0;
         left: 50%;
         transform: translateX(-50%);
         -webkit-transform: translateX(-50%);
      }
   
      .shelf {
         border-bottom: 30px solid #754f44;  /* #87314e */
         border-left: 20px solid transparent;
         border-right: 20px solid transparent;
         z-index: -10;
            
         width: 100%;
         max-width: 650px;
         max-height: 500px;
         position: absolute;
         
         left: 50%;
         transform: translateX(-50%);
         -webkit-transform: translateX(-50%);
         opacity: 0.9;
      }
   
      .shelf:after {
         content: '';
         background: #38241e; /* #512645 */
         height: 25px;
         position: absolute;
         top: 30px;
         left: 0;
         right: 0;
         z-index: 1;
         margin-left: -20px;
         margin-right: -20px;
      }
      
      .bookTitle {
         margin-top: 13px;
         color : white;
         display:-webkit-box;
         overflow:hidden;
         text-overflow:ellipsis;
         -webkit-box-orient:vertical;
         -webkit-line-clamp:1; 
         font-family: 'Nanum Gothic', sans-serif;
         font-weight: bold;
      }
   </style>

   <script>
      $(function() {
         $('#selfBtn').click(function(){
            location.href="selfAdd";
         });
      });
   </script>
</head>

<body>

<!-- ================================================= MENU ================================================= -->

   <jsp:include page="./topBookShelfMenu.jsp" flush="false"/>
   <input type="hidden" id="login" value="${sessionScope.userId }">

<!-- =============================================== Content ================================================ -->

   <div class="ui bottom attached padded">
      <!-- <div class="ui main text container"> -->
      <div class="container"  style="margin-top: 0px;">
         <div class="row">
            <div class="wrapper" style="margin-top: 85px;">
                   <c:forEach var="bookShelf" items="${bookShelf}">
                  <table align="center" style="text-align: center; table-layout: fixed;">
                     <tr>
                        <td>
                           <a href="goBookContent?searchIsbn=${bookShelf.isbn}"><img src="${bookShelf.thumbnail}"></a>
                           <c:choose>
                              <c:when test="${bookShelf.readYN eq 'Y'}">
                                 <img alt="읽었습니다." src="http://localhost:8888/sns/resources/images/check.png" width="15px;">
                              </c:when>
                              <c:otherwise>
                                 <img alt="읽지 않았습니다." src="http://localhost:8888/sns/resources/images/check-empty.png" width="15px;"> 
                              </c:otherwise>
                           </c:choose>
                           <br/>
                           <font class="bookTitle" title="${bookShelf.title}">${bookShelf.title}</font>
                        <td>
                     </tr>
                  </table>
                   </c:forEach>      
                  
                   <div class="shelf" style="margin-top: 425px;"></div>
            </div> 
         </div>
      </div>
    </div>
</body>
</html>