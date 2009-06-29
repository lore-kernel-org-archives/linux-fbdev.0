From: "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [Linux-fbdev-devel] [PATCH v3] Frame Buffer driver for TI
	DA8xx/OMAP-L1xx
Date: Mon, 29 Jun 2009 19:53:53 +0530
Message-ID: <12385.1201766685$1246285529@news.gmane.org>
References: <1245841101-3095-1-git-send-email-sudhakar.raj@ti.com>
	<20090626071855.22518d52.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20090626071855.22518d52.krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
Content-Language: en-us
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Content-Type: text/plain; charset="us-ascii"
To: 'Krzysztof Helt' <krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, 'Pavel Kiryukhin' <pkiryukhin-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>

Krzysztof,

> -----Original Message-----
> From: Krzysztof Helt [mailto:krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org]
> Sent: Friday, June 26, 2009 10:49 AM
> To: Rajashekhara, Sudhakar
> Cc: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; davinci-linux-open-
> source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; Steve Chen; Pavel Kiryukhin
> Subject: Re: [Linux-fbdev-devel] [PATCH v3] Frame Buffer driver for TI
> DA8xx/OMAP-L1xx
> 
> On Wed, 24 Jun 2009 06:58:21 -0400
> "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org> wrote:
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
> > Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Pavel Kiryukhin <pkiryukhin-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> > Signed-off-by: Steve Chen <schen-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
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
