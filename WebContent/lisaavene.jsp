<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="scripts/main.js"></script>
<title>Lisää vene</title>
</head>
<body onkeydown="tutkiKey(event)">

<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="4" id="ilmo"></th>
				<th colspan="6" class="oikealle"><a href="listaaveneet.jsp" id="takaisin">Takaisin listaukseen</a></th>
			</tr>		
			<tr>
				<th>Nimi</th>
				<th>Merkki</th>
				<th>Pituus</th>
				<th>Leveys</th>
				<th>Hinta</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="nimi" id="nimi"></td>
				<td><input type="text" name="merkkimalli" id="merkkimalli"></td>
				<td><input type="text" name="pituus" id="pituus"></td>
				<td><input type="text" name="leveys" id="leveys"></td>
				<td><input type="text" name="hinta" id="hinta"></td>
				<td><input type="button" name="nappi" id="tallenna" value="Lisää" onclick="lisaaTiedot()"></td>
			</tr>
		</tbody>
	</table>
</form>

<span id="ilmo"></span>
</body>

<script>

function tutkiKey(event){
	if(event.keyCode==13){//Enter
		lisaaTiedot();
	}
	
};

document.getElementById("tunnus").focus();

	function lisaaTiedot() {	
		var ilmo="";
		if(document.getElementById("nimi").value.length<1){
			ilmo="Nimi ei kelpaa!";		
		}else if(document.getElementById("merkkimalli").value.length<2){
			ilmo="Merkki ja malli ei kelpaa!";		
		}else if(document.getElementById("pituus").value.length<2){
			ilmo="Pituus ei kelpaa!";		
		}else if(document.getElementById("leveys").value.length<3){
			ilmo="Leveys ei ole kelpaa!";		
		}else if(document.getElementById("hinta").value.length<3){
			ilmo="Hinta ei ole kelpaa!";		
		}
		if(ilmo!=""){
			document.getElementById("ilmo").innerHTML=ilmo;
			setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 3000);
			return;
		}
		document.getElementById("nimi").value=siivoa(document.getElementById("nimi").value);
		document.getElementById("merkkimalli").value=siivoa(document.getElementById("merkkimalli").value);
		document.getElementById("pituus").value=siivoa(document.getElementById("pituus").value);
		document.getElementById("leveys").value=siivoa(document.getElementById("leveys").value);
		document.getElementById("hinta").value=siivoa(document.getElementById("hinta").value);	
			
		var formJsonStr=formDataToJSON(document.getElementById("tiedot")); 
		
		fetch("veneet",{
		      method: 'POST',
		      body:formJsonStr
		    })
		.then( function (response) {		
			return response.json()
		})
		.then( function (responseJson) {
			var vastaus = responseJson.response;		
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML= "Veneen lisääminen epäonnistui";
	      	}else if(vastaus==1){	        	
	      		document.getElementById("ilmo").innerHTML= "Veneen lisääminen onnistui";			      	
			}
			setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
		});	
		document.getElementById("tiedot").reset();
	}

</script>

</html> 