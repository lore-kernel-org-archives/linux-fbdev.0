From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: [PATCH]: image.depth fix to accomodate
	monochrome cards
Date: 09 Jan 2003 00:25:53 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042043062.1003.116.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0301081045090.21171-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WJCu-0000d4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Jan 2003 08:37:33 -0800
In-Reply-To: <Pine.GSO.4.21.0301081045090.21171-100000@vervain.sonytel.be>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-01-08 at 17:52, Geert Uytterhoeven wrote:
> On 8 Jan 2003, Antonino Daplas wrote:
> > On Wed, 2003-01-08 at 05:06, Geert Uytterhoeven wrote: 
> > > On 8 Jan 2003, Antonino Daplas wrote:
> > > > 2.  diff submitted by Geert: cleaner logo data preparation for
> > > > monochrome cards and correct initialization of palette_cmap.transp.
> > > 
> > > I'll have to do some more fixes there, since the monochrome logo is used not
> > > only on monochrome displays, but on all other displays with bits_per_pixel < 4
> > > Since the pixel data in fb_image are colormap indices, they have to reflect the
> > > correct `black' and `white' colors on such displays.
> > > 
> > > E.g. on amifb (which supports all bits_per_pixel from 1 through 8) the logo
> > > showed up in black-and-blue with bits_per_pixel == 3, cfr. the first two
> > > entries of {red,green,blue}8[] in fbcmap.c.
> > > 
> > 
> > Hmm, I see.  I think only linux_logo_bw will be the only one affected,
> > since linux_logo_16 happens to match the console palette and in
> > linux_logo, we either reset the palette and/or the cmap.
> 
> Indeed.
> 
> > Would expanding each bit to the full bit depth work?  Ie for bpp=8 using
> > monochrome data, white is 0 and black is 0xff.
> 
> For bpp=8 that won't work, since we have 16 console colors only :-)
> 

Of course :-)

> But for bpp=[1-3] that's OK, cfr. fbcmap.c.
> 
> BTW, perhaps it makes sense to just pass the appropriate `black' and `white'
> pixel values to the logo conversion routine? Preferably through a 2-element
> array, so we can index it with the logo data bit value instead of using
> tests/branches. Then we'd have:
> 

Something like this?

static void fb_set_logo(struct fb_info *info, u8 *logo, int needs_logo)
{
	int i, j;
	u8 mask[2] = {0,0};

	switch (needs_logo) {
	case 4:
		for (i = 0; i < (LOGO_W * LOGO_H)/2; i++) { 
			logo[i*2] = linux_logo16[i] >> 4;
			logo[(i*2)+1] = linux_logo16[i] & 0xf;
		}
		break;
	case 1:
	case ~1:
		mask[1] = (u8) ~(BIT_SHIFT(0xffff, info->var.bits_per_pixel));
		for (i = 0; i < (LOGO_W * LOGO_H)/8; i++) {
		       u8 d = linux_logo_bw[i];
                       for (j = 0; j < 8; j++, d <<= 1)
                               logo[i*8+j] = mask[((d ^ needs_logo) >> 7) & 1];
		}
		break;
	}
}

Tony



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
