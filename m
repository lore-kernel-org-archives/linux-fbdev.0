From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: Re: [PATCH v4] Frame Buffer driver for TI
	DA8xx/OMAP-L1xx
Date: Mon, 6 Jul 2009 12:45:47 +0530
Message-ID: <48900.3641218462$1246864764@news.gmane.org>
References: <1246341013-22652-1-git-send-email-sudhakar.raj@ti.com>
	<20090702214421.3a57ed92.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sudhakar.raj@ti.com>) id 1MNiRf-00067a-AW
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Jul 2009 07:16:59 +0000
Received: from comal.ext.ti.com ([198.47.26.152])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNiRa-0006E8-W2
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Jul 2009 07:16:59 +0000
In-Reply-To: <20090702214421.3a57ed92.krzysztof.h1@poczta.fm>
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
Cc: 'Steve Chen' <schen@mvista.com>, linux-fbdev-devel@lists.sourceforge.net, 'Pavel Kiryukhin' <pkiryukhin@ru.mvista.com>

On Fri, Jul 03, 2009 at 01:14:21, Krzysztof Helt wrote:
> On Tue, 30 Jun 2009 01:50:13 -0400
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
> >  Since the previous version, fb_setcolreg function has been modified for
> >  8 and 16 bit modes.
> > 
> >  drivers/video/Kconfig    |   11 +
> >  drivers/video/Makefile   |    1 +
> >  drivers/video/da8xx-fb.c |  897 ++++++++++++++++++++++++++++++++++++++++++++++
> >  include/video/da8xx-fb.h |  106 ++++++
> >  4 files changed, 1015 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/video/da8xx-fb.c
> >  create mode 100644 include/video/da8xx-fb.h
> > 
> 
> > diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> > new file mode 100644
> > index 0000000..3135234
> > --- /dev/null
> > +++ b/drivers/video/da8xx-fb.c
> > @@ -0,0 +1,897 @@
> 
> (...)
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
> > +		red >>= 4;
> > +		green >>= 4;
> > +		blue >>= 4;
> > +
> > +		pal = (red & 0x0f00);
> > +		pal |= (green & 0x00f0);
> > +		pal |= (blue & 0x000f);
> > +
> > +		palette[regno] = pal;
> > +
> 
> I am losing my patience. The shift value for the red component is right (probably as I do 
> not know the format of this palette registers). It is however almost surely wrong for other
> componets. Just put this simple example value to get almost white color:
> red = 0xf000;
> green = 0xf000;
> blue = 0xf000;
> 
> The resulting palette value would be 0xf00. Is it close to white on your controller?
> 
> Another example: blue
> red = 0;
> green = 0;
> blue = 0xff00;
> 
> The result : 0x0. It does not differ from the value for black colour (rgb = 0/0/0).
> 

I have corrected this mistake in the v5 version of the patch which I have submitted.

Thanks,
Sudhakar



------------------------------------------------------------------------------
