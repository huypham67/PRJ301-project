        <div style="padding-top: 20px">
        
        <div id="popup" class="popup">
            <div>
                <div class="popup-content">
                    <form id="checkoutForm" action="cart-check-out" method="post"> 
                        <div>						
                            <h4>Checkout</h4>
                            <button type="button" onclick="closePopup()" class="close-btn" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div>
                            <div class="form-group">
                                <label for="name">Full Name:</label><br>
                                <input type="text" id="name" name="name">
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone Number:</label><br>
                                <input type="text" id="phone" name="phone">
                            </div>
                            <div class="form-group">
                                <label for="address">Address:</label><br>
                                <input type="text" id="address" name="address">
                            </div>
                            <div class="form-group">
                                <label for="email">Email:</label><br>
                                <input type="email" id="email" name="email">
                            </div>
                            <div>
                                <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                <input type="submit" class="btn btn-success" value="SEND/CHECKOUT">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
