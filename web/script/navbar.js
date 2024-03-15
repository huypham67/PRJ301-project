// navbar.js
function updateCartItemCount() {
    $.ajax({
        url: 'cartItemCountEndpoint',
        type: 'GET',
        success: function(data) {
            $(".cart-item-count").text(data);
        },
        error: function(xhr, status, error) {
            console.error('Error while updating cart item count:', error);
        }
    });
}

$(document).ready(function() {
    updateCartItemCount();
});
