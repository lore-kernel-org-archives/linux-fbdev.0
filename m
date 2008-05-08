From: Jens Rottmann <JRottmann@LiPPERT-AT.de>
Subject: Re: lxfb driver regression
Date: Thu, 08 May 2008 15:56:36 +0200
Message-ID: <48230694.5010505@LiPPERT-AT.de>
References: <20080507210836.1eb61b8f@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ju6cy-0006wh-D7 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 06:57:44 -0700
Received: from mail.lippert-at.com ([62.80.22.186]
	helo=domex.lippertembedded.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ju6cP-0003O5-BN
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 06:57:42 -0700
In-Reply-To: <20080507210836.1eb61b8f@ephemeral>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andres Salomon <dilinger@queued.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-geode@bombadil.infradead.org, linux-kernel@vger.kernel.org, jordan.crouse@amd.com, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

Hi Andres,

> Without this patch, I get the following (correct) output from the lxfb
> and console code:
> [    0.939827] lxfb 0000:00:01.1: 16384 KB of video memory at 0xfd000000
> [    1.009194] Console: switching to colour frame buffer device 150x56     

> Without it, the cols/width is screwy (and I get a blank white screen):
> [   20.706836] lxfb 0000:00:01.1: 16384 KB of video memory at 0xfd000000
> [   20.788538] Console: switching to colour frame buffer device 100x40          

I've searched all morning, but I don't get it. The only place the (changed)
pll_table[] gets used is lx_set_clock(), and this doesn't return anything at
all. lx_set_clock() gets told which dotclock to configure and it does its best
to comply, but it doesn't report back, which clock it actually was able to
select. So how on earth can changing this table cause fbcon or lxfb to decide
for a completely different videomode?? Without the patch it seems to use the
special 1200x900 OLPC DCON mode. With the patch it looks like it switches to
some 800x640 mode. No idea where this mode might come from.

And why does the lxfb init take place 20 sec later with the patch? Is there
some initrd manually setting a different mode? Is this offending 800x640 mode
maybe not coming from the kernel, but from some startup script via "fbset" and
"/etc/fb.modes"?

I don't have an OLPC, so could you please run "fbset -i -v" with and without
my patch. Hopefully this gives some clues...

I have also attached a cut down version of my patch. It still adds all the PLL
settings for < 25 MHz dotclocks, but it no longer supplements the > 25 MHz
clocks with intermediate steps. I'm only guessing here, I don't see what big
difference this would make, but still ... could you please give it a try if
you have time?

Thanks a lot for your help.

Regards,
Jens Rottmann

=============X8=================X8==============================
lxfb: extend PLL table to support dotclocks below 25 MHz

Extends the PLL frequency table of the AMD Geode-LX frame buffer
driver to make use of the DIV4 bit, thus adding support for
dotclocks between 6 and 24 MHz.  These are needed for small LCDs
(e.g. 320x240).

Signed-off-by: Jens Rottmann <JRottmann@LiPPERT-AT.de>
---

--- linux-2.6.25/drivers/video/geode/lxfb_ops.c
+++ lxfb_clocks_added/drivers/video/geode/lxfb_ops.c
@@ -34,35 +34,63 @@ static const struct {
   unsigned int pllval;
   unsigned int freq;
 } pll_table[] = {
-  { 0x000031AC, 24923 },
-  { 0x0000215D, 25175 },
-  { 0x00001087, 27000 },
-  { 0x0000216C, 28322 },
-  { 0x0000218D, 28560 },
-  { 0x000010C9, 31200 },
-  { 0x00003147, 31500 },
-  { 0x000010A7, 33032 },
-  { 0x00002159, 35112 },
-  { 0x00004249, 35500 },
-  { 0x00000057, 36000 },
-  { 0x0000219A, 37889 },
-  { 0x00002158, 39168 },
-  { 0x00000045, 40000 },
-  { 0x00000089, 43163 },
-  { 0x000010E7, 44900 },
-  { 0x00002136, 45720 },
-  { 0x00003207, 49500 },
-  { 0x00002187, 50000 },
-  { 0x00004286, 56250 },
-  { 0x000010E5, 60065 },
-  { 0x00004214, 65000 },
-  { 0x00001105, 68179 },
-  { 0x000031E4, 74250 },
-  { 0x00003183, 75000 },
-  { 0x00004284, 78750 },
-  { 0x00001104, 81600 },
-  { 0x00006363, 94500 },
-  { 0x00005303, 97520 },
+  { 0x000131AC,   6231 },
+  { 0x0001215D,   6294 },
+  { 0x00011087,   6750 },
+  { 0x0001216C,   7081 },
+  { 0x0001218D,   7140 },
+  { 0x000110C9,   7800 },
+  { 0x00013147,   7875 },
+  { 0x000110A7,   8258 },
+  { 0x00012159,   8778 },
+  { 0x00014249,   8875 },
+  { 0x00010057,   9000 },
+  { 0x0001219A,   9472 },
+  { 0x00012158,   9792 },
+  { 0x00010045,  10000 },
+  { 0x00010089,  10791 },
+  { 0x000110E7,  11225 },
+  { 0x00012136,  11430 },
+  { 0x00013207,  12375 },
+  { 0x00012187,  12500 },
+  { 0x00014286,  14063 },
+  { 0x000110E5,  15016 },
+  { 0x00014214,  16250 },
+  { 0x00011105,  17045 },
+  { 0x000131E4,  18563 },
+  { 0x00013183,  18750 },
+  { 0x00014284,  19688 },
+  { 0x00011104,  20400 },
+  { 0x00016363,  23625 },
+  { 0x000031AC,  24923 },
+  { 0x0000215D,  25175 },
+  { 0x00001087,  27000 },
+  { 0x0000216C,  28322 },
+  { 0x0000218D,  28560 },
+  { 0x000010C9,  31200 },
+  { 0x00003147,  31500 },
+  { 0x000010A7,  33032 },
+  { 0x00002159,  35112 },
+  { 0x00004249,  35500 },
+  { 0x00000057,  36000 },
+  { 0x0000219A,  37889 },
+  { 0x00002158,  39168 },
+  { 0x00000045,  40000 },
+  { 0x00000089,  43163 },
+  { 0x000010E7,  44900 },
+  { 0x00002136,  45720 },
+  { 0x00003207,  49500 },
+  { 0x00002187,  50000 },
+  { 0x00004286,  56250 },
+  { 0x000010E5,  60065 },
+  { 0x00004214,  65000 },
+  { 0x00001105,  68179 },
+  { 0x000031E4,  74250 },
+  { 0x00003183,  75000 },
+  { 0x00004284,  78750 },
+  { 0x00001104,  81600 },
+  { 0x00006363,  94500 },
+  { 0x00005303,  97520 },
   { 0x00002183, 100187 },
   { 0x00002122, 101420 },
   { 0x00001081, 108000 },
@@ -137,7 +165,7 @@ static void lx_set_clock(struct fb_info
 	unsigned int diff, min, best = 0;
 	unsigned int freq, i;

-	freq = (unsigned int) (0x3b9aca00 / info->var.pixclock);
+	freq = (unsigned int) (1000000000 / info->var.pixclock);

 	min = abs(pll_table[0].freq - freq);

@@ -149,7 +177,7 @@ static void lx_set_clock(struct fb_info
 		}
 	}

-	lx_set_dotpll(pll_table[best].pllval & 0x7FFF);
+	lx_set_dotpll(pll_table[best].pllval & 0x00017FFF);
 }

 static void lx_graphics_disable(struct fb_info *info)


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
