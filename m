From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: New logo code (fwd)
Date: Wed, 5 Feb 2003 13:37:44 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0302051336170.16681-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0301281606580.9269-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18gOop-0001eW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Feb 2003 04:38:24 -0800
In-Reply-To: <Pine.GSO.4.21.0301281606580.9269-100000@vervain.sonytel.be>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Tue, 28 Jan 2003, Geert Uytterhoeven wrote:
> On Sun, 12 Jan 2003, Geert Uytterhoeven wrote:
> > The current logo code is messy, complex, and inflexible. So I decided to
> > rewrite it. My goals were:
> >   - Logos must be accessible easily by an image editor (currently: hex C source
> >     data must be converted to another format first)
> >   - Logos must be stored in ASCII-form in the source tree
> >   - Support arbitrary logo sizes (currently: fixed 80x80)
> >   - Allow the logo to be selected statically (at compile time) and/or
> >     dynamically (at run-time, based on machine type) (currently: at compile
> >     time only).
> >   - Allow simple adition of new logos
> >   - Support grayscale logos (not used yet)
> > 
> > The patch achieves all of these. Logos are stored in ASCII PNM format in
> > drivers/video/logo/, and automatically converted to hex C source arrays using
> > scripts/pnmtologo. I chose ASCII PNM because (a) it's ASCII, (b) it's very
> > simple to parse without an external library (XPM is more difficult to parse),
> > and (c) it can be handled by many image manipulation programs.
> > 
> > Code that wants to display a logo just calls fb_find_logo(), specifying the
> > wanted logo type, and receives a pointer to a suitable logo (or NULL).
> > 
> > I also modified fb_show_logo() to return the number of scanlines that are used
> > by the logo, so fbcon knows how many lines to reserve.
> 
> I put a new version at
> 
>     http://home.tvd.be/cr26864/Linux/fbdev/linux-logo-2.5.59.diff.bz2
> 
> Changes:
>   - Merge with 2.5.59
>   - New logo (CLUT224 only) for PA-RISC
>   - Let hgafb and newport_con include logo sources directly, since they need
>     access to the logos in non-init code
> 
> All comments are welcomed! Thanks!

Come on, is there really no one to comment on this??

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
