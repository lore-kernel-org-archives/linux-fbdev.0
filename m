From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [linux-2.6.7] Bootup logo patch
Date: Wed, 4 Aug 2004 23:26:01 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0408042324040.15861@waterleaf.sonytel.be>
References: <200408031854.23635@brute.world.of.dreams>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BsTH1-0007a3-90
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Aug 2004 14:26:11 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BsTH0-0007ah-Mo
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Aug 2004 14:26:11 -0700
In-Reply-To: <200408031854.23635@brute.world.of.dreams>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Piotr Horzycki <mediaworks@tlen.pl>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 3 Aug 2004, Piotr Horzycki wrote:
> The purpose of this patch is to add a possibility of applying custom
> 224-color bootup image without overwriting the existing ones. User
> needs to create a separate PPM file
> (drivers/video/logo/logo_custom_clut224.ppm), which will be
> automatically converted to .c and then linked. I needed to alter the
> Makefile to add the .o file, and Kconfig to allow enabling the new

While it sounds interesting to have this feature, I'm a bit afraid about its
implementation. In the current state, an `allyesconfig' kernel will fail to
build, since drivers/video/logo/logo_custom_clut224.ppm is missing by default.

> feature during kernel configuration. I added short help for CONFIG_LOGO

Thanks for the help text!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
