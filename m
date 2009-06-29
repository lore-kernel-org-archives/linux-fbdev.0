From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: Re: [PATCH v3] Frame Buffer driver for TI
	DA8xx/OMAP-L1xx
Date: Mon, 29 Jun 2009 19:53:53 +0530
Message-ID: <25970.5757526264$1246285625@news.gmane.org>
References: <1245841101-3095-1-git-send-email-sudhakar.raj@ti.com>
	<20090626071855.22518d52.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sudhakar.raj@ti.com>) id 1MLHn5-0004cF-Uu
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jun 2009 14:25:03 +0000
Received: from comal.ext.ti.com ([198.47.26.152])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MLHn4-0006Zj-GC
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jun 2009 14:25:03 +0000
In-Reply-To: <20090626071855.22518d52.krzysztof.h1@poczta.fm>
Content-Language: en-us
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: 'Krzysztof Helt' <krzysztof.h1@poczta.fm>
Cc: 'Steve Chen' <schen@mvista.com>, davinci-linux-open-source@linux.davincidsp.com, linux-fbdev-devel@lists.sourceforge.net, 'Pavel Kiryukhin' <pkiryukhin@ru.mvista.com>

Krzysztof,

> -----Original Message-----
> From: Krzysztof Helt [mailto:krzysztof.h1@poczta.fm]
> Sent: Friday, June 26, 2009 10:49 AM
> To: Rajashekhara, Sudhakar
> Cc: linux-fbdev-devel@lists.sourceforge.net; davinci-linux-open-
> source@linux.davincidsp.com; Steve Chen; Pavel Kiryukhin
> Subject: Re: [Linux-fbdev-devel] [PATCH v3] Frame Buffer driver for TI
> DA8xx/OMAP-L1xx
> 
> On Wed, 24 Jun 2009 06:58:21 -0400
> "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com> wrote:
> 
> > Adds LCD controller (LCDC) driver for TI's DA8xx/OMAP-L1xx architecture.
> > LCDC specifications can be found at http://www.ti.com/litv/pdf/sprufm0a.
> >
> > LCDC on DA8xx consists of two independent controllers, the Raster Controller
> > and the LCD Interface Display Driver (LIDD) controller. LIDD further supports
> > character and graphic displays.
> >
> > This patch adds support for the graphic display (Sharp LQ035Q3DG01) found on
> > the DA830 based EVM. The EVM details can be found at:
> > http://support.spectrumdigital.com/boards/dskda830/revc/.
> >
> > Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
> > Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
> > Signed-off-by: Steve Chen <schen@mvista.com>
> > ---
> >  Since the previous version, error paths in probing function has been
> >  corected, removed set_par() function and added code in fb_setcolreg()
> >  function for TRUECOLOR mode.
> >
> >  drivers/video/Kconfig    |   11 +
> >  drivers/video/Makefile   |    1 +
> >  drivers/video/da8xx-fb.c |  887 ++++++++++++++++++++++++++++++++++++++++++++++
> >  include/video/da8xx-fb.h |  106 ++++++
> >  4 files changed, 1005 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/video/da8xx-fb.c
> >  create mode 100644 include/video/da8xx-fb.h
> >
> > diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> > new file mode 100644
> > index 0000000..a41ae62
> > --- /dev/null
> > +++ b/drivers/video/da8xx-fb.c
> > @@ -0,0 +1,887 @@
> 
> (fast forward)
> 
> > +
> > +static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
> > +			      unsigned blue, unsigned transp,
> > +			      struct fb_info *info)
> > +{
> > +	struct da8xx_fb_par *par = info->par;
> > +	unsigned short *palette = (unsigned short *)par->v_palette_base;
> > +	u_short pal;
> > +
> > +	if (regno > 255)
> > +		return 1;
> > +
> > +	if (info->fix.visual == FB_VISUAL_DIRECTCOLOR)
> > +		return 1;
> > +
> > +	if (info->var.bits_per_pixel == 8) {
> > +		red >>= 8;
> > +		green >>= 8;
> > +		blue >>= 8;
> 
> This function is still incorrect. Each color component value passed to the
> function is 16 bit.
> 
> I assume you have 16-bit word for each palette entry and you want
> to pack 4-bit colors like this 0RGB. The shift should be
> 
> red >>= 12;
> 
> so you reduced the component length to 4 bits then
> 
> red <<= 8;
> 
> so it is put on correct position in the palette entry.
> You fold these two shifts so it is
> 
> red >>= 4;
> 
> The same logic should be used for all color components.
> 
> > +
> > +		pal = (red & 0x0f00);
> > +		pal |= (green & 0x00f0);
> > +		pal |= (blue & 0x000f);
> > +
> > +		palette[regno] = pal;
> > +
> > +	} else if ((info->var.bits_per_pixel == 16) && regno < 16) {
> > +		memset(palette, 0, 16);
> 
> I do not understand what is achieved by zeroing the palette area.
> 
> This is what you should use:
> 
> red >>= (16 - info->var.red.len)
> red <<= info->var.red.offset;
> 
> The same logic should be used for all color components.
> Then pack them into palette register:
> 
> par->pseudo_palette[ regno ] = red | green | blue;
> 
> The true color modes do not use the palette entry. I assume
> that the value below forces controller to use true color mode.
> 
> > +		palette[0] = 0x4000;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> Regards,
> Krzysztof

I'll test the driver with the modifications suggested by you
and will submit the updated version of the patch tomorrow.

Thanks, Sudhakar



------------------------------------------------------------------------------
