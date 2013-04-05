From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 05 Apr 2013 08:02:57 +0000
Subject: Re: [PATCH RESEND] fbmon: use VESA_DMT_VSYNC_HIGH to fix typo
Message-Id: <002601ce31d3$fc25cfc0$f4716f40$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <8984685.165951364521249756.JavaMail.weblogic@epml18>
 <515E75BC.20604@ti.com>
In-Reply-To: <515E75BC.20604@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, FlorianSchandinat@gmx.de, s.trumtrar@pengutronix.de, plagnioj@jcrosoft.com, 'Jingoo Han' <jg1.han@samsung.com>

On Friday, April 05, 2013 3:57 PM, Tomi Valkeinen wrote:
> 
> Hi,
> 
> On 2013-03-29 03:40, Jingoo Han wrote:
> > VESA_DMT_VSYNC_HIGH should be used instead of VESA_DMT_HSYNC_HIGH,
> > because FB_SYNC_VERT_HIGH_ACT is related to vsync, not to hsync.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> >  drivers/video/fbmon.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
> > index 94ad0f7..7f67099 100644
> > --- a/drivers/video/fbmon.c
> > +++ b/drivers/video/fbmon.c
> > @@ -1400,7 +1400,7 @@ int fb_videomode_from_videomode(const struct videomode *vm,
> >  	fbmode->vmode = 0;
> >  	if (vm->dmt_flags & VESA_DMT_HSYNC_HIGH)
> >  		fbmode->sync |= FB_SYNC_HOR_HIGH_ACT;
> > -	if (vm->dmt_flags & VESA_DMT_HSYNC_HIGH)
> > +	if (vm->dmt_flags & VESA_DMT_VSYNC_HIGH)
> >  		fbmode->sync |= FB_SYNC_VERT_HIGH_ACT;
> >  	if (vm->data_flags & DISPLAY_FLAGS_INTERLACED)
> >  		fbmode->vmode |= FB_VMODE_INTERLACED;
> 
> I'll apply this to fbdev fixes.

Oh, thank you. :)

Best regards,
Jingoo Han

> 
>  Tomi
> 
> 


