<!--
* @package    PagHiper Pix Opencart
* @version    1.0
* @license    BSD License (3-clause)
* @copyright  (c) 2020
* @link       https://www.paghiper.com/
* @dev        Bruno Alencar - Loja5.com.br
-->

<script>
function processar_pagamento_paghiperpix() {
	<?php if(!$fiscal_valido){ ?>
	//pega a e valido o fiscal
	var fiscal = $('#fiscal').val();
	var fiscal_valido = validarCpfCnpj(fiscal);
	if(!fiscal_valido){
		$('#fiscal').focus();
		alert('Digite o CPF/CNPJ correto para continuar o pagamento!');
		return false;
	}
	<?php }else{ ?>
	var fiscal = '<?php echo $fiscal;?>';
	<?php } ?>
	//processa o pedido <?php echo var_dump($fiscal_valido);?>
	$('#button-confirm').attr("disabled","disabled");
	$.ajax({
		type: 'POST',
		dataType: "JSON",
		data: {fiscal: fiscal},
		url: 'index.php?route=extension/payment/paghiperpix/confirm',
		cache: false,
		success: function(resultado) {
			console.log(resultado);
			if(resultado.erro==true){
				$('#button-confirm').removeAttr("disabled");
				alert(resultado.log);
			}else{
				location.href = (resultado.cupom).replace(/&amp;/g, '&');
			}
			return false;
		}
	});
	return false;
}
function isNumberKey(evt) {
	var charCode = (evt.which) ? evt.which : event.keyCode
	if (charCode > 31 && (charCode < 48 || charCode > 57)){
		return false;
	}
	return true;
}
function validaCPF(s) {
	var c = s.substr(0,9);
	var dv = s.substr(9,2);
	var d1 = 0;
	for (var i=0; i<9; i++) {
		d1 += c.charAt(i)*(10-i);
 	}
	if (d1 == 0) return false;
	d1 = 11 - (d1 % 11);
	if (d1 > 9) d1 = 0;
	if (dv.charAt(0) != d1){
		return false;
	}
	d1 *= 2;
	for (var i = 0; i < 9; i++)	{
 		d1 += c.charAt(i)*(11-i);
	}
	d1 = 11 - (d1 % 11);
	if (d1 > 9) d1 = 0;
	if (dv.charAt(1) != d1){
		return false;
	}
    return true;
}
function validaCNPJ(CNPJ) {
	var a = new Array();
	var b = new Number;
	var c = [6,5,4,3,2,9,8,7,6,5,4,3,2];
	for (i=0; i<12; i++){
		a[i] = CNPJ.charAt(i);
		b += a[i] * c[i+1];
	}
	if ((x = b % 11) < 2) { a[12] = 0 } else { a[12] = 11-x }
	b = 0;
	for (y=0; y<13; y++) {
		b += (a[y] * c[y]);
	}
	if ((x = b % 11) < 2) { a[13] = 0; } else { a[13] = 11-x; }
	if ((CNPJ.charAt(12) != a[12]) || (CNPJ.charAt(13) != a[13])){
		return false;
	}
	return true;
}

function validarCpfCnpj(valor) {
	var s = (valor).replace(/\D/g,'');
	var tam=(s).length;
	if (!(tam==11 || tam==14)){
		return false;
	}
	if (tam==11 ){
		if (!validaCPF(s)){
			return false;
		}
		return true;
	}		
	if (tam==14){
		if(!validaCNPJ(s)){
			return false;			
		}
		return true;
	}
}
</script>

<style>
.tela_pagamento_paghiperpix {
	width:40%;
}
@media screen and (max-width: 600px) {
  .input_100P {
	width:100% !important;
  }
  .tela_pagamento_paghiperpix {
	width:100%;
  }
}
</style>

<div class="panel panel-default tela_pagamento_paghiperpix pull-right">
<div class="panel-body">
<form id="paghiperpix-form">

<div class="form-group">
<label class="control-label">&nbsp;</label>
<p class="form-control-static">
<img style="max-width: 100% !important;" src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEASABIAAD/4TIiaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/Pgo8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjMtYzAxMSA2Ni4xNDU2NjEsIDIwMTIvMDIvMDYtMTQ6NTY6MjcgICAgICAgICI+CiAgIDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+CiAgICAgIDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiCiAgICAgICAgICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyI+CiAgICAgICAgIDx4bXA6Q3JlYXRvclRvb2w+QWRvYmUgRmlyZXdvcmtzIENTNiAoV2luZG93cyk8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgICAgPHhtcDpDcmVhdGVEYXRlPjIwMjAtMTItMDdUMTQ6MDc6MDZaPC94bXA6Q3JlYXRlRGF0ZT4KICAgICAgICAgPHhtcDpNb2RpZnlEYXRlPjIwMjAtMTItMDdUMTQ6MDg6NTdaPC94bXA6TW9kaWZ5RGF0ZT4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgICAgIDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyI+CiAgICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2UvanBlZzwvZGM6Zm9ybWF0PgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/Pv/bAEMABgQEBAUEBgUFBgkGBQYJCwgGBggLDAoKCwoKDBAMDAwMDAwQDA4PEA8ODBMTFBQTExwbGxscICAgICAgICAgIP/bAEMBBwcHDQwNGBAQGBoVERUaICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIP/AABEIAEUBLAMBEQACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAAAAwQFBgcCCAH/xABLEAABAwMCBAMFBgIECA8AAAABAgMEAAURBhIHEyExFCJBFTJCUWEII1JxgZEkoRYlM1MXGDZDYnKCsVVzdJKToqOys8HC0dLT8f/EABsBAQADAQEBAQAAAAAAAAAAAAADBAUCAQYH/8QANBEAAgECBAQCCgIDAQEBAAAAAAECAxEEEiExBRMiUUFhFCMycYGRobHB8EJiFdHx4VJy/9oADAMBAAIRAxEAPwD1TQBQBQBQBQBQBQBQBQBQBQBQBQBQBQBQBQBQBQBQBQHLrrTLS3XVhtpsFTjijhKUjqSSegAFEgQdo13pC8XFy3Wu6sTJbTZeWhokjlpIBVvxsOCR2NT1MLUgryVkQwxEJOyd2K2LWelb8ootF0jzHU9SyhY5mB67DhWPrivKuHqQ9pNHsK0J7O5M1CShQBQBQBQBQBQBQBQBQBQBQBQBQFI4w6suWmNGOXC2Ohiet9phhwpSvG4lSvKsEe6g1e4fQVWpaW1irjKrpwutzI7JxA4+3yIZlp5kyKlZbLrcWNt3gAke59RWvUwmEg7S0fvZmwxGJkrrX4IWb418UtM3VEfVcIPIOFLjvsCO4UZ7tLQEp/XBFc/42hUj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"/>
</p>
</div>

<?php if($fiscal_valido){ ?>
<div class="form-group">
<label class="control-label"><b>CPF/CNPJ:</b></label>
<input type="text" maxlength="14" value="<?php echo $fiscal;?>" class="input_100P form-control" id="fiscal" name="fiscal" readonly />
</div>
<?php }else{ ?>
<div class="form-group">
<label class="control-label"><b>CPF/CNPJ:</b></label>
<input type="text" onkeypress="return isNumberKey(event)" maxlength="14" value="<?php echo $fiscal;?>" class="input_100P form-control" id="fiscal" name="fiscal" />
</div>
<?php } ?>

<span class="buttons">
<button type="button" class="button btn btn-success pull-right" onclick="processar_pagamento_paghiperpix()" id="button-confirm"><i class="fa fa-check"></i> Confirmar Pedido</button>
</span>

</form>
</div>
</div>