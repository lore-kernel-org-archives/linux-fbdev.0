From: Rabin Vincent <rabin@rab.in>
Date: Tue, 25 Oct 2011 07:46:03 +0000
Subject: fb_setcolreg(), CNVT_TOHW() and chan_to_field()
Message-Id: <20111025073349.GB6027@debian>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

I'm trying to figure out the best way to implement fb_setcolreg() for
FB_VISUAL_TRUECOLOR.

14 or so drivers copy/paste the CNVT_TOHW from skeletonfb.c:

 #define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)
 ...
 red = CNVT_TOHW(red, info->var.red.length);

Another 18 or so drivers copy/paste a chan_to_field() function which has
a straightforward shift:

 static inline u_int chan_to_field(u_int chan, struct fb_bitfield *bf)
 {
 	chan &= 0xffff;
 	chan >>= 16 - bf->length;
 	return chan << bf->offset;
 }
 ...
 val = chan_to_field(red, &info->var.red);

Both methods return similar values, except that with CNVT_TOHW() the
extreme values seem to have a smaller range than the other values, while
with the chan_to_field() shift all the values have an equal range.

What's the reason behind choosing one over the other?  Could/should a
common function be provided for all the drivers to use?
