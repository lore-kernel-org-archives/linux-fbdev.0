From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 01 Aug 2013 11:50:45 +0000
Subject: Re: [patch -next] fb: fix recent breakage in correct_chipset()
Message-Id: <20130801115045.GL5002@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130702062821.GC24410@elgon.mountain>
In-Reply-To: <20130702062821.GC24410@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Aug 01, 2013 at 11:31:07AM +0200, Geert Uytterhoeven wrote:
> On Tue, Jul 2, 2013 at 8:28 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > The 6e36308a6f "fb: fix atyfb build warning" isn't right.  It makes all
> > the indexes off by one.  This patch reverts it and casts the
> > ARRAY_SIZE() to int to silence the build warning.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
> > index a89c15d..9b0f12c 100644
> > --- a/drivers/video/aty/atyfb_base.c
> > +++ b/drivers/video/aty/atyfb_base.c
> > @@ -435,8 +435,8 @@ static int correct_chipset(struct atyfb_par *par)
> >         const char *name;
> >         int i;
> >
> > -       for (i = ARRAY_SIZE(aty_chips); i > 0; i--)
> > -               if (par->pci_id = aty_chips[i - 1].pci_id)
> > +       for (i = (int)ARRAY_SIZE(aty_chips) - 1; i >= 0; i--)
> > +               if (par->pci_id = aty_chips[i].pci_id)
> >                         break;
> >
> >         if (i < 0)
> 
> Sorry for chiming in late, but can't we just revert the order of the loop
> iteration and change i from int to size_t instead of adding a cast?
> 

Nope.  That would be a nearly-forever loop.

regards,
dan carpenter
