From: "Sam (Uli) Freed" <sam@freed.net>
Subject: Re: Framebuffer + suspend = black screen (fwd)
Date: Wed, 30 Jul 2003 17:54:51 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3F27DC3B.5050506@freed.net>
References: <Pine.GSO.4.21.0307292343040.29365-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from line62-162.adsl.actcom.net.il ([192.115.62.162] helo=localhost)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19hsOi-0006PP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Jul 2003 07:57:48 -0700
In-Reply-To: <Pine.GSO.4.21.0307292343040.29365-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

The output I senved (blind) from DMESG is:

usb.c: USB device 7 (vend/prod 0x711/0x300) is not claimed by any active 
driver.
ehci_hcd 00:1d.7: suspend to state 3
vesafb: abort, cannot reserve video memory at 0xf0000000
vesafb: framebuffer at 0xf0000000, mapped to 0xe0edc000, size 6144k
vesafb: mode is 1024x768x32, linelength=4096, pages=9
vesafb: protected mode interface info at c000:859c
vesafb: scrolling: redraw
vesafb: directcolor: size=0:8:8:8, shift=0:16:8:0
fb1: VESA VGA frame buffer device
ehci_hcd 00:1d.7: resume
i810_audio: Primary codec has ID 0
ac97_codec: AC97 Audio codec, id: ADS116 (Unknown)
e100: eth0 NIC Link is Up 100 Mbps Full duplex

HELP!

Geert Uytterhoeven wrote:
> ---------- Forwarded message ----------
> Date: Wed, 30 Jul 2003 00:11:38 +0300
> From: "Sam (Uli) Freed" <sam@freed.net>
> To: tsbogend@alpha.franken.de, geert@linux-m68k.org
> Subject: Framebuffer + suspend = black screen
> 
> Hi,
> 
> I am installing Debian on a (very) new Toshiba laptop, details: 
> http://www.freed.net/opensource/R100.html
> 
> Running 2.4.22-pre8, I am using the framebuffer (vga=792), and use both 
> consoles and Xfree86. When I suspend, either with APM or with ACPI, upon 
> resume the screen is black, and there is a blinking cursor on the top 
> left, which seems to have reverted to some rather old mode (24x80?). 
> This problem is the same if I am in Xx or on the console. The keyboard 
> continue to work, so I can work blind if I like....
> 
> There seems to be a similar problem with the fact-usb driver (ehci-hcd) 
> losing its way during suspends, but that is not your department as such.
> 
> Please Help!
> 
> Thanks!
> 
> Sam
> 

-- 
Sam (Uli) Freed
Tel:    +972 2 652 5072 |   __o     __o      ,__o       o__,
Mobile: +972 54 925 747 |  -\<,   _`\<,_    _-\_<,     ,/_/-_
Email:   sam@freed.net  | O / O  (*)/ (*)  (*)/'(*)   (*)`\(*)



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
