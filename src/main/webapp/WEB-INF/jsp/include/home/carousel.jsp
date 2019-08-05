<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<div id="carousel-of-product" class="carousel-of-product carousel slide"
	data-ride="carousel">
	<!-- Indicators -->
	<ol class="carousel-indicators center-block" style="width: 10%;">
		<li data-target="#carousel-of-product" data-slide-to="0"
			class="active"></li>
		<li data-target="#carousel-of-product" data-slide-to="1"></li>
		<li data-target="#carousel-of-product" data-slide-to="2"></li>
		<li data-target="#carousel-of-product" data-slide-to="3"></li>
	</ol>

	<!-- Wrapper for slides -->
	<div class="carousel-inner" role="listbox"
		style="position: relative; left: 200px; width: 72%;">
		<a href="forebook?bid=7324" class="item active"> <img width="100%"
			class="carousel carouselImage" src="img/lunbo/1.jpg">
			<div class="carousel-caption" style="color: #000;">
        愿有趣的灵魂 终能相遇
      </div>
		</a> <a href="forebook?bid=7323" class="item"> <img width="100%"
			class="carouselImage" src="img/lunbo/2.jpg">
			<div class="carousel-caption" style="color: #000;">
        中国安文化
      </div>
		</a> <a href="forebook?bid=7325" class="item"> <img width="100%"
			class="carouselImage" src="img/lunbo/3.jpg">
			<div class="carousel-caption" style="color: #000;">
        小妇人
      </div>
		</a> <a href="forebook?bid=7326" class="item"> <img width="100%"
			class="carouselImage" src="img/lunbo/4.jpg">
			<div class="carousel-caption" style="color: #000;">
        老人与海
      </div>
		</a>

	</div>

</div>

<script>
	$("#carousel-of-product")
			.on(
					"slide.bs.carousel",
					function(event) {
						var $hoder = $("#carousel-of-product").find(".item"), $items = $(event.relatedTarget);
						var getIndex = $hoder.index($items);
						// 						alert(getIndex); $("div.categoryWithCarousel")
						if (0 == getIndex)
							$("div.categoryWithCarousel").css(
									"background-color", "#E6D4B0");
						if (1 == getIndex)
							$("div.categoryWithCarousel").css(
									"background-color", "#0A0A0A");
						if (2 == getIndex)
							$("div.categoryWithCarousel").css(
									"background-color", "#D79886");
						if (3 == getIndex)
							$("div.categoryWithCarousel").css(
									"background-color", "#ffffff");
					})
</script>


