From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH]: image.depth fix to accomodate monochrome cards
Date: Tue, 7 Jan 2003 22:06:44 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301072201350.21057-100000@vervain.sonytel.be>
References: <1041956124.974.9.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W0x0-0004WJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 13:07:54 -0800
In-Reply-To: <1041956124.974.9.camel@localhost.localdomain>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 8 Jan 2003, Antonino Daplas wrote:
> 2.  diff submitted by Geert: cleaner logo data preparation for
> monochrome cards and correct initialization of palette_cmap.transp.

I'll have to do some more fixes there, since the monochrome logo is used not
only on monochrome displays, but on all other displays with bits_per_pixel < 4
Since the pixel data in fb_image are colormap indices, they have to reflect the
correct `black' and `white' colors on such displays.

E.g. on amifb (which supports all bits_per_pixel from 1 through 8) the logo
showed up in black-and-blue with bits_per_pixel == 3, cfr. the first two
entries of {red,green,blue}8[] in fbcmap.c.

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
