From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fb_imageblit()
Date: Wed, 8 Jan 2003 17:49:44 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301081746450.21171-100000@vervain.sonytel.be>
References: <1042043058.982.115.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WJPy-0004EK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Jan 2003 08:51:03 -0800
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

Bummer, /me should read the code more thoroughfully...

Perhaps renaming `{saved_,}palette' to `{saved_,}pseudo_palette' would make
this clearer...

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
