<style>
    body {
        font-family: Arial, sans-serif; 
        background-color: #f2f2f2;
    }

    #checkoutForm {
        max-width: 1200px; 
        margin: 0 auto; 
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px; 
        background-color: #fff; 
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    }

    .form-group {
        margin-bottom: 5px;
        display: flex; 
        align-items: center;
    }

    label {
        margin-bottom: 2px;
        margin-right: 10px;
        font-weight: bold; 
        flex: 1;
        max-width: 25%;
    }

    input[type="text"],
    input[type="email"] {
        padding: 5px; 
        border: 1px solid #ccc;
        border-radius: 5px; 
        box-sizing: border-box; 
        flex: 3; 
        max-width: 75%; 
        font-family: Arial, sans-serif; 
        font-size: 14px;
    }

    h4 {
        font-family: Arial, sans-serif;
        font-size: 20px; 
        margin-bottom: 5px;
    }
</style>

<div style="padding-top: 80px">
    <form id="checkoutForm" action="cart-check-out" method="post"> 
        <div>						
            <h4>Your information</h4>
        </div>
        <div>
            <div class="form-group">
                <label for="name">Full Name:</label>
                <input type="text" id="name" name="name" placeholder="Enter your full name">
            </div>
            <div class="form-group">
                <label for="phone">Phone Number:</label>
                <input type="text" id="phone" name="phone" placeholder="Enter your phone number">
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" placeholder="Enter your address">
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="Enter your email address">
            </div>
        </div>
    </form>
</div>
