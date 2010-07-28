From: Anatolij Gustschin <agust@denx.de>
Date: Wed, 28 Jul 2010 07:56:55 +0000
Subject: Re: [PATCH v4 1/5] fsl-diu-fb: fix issue with re-enabling DIU area
Message-Id: <20100728095655.0e1c81eb@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279893639-24333-1-git-send-email-agust@denx.de>
	<1279893639-24333-2-git-send-email-agust@denx.de>
	<AANLkTikkLVCxU4ZC_nmUhKTQogUNeQzxOX6KqgZcxiYr@mail.gmail.com>
In-Reply-To: <AANLkTikkLVCxU4ZC_nmUhKTQogUNeQzxOX6KqgZcxiYr-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>

On Wed, 28 Jul 2010 01:02:59 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:
...
> >  drivers/video/fsl-diu-fb.c |   38 +++++++++++++++++++++++---------------
> >  1 files changed, 23 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> > index 27455ce..9b8c991 100644
> > --- a/drivers/video/fsl-diu-fb.c
> > +++ b/drivers/video/fsl-diu-fb.c
> > @@ -317,6 +317,17 @@ static void fsl_diu_free(void *virt, size_t size)
> >                free_pages_exact(virt, size);
> >  }
> >
> > +/*
> > + * Workaround for failed writing desc register of planes.
> > + * Needed with MPC5121 DIU rev 2.0 silicon.
> > + */
> > +void wr_reg_wa(u32 *reg, u32 val)
> > +{
> > +       do {
> > +               out_be32(reg, val);
> > +       } while (in_be32(reg) != val);
> > +}
> 
> I'll apply this one, but it looks like a potential problem.  What
> happens if the write never succeeds?  The kernel then gets stuck in a
> forever busy loop.  You should look at reworking it.

I'll submit an incremental patch that prevents looping forever in
the case if the write never succeeds. Thanks!

Anatolij
