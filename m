From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Framebuffer + suspend = black screen (fwd)
Date: Wed, 30 Jul 2003 22:46:30 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0307302245580.29569-100000@vervain.sonytel.be>
References: <3F27DC3B.5050506@freed.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19hxqo-0003kV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Jul 2003 13:47:10 -0700
In-Reply-To: <3F27DC3B.5050506@freed.net>
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
To: "Sam (Uli) Freed" <sam@freed.net>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 30 Jul 2003, Sam (Uli) Freed wrote:
> The output I senved (blind) from DMESG is:
> 
> usb.c: USB device 7 (vend/prod 0x711/0x300) is not claimed by any active 
> driver.
> ehci_hcd 00:1d.7: suspend to state 3
> vesafb: abort, cannot reserve video memory at 0xf0000000
> vesafb: framebuffer at 0xf0000000, mapped to 0xe0edc000, size 6144k
> vesafb: mode is 1024x768x32, linelength=4096, pages=9
> vesafb: protected mode interface info at c000:859c
> vesafb: scrolling: redraw
> vesafb: directcolor: size=0:8:8:8, shift=0:16:8:0
> fb1: VESA VGA frame buffer device
> ehci_hcd 00:1d.7: resume
> i810_audio: Primary codec has ID 0
> ac97_codec: AC97 Audio codec, id: ADS116 (Unknown)
> e100: eth0 NIC Link is Up 100 Mbps Full duplex

What's your fb0?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
