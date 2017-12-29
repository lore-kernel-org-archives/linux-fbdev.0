From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 29 Dec 2017 18:05:17 +0000
Subject: Re: [PATCH] video/fbdev/stifb: Delete an error message for a failed memory allocation in stifb_init_
Message-Id: <1680261.Msdj7gi9fB@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7dcd32b6-9691-14a1-29cf-3a746ef5adfc@users.sourceforge.net>
        <CGME20171124213055epcas4p45c641222185056871b97f4e7bc235d2e@epcas4p4.samsung.com>
        <25624997.nONnEdNj0s@daneel.sf-tec.de>
In-Reply-To: <25624997.nONnEdNj0s@daneel.sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, "James E. J. Bottomley" <jejb@parisc-linux.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Friday, November 24, 2017 10:30:34 PM Rolf Eike Beer wrote:
> Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Fri, 24 Nov 2017 22:22:06 +0100
> > 
> > Omit an extra message for a memory allocation failure in this function.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  drivers/video/fbdev/stifb.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
> > index 6ded5c198998..fe217a2f7d21 100644
> > --- a/drivers/video/fbdev/stifb.c
> > +++ b/drivers/video/fbdev/stifb.c
> > @@ -1126,10 +1126,8 @@ static int __init stifb_init_fb(struct sti_struct
> > *sti, int bpp_pref) int bpp, xres, yres;
> > 
> >  	fb = kzalloc(sizeof(*fb), GFP_ATOMIC);
> > -	if (!fb) {
> > -		printk(KERN_ERR "stifb: Could not allocate stifb structure\n");
> > +	if (!fb)
> >  		return -ENODEV;
> > -	}
> > 
> >  	info = &fb->info;
> 
> This should be -ENOMEM.

Markus, please fix this issue first (before doing cleanups).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

