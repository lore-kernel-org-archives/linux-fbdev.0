From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Driver replacement
Date: Tue, 26 Aug 2003 10:19:24 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0308261018090.615-100000@waterleaf.sonytel.be>
References: <200308252056.13587.gkajmowi@tbaytel.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19rZ47-0006Vy-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 26 Aug 2003 01:20:35 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19rZ45-0008Vu-MB
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Aug 2003 01:20:33 -0700
In-Reply-To: <200308252056.13587.gkajmowi@tbaytel.net>
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
To: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 25 Aug 2003, Garrett Kajmowicz wrote:
> I am working on a thin-client system, and ahve the following problem:
> 
> I would like to boot up using VESA, but replace the driver if other hardware 
> is supported (ie Riva TNT).  Unfortunately, from the few tests that I have 
> done, all that happens is a second fb device is created which displays to a 
> non-existant video card.  Those were the results from con2fb, anyways.

Currently it's not possible to `promote' a device to a better driver, although
it would be useful for generic drivers like  vesafb, vga16fb, and offb.

> I would consider not using VESA if there was another option (like VGA256).

http://www.google.com/search?q=vga256fb

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
