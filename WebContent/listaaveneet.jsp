<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Veneohjelma</title>

</head>
<body onkeydown="tutkiKey(event)">

<table id="listaus">
	<thead>
		<tr> 
			<th colspan="5" id="ilmo"></th>
			<th colspan= "2"><a id="uusiVene" href="lisaavene.jsp"> Uusi vene</a></th>
		</tr>	
		<tr>
			<th >Hakusana:</th>
			<th colspan="4"><input type="text" id="hakusana"></th>
			<th colspan="2"><input type="button" value="Hae" id="hakunappi" onclick="haeTiedot()"></th>
		</tr>
		<tr>
			<th>Nimi</th>
			<th>Merkki</th>
			<th>Pituus</th>
			<th>Leveys</th>
			<th>Hinta</th>
			
			<th colspan="2">Muutokset</th>
		</tr>
	</thead>
	<tbody id="tbody">
	</tbody>
</table>

<script>

haeTiedot();	
document.getElementById("hakusana").focus();//vied��n kursori hakusana-kentt��n sivun latauksen yhteydess�

function tutkiKey(event){
	if(event.keyCode==13){//Enter
		haeTiedot();
	}		
}
//Funktio tietojen hakemista varten
//GET   /autot/{hakusana}
function haeTiedot(){	
	document.getElementById("tbody").innerHTML = "";
	fetch("veneet/" + document.getElementById("hakusana").value,{
	      method: 'GET'
	    })
	.then(function (response) {
			return response.json()	
	})
	.then(function (responseJson) {	
		var veneet = responseJson.veneet;
		console.log(veneet);
		var htmlStr="";
		for(var i=0;i<veneet.length;i++){
			console.log(veneet[i]);
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+veneet[i].nimi+"</td>";
        	htmlStr+="<td>"+veneet[i].merkkimalli+"</td>";
        	htmlStr+="<td>"+veneet[i].pituus+"</td>";
        	htmlStr+="<td>"+veneet[i].leveys+"</td>";  
        	htmlStr+="<td>"+veneet[i].hinta+"</td>";
        	htmlStr+="<td><a href='muutavene.jsp?tunnus="+veneet[i].tunnus+"'>Muuta</a>&nbsp;";
        	htmlStr+="<td><span class='poista' onclick=poista('"+veneet[i].tunnus+"')>Poista</span></td>";
        	htmlStr+="</tr>";        	
		}
		document.getElementById("tbody").innerHTML = htmlStr;		
	})	
}

function poista(tunnus){
	if(confirm("Poista vene " + tunnus +"?")){	
		fetch("veneet/"+ tunnus,{
		      method: 'DELETE'		      	      
		    })
		.then(function (response) {
			return response.json()
		})
		.then(function (responseJson) {	
			var vastaus = responseJson.response;		
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML= "Veneen poisto epäonnistui.";
	        }else if(vastaus==1){	        	
	        	document.getElementById("ilmo").innerHTML="Veneen " + tunnus +" poisto onnistui.";
				haeTiedot();        	
			}	
			setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
		})		
	}	
}


</script>


</body>
</html>