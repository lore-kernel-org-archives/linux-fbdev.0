From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fb_imageblit()
Date: Thu, 9 Jan 2003 10:50:06 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301091038390.25052-100000@vervain.sonytel.be>
References: <1042043058.982.115.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WZM0-0005DV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Jan 2003 01:52:00 -0800
In-Reply-To: <1042043058.982.115.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On 9 Jan 2003, Antonino Daplas wrote:
> On Wed, 2003-01-08 at 23:15, Geert Uytterhoeven wrote:
> > > c. Read color information from pseudopalette if directcolor/truecolor. 
> > 
> > Hoever, pseudopalette has entries for the first 16 colors only!
> > Hence you are limited to the 16 color for directcolor/truecolor modes.
> 
> That's why there's an fb_set_logo_directpalette(), for directcolor
> visuals >= 24bpp, and fb_set_logo_truepalette(), for truecolor, in
> fb_set_logo().  Basically, it temporarily replaces info->pseudo_palette
> with one that has 256 entries to match linux_logo.  Logo drawing, using
> cfb_imageblit() has always worked for me in directcolor and truecolor
> modes.

I see a small inconsistency here, which may cause problems with some exotic
hardware: info->pseudo_palette is always initialized by the fbdev driver itself
(which knows the hardware), except for logo drawing, where it's done by the
generic code in fbmem.

On virtually all hardware that will work fine. But on some hardware the exact
pixel format cannot be represented by the {red,green,blue,transp} bitfields in
fb_var_screeninfo.

E.g. the Amiga CyberVision64 card has a S3Trio64. Since Amigas are little
endian and PCI is big endian, they swapped the data bus to simplify 256-color
modes. However, this also means that 16-bit pixel values have to be swapped. So
in depth 15, the pixel format is not ARRRRRGGGGGBBBBB, but GGGBBBBBARRRRRGG.
This can be handled fine in cyberfb by setting up a byteswapped pseudo palette,
but the fb_set_logo_{direct,true}palette() don't know about this. And of course
user space doesn't know about this neither.

One possible solution is to extend the pseudo palette to 256+1 entries if the
depth is at least 8. To save memory, we can still use a 16+1 entry pseudo
palette if depth < 8, but then we have to move the cursor inversion value from
index 16 to index -1.

Note that the old logo code suffered from the same problem and cyberfb hasn't
been updated since a while (it lacks pseudo palette support), so it may not be
that important. I just wanted to mention this case.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
