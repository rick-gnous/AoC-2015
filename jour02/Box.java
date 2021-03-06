public class Box {
        private int l, w, h;

        /**
         * Constructeur de boite
         *
         * @param l longueur
         * @param w largeur
         * @param h hauteur
         */
        public Box (int l, int w, int h) {
                this.l = l;
                this.w = w;
                this.h = h;
        }

        /**
         * Calcule la surface de la boite.
         *
         * @return la surface de la boite
         */
        public int getSurface() {
                return 2*(this.l*this.w + this.w*this.h + this.h*this.l);
        }

        /**
         * Trouve et renvoi la plus petite surface de la boite
         *
         * @return la plus petite surface de la boite
         */
        public int areaSmallSurface() {
                // pour faire + jolie
                int wl = this.w * this.l;
                int wh = this.w * this.h;
                int lh = this.l * this.h;

                int ret = wl >= wh ? wh : wl;

                if (ret > lh)
                        ret = lh;

                return ret;
        }

        public int calculateRibbon() {
                int wl = 2 * (this.w + this.l);
                int wh = 2 * (this.w + this.h);
                int lh = 2 * (this.h + this.l);

                int ret = wl >= wh ? wh : wl;

                if (ret > lh)
                        ret = lh;

                ret += this.w * this.l * this.h;
                return ret;
        }
}
