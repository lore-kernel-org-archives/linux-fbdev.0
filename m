From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Dec 2010 03:28:31 +0000
Subject: Re: [PATCH 1/3] fb: fix overlapping test off-by-one.
Message-Id: <20101224032831.GI28151@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1292895677-4242-1-git-send-email-airlied@gmail.com> <1292895677-4242-2-git-send-email-airlied@gmail.com> <1292916543.19556.46.camel@thor.local>
In-Reply-To: <1292916543.19556.46.camel@thor.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michel D?nzer <michel@daenzer.net>
Cc: Dave Airlie <airlied@gmail.com>, linux-fbdev@vger.kernel.org, Dave Airlie <airlied@redhat.com>, linux-kernel@vger.kernel.org, dri-devel@lists.sf.net

On Tue, Dec 21, 2010 at 08:29:03AM +0100, Michel D?nzer wrote:
> On Die, 2010-12-21 at 11:41 +1000, Dave Airlie wrote: 
> > From: Dave Airlie <airlied@redhat.com>
> > 
> > On my system with a radeon x2, the first GPU was not overlapping vesa
> > but the test decided it was.
> > 
> > Signed-off-by: Dave Airlie <airlied@redhat.com>
> > ---
> >  drivers/video/fbmem.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> > index 0e6aa3d..4ac1201 100644
> > --- a/drivers/video/fbmem.c
> > +++ b/drivers/video/fbmem.c
> > @@ -1458,7 +1458,7 @@ static bool apertures_overlap(struct aperture *gen, struct aperture *hw)
> >  	if (gen->base = hw->base)
> >  		return true;
> >  	/* is the generic aperture base inside the hw base->hw base+size */
> > -	if (gen->base > hw->base && gen->base <= hw->base + hw->size)
> > +	if (gen->base > hw->base && gen->base < hw->base + hw->size)
> 
> Good catch.
> 
> Reviewed-by: Michel D??nzer <michel@daenzer.net>
> 
I'll queue this for .37, thanks.
