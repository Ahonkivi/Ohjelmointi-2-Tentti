<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Muuta veneen tiedot</title>
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
				<td><input type="button" id="tallenna" value="Tallenna" onclick="vieTiedot()"></td>
			</tr>
		</tbody>
	</table>
 	<input type="hidden" name="tunnus" id="tunnus"> 
</form>
<span id="ilmo"></span>
</body>
<script>

function tutkiKey(event){
	if(event.keyCode==13){//Enter
		vieTiedot();
	}		
}


document.getElementById("nimi").focus();

var tunnus = requestURLParam("tunnus"); 
fetch("veneet/haeyksi/" + tunnus,{
      method: 'GET'	      
    })
.then( function (response) {
	return response.json()
})
.then( function (responseJson) {
	console.log(responseJson);
	document.getElementById("tunnus").value = tunnus;		
	document.getElementById("nimi").value = responseJson.nimi;	
	document.getElementById("merkkimalli").value = responseJson.merkkimalli;	
	document.getElementById("pituus").value = responseJson.pituus;	
	document.getElementById("leveys").value = responseJson.leveys;
	document.getElementById("hinta").value = responseJson.hinta;
	
});	


function vieTiedot(){	
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
	console.log(formJsonStr);

	fetch("veneet",{
	      method: 'PUT',
	      body:formJsonStr
	    })
	.then( function (response) {
		return response.json();
	})
	.then( function (responseJson) {	
		var vastaus = responseJson.response;		
		if(vastaus==0){
			document.getElementById("ilmo").innerHTML= "Tietojen tallentaminen epäonnistui";
        }else if(vastaus==1){	        	
        	document.getElementById("ilmo").innerHTML= "Tietojen tallentaminen onnistui";			      	
		}	
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
	});	
	document.getElementById("tiedot").reset();
}


</script>
</html>