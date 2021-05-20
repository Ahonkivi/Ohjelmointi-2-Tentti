package model;

public class Vene {
		
		private String nimi, merkkimalli;
		private double pituus, leveys;
		private int hinta, tunnus;
		public int getTunnus() {
			return tunnus;
		}
		public void setTunnus(int tunnus) {
			this.tunnus = tunnus;
		}
		public Vene(String nimi, String merkkimalli, double pituus, double leveys, int hinta, int tunnus) {
			super();
			this.nimi = nimi;
			this.merkkimalli = merkkimalli;
			this.pituus = pituus;
			this.leveys = leveys;
			this.hinta = hinta;
			this.tunnus = tunnus;
		}
		
		public Vene() {
			super();
			
		}
		@Override
		public String toString() {
			return "Vene [nimi=" + nimi + ", merkkimalli=" + merkkimalli + ", pituus=" + pituus + ", leveys=" + leveys
					+ ", hinta=" + hinta + ", tunnus=" + tunnus + "]";
		}
		public String getNimi() {
			return nimi;
		}
		public void setNimi(String nimi) {
			this.nimi = nimi;
		}
		public String getMerkkimalli() {
			return merkkimalli;
		}
		public void setMerkkimalli(String merkkimalli) {
			this.merkkimalli = merkkimalli;
		}
		public double getPituus() {
			return pituus;
		}
		public void setPituus(double pituus) {
			this.pituus = pituus;
		}
		public double getLeveys() {
			return leveys;
		}
		public void setLeveys(double leveys) {
			this.leveys = leveys;
		}
		public int getHinta() {
			return hinta;
		}
		public void setHinta(int hinta) {
			this.hinta = hinta;
		}
}
