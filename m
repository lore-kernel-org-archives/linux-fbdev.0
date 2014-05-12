From: Alexander Stein <alexander.stein@systec-electronic.com>
Date: Mon, 12 May 2014 06:17:19 +0000
Subject: Re: [PATCH v3] video: mx3fb: Add backlight control support
Message-Id: <11210402.Xc9TuleuM4@ws-stein>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1399559916-15183-1-git-send-email-alexander.stein@systec-electronic.com>
In-Reply-To: <1399559916-15183-1-git-send-email-alexander.stein@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Friday 09 May 2014 12:11:29, Tomi Valkeinen wrote:
> On 08/05/14 17:38, Alexander Stein wrote:
> > This patch add backlight control support to allow dimming the backlight
> > using the internal PWM. Currently the brightness is set fixed to a
> > maximum of 255.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> > ---
> > Changes in v3:
> > * Add a more descriptive commit message
> > 
> > Changes in v2:
> > * rebased to v3.15-rc4
> > 
> >  drivers/video/fbdev/mx3fb.c | 98 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 98 insertions(+)
> > 
> > diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
> > index 142e860..10a7244 100644
> > --- a/drivers/video/fbdev/mx3fb.c
> > +++ b/drivers/video/fbdev/mx3fb.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/clk.h>
> >  #include <linux/mutex.h>
> >  #include <linux/dma/ipu-dma.h>
> > +#include <linux/backlight.h>
> >  
> >  #include <linux/platform_data/dma-imx.h>
> >  #include <linux/platform_data/video-mx3fb.h>
> > @@ -34,6 +35,12 @@
> >  #include <asm/io.h>
> >  #include <asm/uaccess.h>
> >  
> > +#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
> > +	(defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE) && \
> > +		defined(CONFIG_MX3FB_MODULE))
> > +#define PWM_BACKLIGHT_AVAILABLE
> > +#endif
> 
> I'm not very fond of this kind of ifdeffery. It makes the driver rather
> messy and confusing, especially if large blocks of code are inside the
> ifdefs.
> 
> Can't you just make the driver select BACKLIGHT_CLASS_DEVICE?

Well, sure I can. I just went the same way as atmel_lcdfb.c did. Will sent new patch.

Regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

