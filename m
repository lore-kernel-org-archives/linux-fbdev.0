From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: New logo code [CONFIG OPTIONS]
Date: Mon, 17 Feb 2003 11:36:51 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0302171135100.16817-100000@vervain.sonytel.be>
References: <20030215153154.GB469@schottelius.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18kiet-00077D-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Feb 2003 02:37:59 -0800
In-Reply-To: <20030215153154.GB469@schottelius.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nico Schottelius <schottelius@wdt.de>
Cc: Torrey Hoffman <thoffman@arnor.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Sat, 15 Feb 2003, Nico Schottelius wrote:
> I think if the patch and the features talked about are included in the
> kernel we'll have (names are not correct)
> 
> CONFIG_LOGO=y/n
> CONFIG_LOGO_XRES=128
> CONFIG_LOGO_YRES=64
> CONFIG_LOGO_BPP=8

The 3 above are stored in struct linux_logo.

> CONFIG_LOGO_PATH="" # (/usr/src/linux/.../logo/tux.pnm)
> CONFIG_LOGO_POS_X="left|center|right"  # or absolute ?
> CONFIG_LOGO_POS_Y="top|center|bottom"  # like X windows +110,+200 ?
> CONFIG_LOGO_BGCOL=#ef0000              # depends on bpp of framebuffer... 

I prefer to store the background color in struct linux_logo as well. And it
must be a palette index, not an RGB triplet, I think.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
