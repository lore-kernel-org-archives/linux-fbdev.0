From: James Simmons <jsimmons@infradead.org>
Subject: Re: fonts
Date: Wed, 15 Jan 2003 00:34:22 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301150032350.23774-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0301121221140.18673-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18YbWE-0004lA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Jan 2003 16:34:59 -0800
In-Reply-To: <Pine.GSO.4.21.0301121221140.18673-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> > The cfb_imageblit() function exhibited the same behavior.  I think we
> > both made the wrong assumption that all monochrome bitmaps are packed. I
> > think the rule is:
> > 
> >     The first pixel on the next scanline is always at the next byte from
> >     the last pixel of the current scanline.  
> > 
> > So a 12x22 font has 16 bits per scanline but only 12 are usable, and the
> > last 4 are used as padding.  It's worse with a 4x6 fonts where the
> > 4-bits are just duplicated in the other nibble.
> 
> Yes.

All the font data should be packed and byte padded at the end of each 
scanline worth of data. Also most accel engines expect the data to byte 
packed.

> But that was not my problem. Currently accel_putcs() falls back to individual
> character drawing if the fontwidth is not a multiple of 8, and reuses the same
> struct fb_image for each call of fb_imageblit(). And since my fb_imageblit()
> had a loop like `while (image->height--) { ... }' it failed. Not modifying the
> passed struct fb_image fixed the problem. Yes, we need the const there :-)

I guess I need to change that in the next set of changes.



-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
