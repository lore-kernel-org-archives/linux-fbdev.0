From: Ludovic Desroches <ludovic.desroches@microchip.com>
Date: Wed, 12 Jun 2019 14:13:56 +0000
Subject: Re: [PATCH][next] video: fbdev: atmel_lcdfb: remove redundant initialization to variable ret
Message-Id: <20190612141356.riiesqub4zvxafh3@M43218.corp.atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190611170913.20913-1-colin.king@canonical.com>
 <37ac8530-6601-a1a0-37e0-8c6d5d1702cd@microchip.com>
In-Reply-To: <37ac8530-6601-a1a0-37e0-8c6d5d1702cd@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>
Cc: Colin King <colin.king@canonical.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jun 12, 2019 at 09:55:30AM +0200, Nicolas Ferre - M43238 wrote:
> On 11/06/2019 at 19:09, Colin King wrote:
> > External E-Mail
> > 
> > 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently variable ret is being initialized with -ENOENT however that
> > value is never read and ret is being re-assigned later on. Hence this
> > assignment is redundant and can be removed.
> > 
> > Addresses-Coverity: ("Unused value")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Indeed:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

Thanks

> 
> Thanks, best regards,
>    Nicolas
> 
> 
> > ---
> >   drivers/video/fbdev/atmel_lcdfb.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
> > index fb117ccbeab3..930cc3f92e01 100644
> > --- a/drivers/video/fbdev/atmel_lcdfb.c
> > +++ b/drivers/video/fbdev/atmel_lcdfb.c
> > @@ -950,7 +950,7 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
> >   	struct fb_videomode fb_vm;
> >   	struct gpio_desc *gpiod;
> >   	struct videomode vm;
> > -	int ret = -ENOENT;
> > +	int ret;
> >   	int i;
> >   
> >   	sinfo->config = (struct atmel_lcdfb_config*)
> > 
> 
> 
> -- 
> Nicolas Ferre
