From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Question] Colour management
Date: Sat, 31 Jul 2004 18:26:27 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407311826.27332.adaplas@hotpop.com>
References: <20040722184937.GA11361@sci.fi> <200407260647.03489.adaplas@hotpop.com> <200407302012.36325.alex.kern@gmx.de>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bqr6K-0000Dn-77
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 03:28:28 -0700
Received: from smtp-out1.hotpop.com ([38.113.3.51] helo=snickers.hotpop.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bqr6J-0002q0-Cr
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 03:28:28 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id A986570E0B
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 31 Jul 2004 09:14:49 +0000 (UTC)
In-Reply-To: <200407302012.36325.alex.kern@gmx.de>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Alexander Kern <alex.kern@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, Ville =?iso-8859-15?q?Syrj=E4l=E4?= <syrjala@sci.fi>

On Saturday 31 July 2004 02:12, Alexander Kern wrote:
> Hallo Tony,
>
> can you explain the deep mining of fb_setcolreg. Background, I observe
> wrong palette using in 15 and 16 bpp modes, but can not understand, what is
> the right approach. In both cases from penguin logo I can see only contour
> in honey yellow and blue vertical string jsimmons, pretty scury ;-) The
> rest is black! The simple text or ncurses applications have always right
> colours. Additionally and only by 16bpp fbi shows blurry images. In 15bpp
> fbi works fine. fbtest works fine and his penguins look good in all
> resolutions ?!

This will need a long answer. (For mistakes or ommisions, please let me know)

fb_setcolreg has 2 functions, initialize info->pseudopalette (if needed) and
initialize the hardware CLUT (if needed).  To do this properly, the driver
must set several variables and correctly advertise these variables using
various fields in struct fb_info.  These fields are:

1. info->var.bits_per_pixel
This is self-explanatory.  bits_per_pixel is _not_ the color depth.  

2. info->fix.visual
The field 'visual' has information on the following:

	a. if the hardware CLUT can be set or not

	If the CLUT can be set, then visual is either DIRECTCOLOR or
PSEUDOCOLOR. Otherwise, use TRUECOLOR, STATIC_PSEUDOCOLOR or MONO01/MONO02.

	b. If the pixel has separate information for all channels
	 (red, green, blue)

	Pseudocolor type visuals can only control a set of R, G, and
B.  Truecolor or directcolor have bitfields assigned for each color channel. 
Monocolor is assumed to be static pseudocolor where color depth == 1.

3. info->var.{red|green|blue|transp}
	These fields determine the depth and arrangement of each channel.  For
pseudocolor type visuals, all offsets are equal to zero and all lengths are
set to the same value (6 for 64-color EGA type framebuffer, 8 for 256-color
framebuffer)

	For truecolor or directcolor, the offsets are assigned different values.
So for RGB555, all lengths are assigned a value of 5 and offsets are at 0, 5 
and 10 respectiviely.

	This is where the color depth can be determined.  The color depth is not
necessarily equal to bits_per_pixel.  So for RGB555, the color depth is 15
(sum of all offsets) but bits_per_pixel is 16. For pseudocolor type, the
color depth == length of any of the channels.  (This is the reason I submitted a
patch that differentiates between color depth and bits_per_pixel).

4. info->cmap
	The struct cmap is the software representation of the hardware ClUT.  This 
is important to user apps.  Note, setting the cmap is important only for visuals where
the hardware CLUT is settable.  If the hardware CLUT is not settable (truecolor, etc),
then the app must get a copy of the cmap and only use the entries there.  However, most
user app probably ignore this and just attempt to pass its own copy of the cmap to
the driver.  Most of the time it works, but can break for some weird hardware.  For,
example, some mono framebuffer use 0 for white and 1 for black.  Fortunately, we have
a simple way of checking this by using info->fix.visuals.

Finally, we go to fb_setcolreg.  I mentioned the above because they are all needed
for fb_setcolreg to function properly. Its 2 main functions are:

1. initialize info->pseudopalette.

The pseudopalette is only used by the console, and is not even seen by userspace.
Furthermore, the pseudopalette is used only when in truecolor or directcolor mode
and is only 16 entries long (to match console palette).

Setting the pseudopalette depends on the visual.  In truecolor mode, the pseudocode
is something like this:

pseudopalette[index] = (red & redmask) << offset | (green & greenmask) << offset |
			(blue & bluemask) << offset;

*The mask is determined by the {red|green|blue}.length and offset by 
{red|green|blue}.offset.

In directcolor, it's easier:

pseudopalette[index] = (index << red.offset) | (index << green.offset) |
			 (index << blue.offset);

2. Setting the hardware ClUT.
	This is very driver dependent, but most drivers will follow
the description below.

	(This is needed only on pseudocolor and directcolor mode, since
they are the only visuals where the hardware CLUT can be set.  However,
some drivers still set the CLUT even in truecolor.  This does not really
matter since the hardware will probably just ignore those commands).

	Setting the CLUT is easy when in pseudocolor, or in directcolor
where channel size == CLUT register size. Basically:

red_reg[index] = red;
green_reg[index] = green;
blue_reg[index] = blue;

	In directcolor mode where the channel size != CLUT register size, setting
the CLUT is a bit tricky. 

Take for example, RGB555. Assuming an 8-bit CLUT size, each channel can only
accept a total of 32 entries (2 power of 5).  Since an 8-bit CLUT has 256 entries,
then the driver needs to step by 8 (256/32).  The code is like this then:

red_reg[index * 8] = red
green_reg[index * 8] = green
blue_reg[index * 8] = blue

Some hardware require that all 8 entries needs to be filled up.  Visually
this will look something like this:

reg	R G B
--------------
0	0 0 0 << (index * step) 
1	0 0 0
2  	0 0 0
3	0 0 0
4	0 0 0
5	0 0 0
6	0 0 0 
7	0 0 0
8	1 1 1 
9	1 1 1
10	1 1 1
11	1 1 1	
12	1 1 1
13	1 1 1
14	1 1 1
15	1 1 1

This even gets trickier in RGB565 since red and blue has 32 entries
with stepping 8 and green has 64 with a stepping 4. 

red_reg[index * 8] = red
green_reg[index * 4] = green
blue_reg[index * 8] = blue

Reg 	R G B
--------------
0	0 0 0
1	0 0 0
2  	0 0 0
3	0 0 0
4	0 1 0 << index * 4 for green
5	0 1 0
6	0 1 0 
7	0 1 0
8	1 2 1 << index * 8 for red and blue
9	1 2 1
10	1 2 1
11	1 2 1	
12	1 3 1
13	1 3 1
14	1 3 1
15	1 3 1

As you can see from the above, greens are interspersed with the reds and 
blues.

(For actual code examples, see i810fb)

So how to diagnose:

1. wrong console colors, correct colors in userspace apps:

This is easy.  Basically, the driver sets almost everything correctly.
If the console colors are wrong then most probably this is due to 
setting the pseudopalette incorrectly:

	a. Hardware is in truecolor, but pseudopalette is set
	directcolor style, or vice versa. This is actually a very common
	error.

	b, Driver uses software functions (cfb_*) but pseudopalette
	is set at (u16 *).  All cfb_* functions assume a pseudopalette
	to be (u32*) whatever the value of color depth or bits_per_pixel is.

	c. Driver uses it's own broken drawing functions.

2. correct console colors, incorrect colors with userspace apps:

Driver side:
	a. Is info->visuals set correctly? (Do not set DIRECTCOLOR if
	hardware can only due TRUECOLOR)

	b. Are the fields info->var.{red|green|blue} set correctly?  This
	is what the app uses to differentiate between RGB565 vs RGB555,
	for example.

	c. Is info->var.bits_per_pixel set correctly?  RGB555 is still 16,
	not 15.

	d. Is the driver setting the hardware CLUT correctly?  Very common
	error, especially with directcolor RGB565 or RGB555. See above how
	the CLUT should be set.

Client side:
	a. Does the application know the difference between directcolor and
	truecolor?  Drawing truecolor pixels in a directcolor framebuffer will
	usually produce wrong colors.

	b. Does the application know how to derive the information from the
	fields in info->var.{red|green|blue}?

	c. Is the cmap set properly by the driver when in directcolor or pseudocolor?
	Not setting the cmap means hardware might use 'stale' values in its table.

	d. Does the application's rasterizing function work correctly?  Drawing
	in 24 bits per pixel is a little difficult compared to 16 or 32 bits.

3. wrong colors everywhere

	Basically just check everything.

>
> P.S. where is our current tree of fbdev changes?

James is the maintainer of fbdev.  However, the tree has not been updated
for a long time.  Most developers also submit changes to Andrew, so just 
check the mm tree for now until James can get enough time to fix the fbdev
tree.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
