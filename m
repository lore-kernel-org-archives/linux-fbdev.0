From: Andres Salomon <dilinger@queued.net>
Subject: Re: lxfb driver regression
Date: Mon, 12 May 2008 18:51:48 -0400
Message-ID: <20080512185148.104fc4c3@ephemeral>
References: <20080507210836.1eb61b8f@ephemeral>
	<48230694.5010505@LiPPERT-AT.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jvgo2-00036Q-Qr for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 May 2008 15:47:42 -0700
Received: from mail.queued.net ([207.210.101.209])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jvgo1-0008Ml-EO
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 May 2008 15:47:42 -0700
In-Reply-To: <48230694.5010505@LiPPERT-AT.de>
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
To: Jens Rottmann <JRottmann@LiPPERT-AT.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-geode@bombadil.infradead.org, linux-kernel@vger.kernel.org, jordan.crouse@amd.com, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

On Thu, 08 May 2008 15:56:36 +0200
Jens Rottmann <JRottmann@LiPPERT-AT.de> wrote:

> Hi Andres,
> 
[...]
> 
> I have also attached a cut down version of my patch. It still adds
> all the PLL settings for < 25 MHz dotclocks, but it no longer
> supplements the > 25 MHz clocks with intermediate steps. I'm only
> guessing here, I don't see what big difference this would make, but
> still ... could you please give it a try if you have time?
> 

Sorry for the delay, I got around to testing this today.  It works
much better on an XO, so I've ack'd it.

Since updating to -rc2, I'm unable to reproduce the strange mode
setting differences; the original patch, reverting the original
patch, and also applying the new patch now all show:

[    1.005011] Console: switching to colour frame buffer device 150x56


> Thanks a lot for your help.
> 
> Regards,
> Jens Rottmann
> 
> =============X8=================X8==============================
> lxfb: extend PLL table to support dotclocks below 25 MHz
> 
> Extends the PLL frequency table of the AMD Geode-LX frame buffer
> driver to make use of the DIV4 bit, thus adding support for
> dotclocks between 6 and 24 MHz.  These are needed for small LCDs
> (e.g. 320x240).
> 
> Signed-off-by: Jens Rottmann <JRottmann@LiPPERT-AT.de>


Acked-by: Andres Salomon <dilinger@debian.org>


> ---
> 
> --- linux-2.6.25/drivers/video/geode/lxfb_ops.c
> +++ lxfb_clocks_added/drivers/video/geode/lxfb_ops.c
> @@ -34,35 +34,63 @@ static const struct {
>    unsigned int pllval;
>    unsigned int freq;
>  } pll_table[] = {
> -  { 0x000031AC, 24923 },
> -  { 0x0000215D, 25175 },
> -  { 0x00001087, 27000 },
> -  { 0x0000216C, 28322 },
> -  { 0x0000218D, 28560 },
> -  { 0x000010C9, 31200 },
> -  { 0x00003147, 31500 },
> -  { 0x000010A7, 33032 },
> -  { 0x00002159, 35112 },
> -  { 0x00004249, 35500 },
> -  { 0x00000057, 36000 },
> -  { 0x0000219A, 37889 },
> -  { 0x00002158, 39168 },
> -  { 0x00000045, 40000 },
> -  { 0x00000089, 43163 },
> -  { 0x000010E7, 44900 },
> -  { 0x00002136, 45720 },
> -  { 0x00003207, 49500 },
> -  { 0x00002187, 50000 },
> -  { 0x00004286, 56250 },
> -  { 0x000010E5, 60065 },
> -  { 0x00004214, 65000 },
> -  { 0x00001105, 68179 },
> -  { 0x000031E4, 74250 },
> -  { 0x00003183, 75000 },
> -  { 0x00004284, 78750 },
> -  { 0x00001104, 81600 },
> -  { 0x00006363, 94500 },
> -  { 0x00005303, 97520 },
> +  { 0x000131AC,   6231 },
> +  { 0x0001215D,   6294 },
> +  { 0x00011087,   6750 },
> +  { 0x0001216C,   7081 },
> +  { 0x0001218D,   7140 },
> +  { 0x000110C9,   7800 },
> +  { 0x00013147,   7875 },
> +  { 0x000110A7,   8258 },
> +  { 0x00012159,   8778 },
> +  { 0x00014249,   8875 },
> +  { 0x00010057,   9000 },
> +  { 0x0001219A,   9472 },
> +  { 0x00012158,   9792 },
> +  { 0x00010045,  10000 },
> +  { 0x00010089,  10791 },
> +  { 0x000110E7,  11225 },
> +  { 0x00012136,  11430 },
> +  { 0x00013207,  12375 },
> +  { 0x00012187,  12500 },
> +  { 0x00014286,  14063 },
> +  { 0x000110E5,  15016 },
> +  { 0x00014214,  16250 },
> +  { 0x00011105,  17045 },
> +  { 0x000131E4,  18563 },
> +  { 0x00013183,  18750 },
> +  { 0x00014284,  19688 },
> +  { 0x00011104,  20400 },
> +  { 0x00016363,  23625 },
> +  { 0x000031AC,  24923 },
> +  { 0x0000215D,  25175 },
> +  { 0x00001087,  27000 },
> +  { 0x0000216C,  28322 },
> +  { 0x0000218D,  28560 },
> +  { 0x000010C9,  31200 },
> +  { 0x00003147,  31500 },
> +  { 0x000010A7,  33032 },
> +  { 0x00002159,  35112 },
> +  { 0x00004249,  35500 },
> +  { 0x00000057,  36000 },
> +  { 0x0000219A,  37889 },
> +  { 0x00002158,  39168 },
> +  { 0x00000045,  40000 },
> +  { 0x00000089,  43163 },
> +  { 0x000010E7,  44900 },
> +  { 0x00002136,  45720 },
> +  { 0x00003207,  49500 },
> +  { 0x00002187,  50000 },
> +  { 0x00004286,  56250 },
> +  { 0x000010E5,  60065 },
> +  { 0x00004214,  65000 },
> +  { 0x00001105,  68179 },
> +  { 0x000031E4,  74250 },
> +  { 0x00003183,  75000 },
> +  { 0x00004284,  78750 },
> +  { 0x00001104,  81600 },
> +  { 0x00006363,  94500 },
> +  { 0x00005303,  97520 },
>    { 0x00002183, 100187 },
>    { 0x00002122, 101420 },
>    { 0x00001081, 108000 },
> @@ -137,7 +165,7 @@ static void lx_set_clock(struct fb_info
>  	unsigned int diff, min, best = 0;
>  	unsigned int freq, i;
> 
> -	freq = (unsigned int) (0x3b9aca00 / info->var.pixclock);
> +	freq = (unsigned int) (1000000000 / info->var.pixclock);
> 
>  	min = abs(pll_table[0].freq - freq);
> 
> @@ -149,7 +177,7 @@ static void lx_set_clock(struct fb_info
>  		}
>  	}
> 
> -	lx_set_dotpll(pll_table[best].pllval & 0x7FFF);
> +	lx_set_dotpll(pll_table[best].pllval & 0x00017FFF);
>  }
> 
>  static void lx_graphics_disable(struct fb_info *info)
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
