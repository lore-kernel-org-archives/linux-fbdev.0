From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Odd behaviour observed on fb0 (TFT LCD
	screen 800x480)
Date: Tue, 8 Jan 2008 09:39:52 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801080939290.13329@anakin>
References: <1199675857.478199d155026@discus.singnet.com.sg>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCFJL-0007lW-7x for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Jan 2008 06:20:11 -0800
Received: from harold.telenet-ops.be ([195.130.133.65])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JCFJK-0000kE-HX
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Jan 2008 06:20:11 -0800
In-Reply-To: <1199675857.478199d155026@discus.singnet.com.sg>
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
To: cksim <cksim@singnet.com.sg>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Mon, 7 Jan 2008, cksim wrote:
> Lately, I have observed an odd behviour in kernel 2.6.23.1 on a 800x480 TFT LCD unit.
> 
> The odd behviour as follows:
> 1) I am using Atmel AT91SAM9261 part. Circuit similar to that of AT91SAM9261EK evaluation board.
> 
> 2) I am booting the kernel and mounting root filesystem through NFS. Bootloader used is UBoot 1.1.5.
> 
> 3) During kernel startup, the LCD screen shows the "Penguin" logo with the other console output messages.
> 
> 4) Everything looks fine up to this point. For example, the 0,0 position of image on LCD is proper and correct.
> 
> 5) The root filesystem is then mounted through NFS and followed by a message "Freeing init memory: 106K". All this are fine.
> 
> 6) During the execution of init scripts and the login prompt, the image on the screen starts shifting (either left, right, up or down). For example, the 0,0 position of the LCD image is shifted. However, the image content is still correct.
> 
> 7) After login, this image shift behaviour still exists during normal usage.
> 
> In contrast, when using kernel 2.6.21, the image shift behaviour was not observed before the login prompt. Image shift after the login does happen occasionally but not as frequent as that seen in 2.6.23.1.
> 
> Has anyone encountered a similar image shift issue ?
> 
> Is this issue related to kernel ? It appears to me that some timing causes the image shifting.

Probably it's related to the frame buffer driver for your board.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
