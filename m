From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fonts
Date: Tue, 21 Jan 2003 17:14:13 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301211707290.24563-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0301150032350.23774-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18b143-0004S4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Jan 2003 08:15:51 -0800
In-Reply-To: <Pine.LNX.4.44.0301150032350.23774-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 15 Jan 2003, James Simmons wrote:
> > > The cfb_imageblit() function exhibited the same behavior.  I think we
> > > both made the wrong assumption that all monochrome bitmaps are packed. I
> > > think the rule is:
> > > 
> > >     The first pixel on the next scanline is always at the next byte from
> > >     the last pixel of the current scanline.  
> > > 
> > > So a 12x22 font has 16 bits per scanline but only 12 are usable, and the
> > > last 4 are used as padding.  It's worse with a 4x6 fonts where the
> > > 4-bits are just duplicated in the other nibble.
> > 
> > Yes.
> 
> All the font data should be packed and byte padded at the end of each 
> scanline worth of data. Also most accel engines expect the data to byte 
> packed.

What do you mean with `each scanline worth of data'? Data for one character, or
data for the whole font (i.e. all characters)?

Currently we use the former, while e.g. AmigaOS used the latter and stored
fonts like this:

  - First line: concatenated bit string of the first lines of each character
  - Second line: concatenated bit string of the second lines of each character
  - and so on

I.e. each line looked like

    aaaaaaaaaaaabbbbbbbbbbbbccccccccccccdddddddddddd...

with a table to map between characters and starting bit index.


The former has the following advantages:
  - Character data always starts at a byte boundary
  - It's easy to store fonts in a common format (i.e. the same for both little
    and big endian, currently fonts are stored big endian)

The latter has the following advantages: 
  - Less memory waste if fontwidth % 8 != 0
  - Easy to support proportional (variable width) fonts

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
