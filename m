From: Sreeram Veluthakkal <srrmvlt@gmail.com>
Date: Mon, 09 Sep 2019 11:50:06 +0000
Subject: Re: [PATCH] FBTFT: fb_agm1264k: usleep_range is preferred over udelay
Message-Id: <20190909115006.GB3437@sreeram-MS-7B98>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190909012605.15051-1-srrmvlt@gmail.com>
 <20190909095625.GB17624@kroah.com>
In-Reply-To: <20190909095625.GB17624@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, nishadkamdar@gmail.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, payal.s.kshirsagar.98@gmail.com

On Mon, Sep 09, 2019 at 10:56:25AM +0100, Greg KH wrote:
> On Sun, Sep 08, 2019 at 08:26:05PM -0500, Sreeram Veluthakkal wrote:
> > This patch fixes the issue:
> > FILE: drivers/staging/fbtft/fb_agm1264k-fl.c:88:
> > CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
> > +       udelay(20);
> > 
> > Signed-off-by: Sreeram Veluthakkal <srrmvlt@gmail.com>
> > ---
> >  drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
> > index eeeeec97ad27..2dece71fd3b5 100644
> > --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> > +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> > @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
> >  	dev_dbg(par->info->device, "%s()\n", __func__);
> >  
> >  	gpiod_set_value(par->gpio.reset, 0);
> > -	udelay(20);
> > +	usleep_range(20, 40);
> 
> Is it "safe" to wait 40?  This kind of change you can only do if you
> know this is correct.  Have you tested this with hardware?
> 
> thanks,
> 
> greg k-h

Hi Greg, No I haven't tested it, I don't have the hw. I dug depeer in to the usleep_range

https://github.com/torvalds/linux/blob/master/kernel/time/timer.c#L1993
	u64 delta = (u64)(max - min) * NSEC_PER_USEC;

 * The @delta argument gives the kernel the freedom to schedule the
 * actual wakeup to a time that is both power and performance friendly.
 * The kernel give the normal best effort behavior for "@expires+@delta",
 * but may decide to fire the timer earlier, but no earlier than @expires.

My understanding is that keeping delta 0 (min=max ) would be equivalent. 
I can revise the patch to usleep_range(20, 20) or usleep_range(20, 21) for a 1 usec delta.
What do you suggest?

thanks,
Sreeram
