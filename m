From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 07/17] bf54x-lq043fb: Framebuffer
 driver for Blackfin BF54x framebuffer device driver
Date: Sat, 29 Sep 2007 11:17:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0709291116460.10965@anakin>
References: <46FDAAD1.6070700@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbYSJ-0003Io-TG for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 29 Sep 2007 02:17:48 -0700
Received: from asia.telenet-ops.be ([195.130.137.74])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbYSI-0000rV-Er
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 29 Sep 2007 02:17:47 -0700
In-Reply-To: <46FDAAD1.6070700@gmail.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Bryan Wu <bryan.wu@analog.com>, Michael Hennerich <michael.hennerich@analog.com>

On Sat, 29 Sep 2007, Antonino A. Daplas wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Blackfin BF54x framebuffer device driver for a SHARP LQ043T1DG01 TFT LCD
> 
> [adaplas]
> Add 'fb' suffix to driver name.

Won't work though if you forget to rename the actual source file:

>  drivers/video/bf54x-lq043.c                   |  786 +++++++++++++++++++++++++

> +obj-$(CONFIG_FB_BF54X_LQ043)	  += bf54x-lq043fb.o

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
