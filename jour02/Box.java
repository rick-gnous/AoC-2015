public class Box {
        private int l, w, h;

        public Box (int l, int w, int h) {
                this.l = l;
                this.w = w;
                this.h = h;
        }

        public int getSurface() {
                return 2*(this.l*this.w + this.w*this.h + this.h*this.l);
        }

        public int areaSmallSurface() {
                int wl = this.w * this.l;
                int wh = this.w * this.h;
                int lh = this.l * this.h;

                int ret = wl >= wh ? wh : wl;

                if (ret > lh)
                        ret = lh;

                return ret;
        }
}
