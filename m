From: Sam Muhammed <jane.pnx9@gmail.com>
Date: Sun, 29 Mar 2020 10:51:58 +0000
Subject: Re: [Outreachy kernel] [PATCH] staging: fbtft: Replace udelay with preferred usleep_range
Message-Id: <ab06bc216dc07b2b070bc2635aaabb1942c6089c.camel@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200329092204.770405-1-jbwyatt4@gmail.com>
 <alpine.DEB.2.21.2003291127230.2990@hadrien>
 <2fccf96c3754e6319797a10856e438e023f734a7.camel@gmail.com>
 <alpine.DEB.2.21.2003291144460.2990@hadrien>
 <CAMS7mKBEhqFat8fWi=QiFwfLV9+skwi1hE-swg=XxU48zk=_tQ@mail.gmail.com>
 <alpine.DEB.2.21.2003291235590.2990@hadrien>
In-Reply-To: <alpine.DEB.2.21.2003291235590.2990@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia.lawall@inria.fr>, Soumyajit Deb <debsoumyajit100@gmail.com>
Cc: devel@driverdev.osuosl.org, John Wyatt <jbwyatt4@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com, Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>

On Sun, 2020-03-29 at 12:37 +0200, Julia Lawall wrote:
> 
> On Sun, 29 Mar 2020, Soumyajit Deb wrote:
> 
> > I had the same doubt the other day about the replacement of udelay() with
> > usleep_range(). The corresponding range for the single argument value of
> > udelay() is quite confusing as I couldn't decide the range. But as much as I
> > noticed checkpatch.pl gives warning for replacing udelay() with
> > usleep_range() by checking the argument value of udelay(). In the
> > documentation, it is written udelay() should be used for a sleep time of at
> > most 10 microseconds but between 10 microseconds and 20 milliseconds,
> > usleep_range() should be used. 
> > I think the range is code specific and will depend on what range is
> > acceptable and doesn't break the code.
> >  Please correct me if I am wrong.
> 
> The range depends on the associated hardware.  Just because checkpatch
> suggests something doesn't mean that it is easy to address the problem.
> 
> julia
> 

Hi all, i think when it comes to a significant change in the code, we
should at least be familiar with the driver or be able to test the
change.

In the very beginning of the Documentation/timers/timers-howto.rst
there is the question:
"Is my code in an atomic context?"
It's not just about the range, it's more of at which context this code
runs, for atomic-context -> udelay must be used.
for non-atomic context -> usleep-range is better for power-management.

unless we are familiar with the driver we wouldn't really know in what
context this code is run at.

This thread though had the same conversation about this change, for the
same driver.
https://patchwork.kernel.org/patch/11137125/

Sam

> >
> > More clarification on this issue will be helpful.
> >
> > On Sun, 29 Mar 2020, 15:17 Julia Lawall, <julia.lawall@inria.fr> wrote:
> >
> >
> >       On Sun, 29 Mar 2020, John Wyatt wrote:
> >
> >       > On Sun, 2020-03-29 at 11:28 +0200, Julia Lawall wrote:
> >       > >
> >       > > On Sun, 29 Mar 2020, John B. Wyatt IV wrote:
> >       > >
> >       > > > Fix style issue with usleep_range being reported as
> >       preferred over
> >       > > > udelay.
> >       > > >
> >       > > > Issue reported by checkpatch.
> >       > > >
> >       > > > Please review.
> >       > > >
> >       > > > As written in Documentation/timers/timers-howto.rst udelay
> >       is the
> >       > > > generally preferred API. hrtimers, as noted in the docs,
> >       may be too
> >       > > > expensive for this short timer.
> >       > > >
> >       > > > Are the docs out of date, or, is this a checkpatch issue?
> >       > > >
> >       > > > Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
> >       > > > ---
> >       > > >  drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
> >       > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >       > > >
> >       > > > diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c
> >       > > > b/drivers/staging/fbtft/fb_agm1264k-fl.c
> >       > > > index eeeeec97ad27..019c8cce6bab 100644
> >       > > > --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> >       > > > +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> >       > > > @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
> >       > > >   dev_dbg(par->info->device, "%s()\n", __func__);
> >       > > >
> >       > > >   gpiod_set_value(par->gpio.reset, 0);
> >       > > > - udelay(20);
> >       > > > + usleep_range(20, 20);
> >       > >
> >       > > usleep_range should have a range, eg usleep_range(50,
> >       100);.  But it
> >       > > is
> >       > > hard to know a priori what the range should be.  So it is
> >       probably
> >       > > better
> >       > > to leave the code alone.
> >       >
> >       > Understood.
> >       >
> >       > With the question I wrote in the commit message:
> >       >
> >       > "As written in Documentation/timers/timers-howto.rst udelay is
> >       the
> >       > generally preferred API. hrtimers, as noted in the docs, may
> >       be too
> >       > expensive for this short timer.
> >       >
> >       > Are the docs out of date, or, is this a checkpatch issue?"
> >       >
> >       > Is usleep_range too expensive for this operation?
> >       >
> >       > Why does checkpatch favor usleep_range while the docs favor
> >       udelay?
> >
> >       I don't know the answer in detail, but it is quite possible that
> >       checkpatch doesn't pay any attention to the delay argument. 
> >       Checkpatch is
> >       a perl script that highlights things that may be of concern.  It
> >       is not a
> >       precise static analsis tool.
> >
> >       As a matter of form, all of your Please review comments should
> >       have been
> >       put below the ---.  Currently, if someone had wanted to apply
> >       the patch,
> >       you would make them do extra work to remove this information.
> >
> >       julia
> >
> >       >
> >       > >
> >       > > julia
> >       > >
> >       > > >   gpiod_set_value(par->gpio.reset, 1);
> >       > > >   mdelay(120);
> >       > > >  }
> >       > > > --
> >       > > > 2.25.1
> >       > > >
> >       > > > --
> >       > > > You received this message because you are subscribed to
> >       the Google
> >       > > > Groups "outreachy-kernel" group.
> >       > > > To unsubscribe from this group and stop receiving emails
> >       from it,
> >       > > > send an email to
> >       outreachy-kernel+unsubscribe@googlegroups.com.
> >       > > > To view this discussion on the web visit
> >       > > >https://groups.google.com/d/msgid/outreachy-kernel/20200329092204.770405-1-
> >       jbwyatt4%40gmail.com
> >       > > > .
> >       > > >
> >       >
> >       >
> >
> >       --
> >       You received this message because you are subscribed to the
> >       Google Groups "outreachy-kernel" group.
> >       To unsubscribe from this group and stop receiving emails from
> >       it, send an email to
> >       outreachy-kernel+unsubscribe@googlegroups.com.
> >       To view this discussion on the web visithttps://groups.google.com/d/msgid/outreachy-kernel/alpine.DEB.2.21.20032911
> >       44460.2990%40hadrien.
> >
> >
> >
> 
