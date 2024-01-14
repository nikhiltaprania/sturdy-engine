<c:if test="${not empty message}">
    <div id="toast">${message}</div>

    <script type="text/javascript">
        showToast();

        function showToast(content) {
            $('#toast').addClass("display");
            $('#toast').html(content);
            setTimeout(() => {
                $("#toast").removeClass("display");
            }, 5000);
        }
    </script>

    <c:remove var="message" scope="session"/>
</c:if>
