From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: funny framebuffer fonts on PowerBook with radeonfb
Date: Mon, 27 Mar 2006 09:19:55 +0800
Message-ID: <44273DBB.9070207@gmail.com>
References: <20060327004741.GA19187@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751228AbWC0BUn@vger.kernel.org>
In-Reply-To: <20060327004741.GA19187@MAIL.13thfloor.at>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel ML <linux-kernel@vger.kernel.org>

Herbert Poetzl wrote:
> Hey Ben!
> 
> 2.6.16 and 2.6.15-something show a funny behaviour
> when using the radeonfb driver (for text mode), they
> kind of twist and break the fonts in various places
> some characters or parts seem to be mirrored like
> '[' becoming ']' but not on character boundary but
> more on N pixels, colors seem to be correct for the
> characters, and sometimes the font is perfectly fine
> for larger runs, e.g. I can read the logon prompt
> fine, but everything I type is garbled ...
> 
> just for an example, when I type 'echo "Test"' then
> all characters are mirrored and cut off on the right
> side but the locations are as shown above, on enter
> the T is only a few pixels wide, but the est part is
> written perfectly fine ... this is a new behaviour
> and going back to 2.6.13.3 doesn't show this ...
> 
> if there is some testing I can do for you, or when
> you need more info, please let me know. here a few
> details for the machine:
> 

What font are you using? I presume the dimensions are
not divisible by 8.  Can you try this patch?

Tony

diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
index 910e233..8ba6152 100644
--- a/drivers/video/cfbimgblt.c
+++ b/drivers/video/cfbimgblt.c
@@ -169,7 +169,7 @@ static inline void slow_imageblit(const 
 
 		while (j--) {
 			l--;
-			color = (*s & 1 << (FB_BIT_NR(l))) ? fgcolor : bgcolor;
+			color = (*s & (1 << l)) ? fgcolor : bgcolor;
 			val |= FB_SHIFT_HIGH(color, shift);
 			
 			/* Did the bitshift spill bits to the next long? */
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 17fc771..4fe1d2d 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -841,12 +841,10 @@ struct fb_info {
 #define FB_LEFT_POS(bpp)          (32 - bpp)
 #define FB_SHIFT_HIGH(val, bits)  ((val) >> (bits))
 #define FB_SHIFT_LOW(val, bits)   ((val) << (bits))
-#define FB_BIT_NR(b)              (7 - (b))
 #else
 #define FB_LEFT_POS(bpp)          (0)
 #define FB_SHIFT_HIGH(val, bits)  ((val) << (bits))
 #define FB_SHIFT_LOW(val, bits)   ((val) >> (bits))
-#define FB_BIT_NR(b)              (b)
 #endif
 
     /*
