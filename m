From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Framebuffer + suspend = black screen (fwd)
Date: Tue, 29 Jul 2003 23:43:36 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0307292343040.29365-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19hcGY-0008SR-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Jul 2003 14:44:18 -0700
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Sam (Uli) Freed" <sam@freed.net>, tsbogend@alpha.franken.de

---------- Forwarded message ----------
Date: Wed, 30 Jul 2003 00:11:38 +0300
From: "Sam (Uli) Freed" <sam@freed.net>
To: tsbogend@alpha.franken.de, geert@linux-m68k.org
Subject: Framebuffer + suspend = black screen

Hi,

I am installing Debian on a (very) new Toshiba laptop, details: 
http://www.freed.net/opensource/R100.html

Running 2.4.22-pre8, I am using the framebuffer (vga=792), and use both 
consoles and Xfree86. When I suspend, either with APM or with ACPI, upon 
resume the screen is black, and there is a blinking cursor on the top 
left, which seems to have reverted to some rather old mode (24x80?). 
This problem is the same if I am in Xx or on the console. The keyboard 
continue to work, so I can work blind if I like....

There seems to be a similar problem with the fact-usb driver (ehci-hcd) 
losing its way during suspends, but that is not your department as such.

Please Help!

Thanks!

Sam

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
