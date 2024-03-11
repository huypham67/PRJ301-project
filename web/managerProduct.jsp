<%-- 
    Document   : managerProduct
    Created on : Feb 21, 2024, 11:42:37 PM
    Author     : huypd
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manager Product</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
        <style>
            img{
                width: 200px;
                height: 120px;
            }
        </style>
    <body>
        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>Manage <b>Product</b></h2>
                        </div>
                        <div class="col-sm-6">
                            <a href="#" onclick="showModalAdd()" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Product</span></a>
                            <a href="#" onclick="showModalDelete()" class="btn btn-danger" data-toggle="modal"><i class="material-icons">&#xE15C;</i> <span>Delete</span></a>						
                        </div>
                    </div>
                </div>
                <form action="deleteProduct" method="post">
                    <input id="buttonform" type="submit" style="display: none">                  
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>
                                    <span class="custom-checkbox">
                                        <input type="checkbox" id="selectAll">
                                        <label for="selectAll"></label>
                                    </span>
                                </th>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Image</th>
                                <th>Price</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>                        
                             <c:forEach items="${listP}" var="o">
                                <tr>
                                    <td>
                                        <span class="custom-checkbox">
                                            <input type="checkbox" id="checkbox1" name="options[]" value="${o.id}">
                                            <label for="checkbox1"></label>
                                        </span>
                                    </td>
                                    <td id="${o.id}">${o.id}</td>
                                    <td>${o.name}</td>
                                    <td>
                                        <img src="${o.image}">
                                    </td>
                                    <td>${o.price}$</td>
                                    <td>
                                        <a onclick="showModalEdit('${o.id}','${o.name}','${o.image}','${o.description}','${o.price}','${o.duration}','${o.cid}','${o.publicDate}')"  
                                        class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
                                        
                                        <a href="deleteProduct?pid=${o.id}" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                                    </td>
                                </tr>
                            </c:forEach>                      
                        </tbody>                    
                    </table>
                </form>
                <div class="clearfix">
                    <div class="hint-text">Showing <b>5</b> out of <b>25</b> entries</div>
                    <ul class="pagination">
                        <li class="page-item active"><a href="#" class="page-link">1</a></li>
                        <li class="page-item"><a href="#" class="page-link">2</a></li>
                        <li class="page-item"><a href="#" class="page-link">3</a></li>
                        <li class="page-item"><a href="#" class="page-link">4</a></li>
                        <li class="page-item"><a href="#" class="page-link">5</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- Add Modal HTML -->
        <div id="addCourseModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="addProductForm" action="addProduct" method="get">
                        <div class="modal-header">						
                            <h4 class="modal-title">Add Product</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">	
<!--                            <div class="form-group">
                                <label>Id</label>
                                <input id="idAdd" name="id" type="text" class="form-control" required>
                            </div>-->
                            <div class="form-group">
                                <label>Name</label>
                                <input id="nameAdd" name="name" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Image</label>
                                <input id="imageAdd" name="image" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <textarea id="desAdd" name="description" class="form-control" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>Price</label>
                                <input id="priceAdd" name="price" type="text" class="form-control" required>
                            </div>
                            <label>Duration</label>
                            <div style="display: flex; justify-content: space-between">
                                <div class="form-group">                                  
                                    <input id="nuAdd" name="numberDu" type="number" class="form-control" required> 
                                </div>
                                <div class="form-group">
                                    <select id="seAdd" name="selectDu" class="form-control" aria-label="Default select example">
                                        <option value="Weeks">Weeks</option>
                                        <option value="Years">Years</option>
                                    </select>   
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Category</label>
                                <select name="category" class="form-control" aria-label="Default select example">
                                    <c:forEach items="${listC}" var="o">
                                        <option value="${o.cid}">${o.cname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Public Date</label>
                                <input id="pdAdd"  name="publicDate" type="datetime-local" class="form-control" required>
                            </div>	                           
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-success" value="Add">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit Modal HTML -->
        <div id="editCourseModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="updateProduct" method="post">
                        <div class="modal-header">						
                            <h4 class="modal-title">Edit Product</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>                      
                        <div class="modal-body">	
                            <div class="form-group">
                                <label>Id</label>
                                <input id="idEdit" value="" name="id" type="text" readonly class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Name</label>
                                <input id="nameEdit" value="" name="name" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Image</label>
                                <input id="imageEdit" value="" name="image" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <textarea id="desEdit" name="description" class="form-control" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>Price</label>
                                <input id="priceEdit" value="" name ="price" type="text" class="form-control" required>
                            </div>
                            <label>Duration</label>
                            <div style="display: flex; justify-content: space-between">
                                <div class="form-group">                                  
                                    <input id="nuEdit" name="numberDu" type="number" class="form-control" required> 
                                </div>
                                <div class="form-group">
                                    <select id="seEdit" name="selectDu" class="form-control" aria-label="Default select example">
                                    </select>   
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Category</label>
                                <select name="category" id="categorySelect" class="form-control" aria-label="Default select example">
<!--                                    <option></option>-->
                                    <c:forEach items="${listC}" var="o" varStatus="loop">
                                        <option value="${o.cid}">${o.cname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Public Date</label>
                                <input id="pdEdit"  name="publicDate" type="datetime-local" class="form-control" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-info" value="Save">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Delete Modal HTML -->
        <div id="deleteCourseModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">                
                    <div class="modal-header">						
                        <h4 class="modal-title">Delete Product</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">					
                        <p>Are you sure you want to delete these Records?</p>
                        <p class="text-warning"><small>This action cannot be undone.</small></p>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                        <input id="deleteButton" type="submit" class="btn btn-danger" value="Delete">
                    </div>
                </div>
            </div>
        </div>
        <script src="js/manager.js" type="text/javascript"></script>
        <script>
            document.getElementById("deleteButton").addEventListener("click", function() {
                // Kích hoạt sự kiện click trên nút "buttonform"
                document.getElementById("buttonform").click();
            });
            function showModalAdd() {
                $('#addCourseModal').modal('show');
            }
            function showModalDelete() {
                $('#deleteCourseModal').modal('show');
            }
            var count = 0; var countD = true;
            var i = 0; var iD = 0;
            function showModalEdit(idGet,name,image,des,price,duration,cid,publicdate) {
                const idEdit = document.getElementById('idEdit');
                const nameEdit = document.getElementById('nameEdit');
                const imageEdit = document.getElementById('imageEdit');
                const desEdit = document.getElementById('desEdit');
                const priceEdit = document.getElementById('priceEdit');
                const nuEdit = document.getElementById('nuEdit');
                const pdEdit = document.getElementById('pdEdit');
                idEdit.value = idGet;
                nameEdit.value = name;
                imageEdit.value = image;
                priceEdit.value = parseFloat(price);
                desEdit.value = des;
                
                var numberPattern = /\d+/;
                var extractedNumber = duration.match(numberPattern);
                if (extractedNumber !== null) {
                    nuEdit.value = extractedNumber[0];
                }
                var remainingText = duration.replace(/\d+/, '');
                addOption(remainingText,"weeks");
                var publicDate = new Date(publicdate); 
                var formattedDate = publicDate.getFullYear() + '-' + String(publicDate.getMonth() + 1).padStart(2, '0') + '-' + String(publicDate.getDate()).padStart(2, '0') + 'T' + String(publicDate.getHours()).padStart(2, '0') + ':' + String(publicDate.getMinutes()).padStart(2, '0');
                pdEdit.value = formattedDate;
                var index = parseInt(cid, 10) - 1;
                var selectElement = document.getElementById("categorySelect");
                var newOption = document.createElement("option");
                newOption.value = cid;
                newOption.text = "";
                switch (index) {
                    case 0:
                        newOption.text = "Web Development";
                        break;
                    case 1:
                        newOption.text = "Data Science";
                        break;
                    case 2:
                        newOption.text = "Mobile App Development";
                        break;
                    case 3:
                        newOption.text = "Machine Learning";
                        break;
                    case 4:
                        newOption.text = "Game Development";
                        break;
                }
                                              
                if(count !== 0){
                    selectElement.remove(0);
                }
                selectElement.add(newOption, 0);
                selectElement.selectedIndex = 0;
                var optionToHide = selectElement.options[i]; 
                optionToHide.style.display = "";
                optionToHide = selectElement.options[index +1];
                optionToHide.style.display = "none";                  
                i = index+1;
                count++;         
                $('#editCourseModal').modal('show');
            }
            
            function addOption(optionValue, op) {
                var selectElement = document.getElementById("seEdit");
                selectElement.innerHTML = "";
                var option1 = document.createElement("option");            
                option1.value = "Weeks";
                option1.text = "Weeks";
                var option2 = document.createElement("option");
                option2.value = "Years";
                option2.text = "Years";
                            
                if(optionValue === " Weeks" || optionValue === " weeks"){
                   selectElement.appendChild(option1);
                   selectElement.appendChild(option2);
                }
                else if(optionValue === " Years" || optionValue === " years"){
                    selectElement.appendChild(option2);
                    selectElement.appendChild(option1);
                }	
            }

            
        </script>
    </body>
</html>
