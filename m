From: John Wyatt <jbwyatt4@gmail.com>
Date: Sun, 29 Mar 2020 09:38:51 +0000
Subject: Re: [Outreachy kernel] [PATCH] staging: fbtft: Replace udelay with preferred usleep_range
Message-Id: <2fccf96c3754e6319797a10856e438e023f734a7.camel@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200329092204.770405-1-jbwyatt4@gmail.com>
 <alpine.DEB.2.21.2003291127230.2990@hadrien>
In-Reply-To: <alpine.DEB.2.21.2003291127230.2990@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia.lawall@inria.fr>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, outreachy-kernel@googlegroups.com, Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>

On Sun, 2020-03-29 at 11:28 +0200, Julia Lawall wrote:
> 
> On Sun, 29 Mar 2020, John B. Wyatt IV wrote:
> 
> > Fix style issue with usleep_range being reported as preferred over
> > udelay.
> > 
> > Issue reported by checkpatch.
> > 
> > Please review.
> > 
> > As written in Documentation/timers/timers-howto.rst udelay is the
> > generally preferred API. hrtimers, as noted in the docs, may be too
> > expensive for this short timer.
> > 
> > Are the docs out of date, or, is this a checkpatch issue?
> > 
> > Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
> > ---
> >  drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c
> > b/drivers/staging/fbtft/fb_agm1264k-fl.c
> > index eeeeec97ad27..019c8cce6bab 100644
> > --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> > +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> > @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
> >  	dev_dbg(par->info->device, "%s()\n", __func__);
> > 
> >  	gpiod_set_value(par->gpio.reset, 0);
> > -	udelay(20);
> > +	usleep_range(20, 20);
> 
> usleep_range should have a range, eg usleep_range(50, 100);.  But it
> is
> hard to know a priori what the range should be.  So it is probably
> better
> to leave the code alone.

Understood.

With the question I wrote in the commit message:

"As written in Documentation/timers/timers-howto.rst udelay is the
generally preferred API. hrtimers, as noted in the docs, may be too
expensive for this short timer.

Are the docs out of date, or, is this a checkpatch issue?"

Is usleep_range too expensive for this operation?

Why does checkpatch favor usleep_range while the docs favor udelay?

> 
> julia
> 
> >  	gpiod_set_value(par->gpio.reset, 1);
> >  	mdelay(120);
> >  }
> > --
> > 2.25.1
> > 
> > --
> > You received this message because you are subscribed to the Google
> > Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it,
> > send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit 
> > https://groups.google.com/d/msgid/outreachy-kernel/20200329092204.770405-1-jbwyatt4%40gmail.com
> > .
> > 
