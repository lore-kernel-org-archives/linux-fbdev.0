From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fonts
Date: 22 Jan 2003 07:33:20 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043191894.1018.58.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0301211707290.24563-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18b82v-0004f9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Jan 2003 15:43:09 -0800
In-Reply-To: <Pine.GSO.4.21.0301211707290.24563-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-01-22 at 00:14, Geert Uytterhoeven wrote:
> On Wed, 15 Jan 2003, James Simmons wrote:
> > > > The cfb_imageblit() function exhibited the same behavior.  I think we
> > > > both made the wrong assumption that all monochrome bitmaps are packed. I
> > > > think the rule is:
> > > > 
> > > >     The first pixel on the next scanline is always at the next byte from
> > > >     the last pixel of the current scanline.  
> > > > 
> > > > So a 12x22 font has 16 bits per scanline but only 12 are usable, and the
> > > > last 4 are used as padding.  It's worse with a 4x6 fonts where the
> > > > 4-bits are just duplicated in the other nibble.
> > > 
> > > Yes.
> > 
> > All the font data should be packed and byte padded at the end of each 
> > scanline worth of data. Also most accel engines expect the data to byte 
> > packed.
> 
> What do you mean with `each scanline worth of data'? Data for one character, or
> data for the whole font (i.e. all characters)?

I meant for each row of bits representing a pixel in a bitmap, the start
index and the size of each row will be byte-aligned.  So, the padded
version.
> 
> Currently we use the former, while e.g. AmigaOS used the latter and stored
> fonts like this:
> 
>   - First line: concatenated bit string of the first lines of each character
>   - Second line: concatenated bit string of the second lines of each character
>   - and so on
> 
> I.e. each line looked like
> 
>     aaaaaaaaaaaabbbbbbbbbbbbccccccccccccdddddddddddd...
> 

> with a table to map between characters and starting bit index.
> 
> 
> The former has the following advantages:
>   - Character data always starts at a byte boundary
>   - It's easy to store fonts in a common format (i.e. the same for both little
>     and big endian, currently fonts are stored big endian)
> 
> The latter has the following advantages: 
>   - Less memory waste if fontwidth % 8 != 0
>   - Easy to support proportional (variable width) fonts
> 

The latter is very difficult to support by most common hardware as they
require the padding.  Actually, some, maybe most, cards require more
than a byte padding. 

If we do need to support both versions, then we need extra fields to
fb_image, such as clipx1 and clipx2, where: 

	image.clipx1 = starting index;
	image.clipx2 = clipx1 + width;

(Do we also need something similar for the y coordinate?)

Using a 12x22 font as an example:

In the first (padded) version, 

	image.width = 16;
	image.clipx1 = 0;
	image.clipx2 = 12;

whereas in the second (packed) version:

	image.width = 12;
	image.clipx1 = depends on the character;
	image.clipx2 =  image.clipx1 + image.width;

I can't really think of any other way if we need to support both types
of bitmap in a device and OS independent manner.

I think I'll let you and James decide on this :-) 

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
