From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fonts
Date: Wed, 22 Jan 2003 10:23:51 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301221021210.10208-100000@vervain.sonytel.be>
References: <1043191894.1018.58.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18bH88-00062D-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 22 Jan 2003 01:25:08 -0800
In-Reply-To: <1043191894.1018.58.camel@localhost.localdomain>
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

On 22 Jan 2003, Antonino Daplas wrote:
> On Wed, 2003-01-22 at 00:14, Geert Uytterhoeven wrote:
> > On Wed, 15 Jan 2003, James Simmons wrote:
> > > > > The cfb_imageblit() function exhibited the same behavior.  I think we
> > > > > both made the wrong assumption that all monochrome bitmaps are packed. I
> > > > > think the rule is:
> > > > > 
> > > > >     The first pixel on the next scanline is always at the next byte from
> > > > >     the last pixel of the current scanline.  
> > > > > 
> > > > > So a 12x22 font has 16 bits per scanline but only 12 are usable, and the
> > > > > last 4 are used as padding.  It's worse with a 4x6 fonts where the
> > > > > 4-bits are just duplicated in the other nibble.
> > > > 
> > > > Yes.
> > > 
> > > All the font data should be packed and byte padded at the end of each 
> > > scanline worth of data. Also most accel engines expect the data to byte 
> > > packed.
> > 
> > What do you mean with `each scanline worth of data'? Data for one character, or
> > data for the whole font (i.e. all characters)?
> 
> I meant for each row of bits representing a pixel in a bitmap, the start
> index and the size of each row will be byte-aligned.  So, the padded
> version.

  [...]

> The latter is very difficult to support by most common hardware as they
> require the padding.  Actually, some, maybe most, cards require more
> than a byte padding. 

  [...]

> If we do need to support both versions, then we need extra fields to
> fb_image, such as clipx1 and clipx2, where: 
> 
> 	image.clipx1 = starting index;
> 	image.clipx2 = clipx1 + width;
> 
> (Do we also need something similar for the y coordinate?)

Or add sx and sy, cfr fb_copyarea. Makes clipping behave the same for both.

> I think I'll let you and James decide on this :-) 

I'm happy with the current scheme. I just wanted to be 100% what James meant
with `All the font data should be packed and byte padded at the end of each 
scanline worth of data.'.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
