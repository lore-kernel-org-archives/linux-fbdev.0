From: Chuhong Yuan <hslester96@gmail.com>
Date: Tue, 24 Mar 2020 13:35:51 +0000
Subject: Re: [PATCH v3] video: fbdev: vesafb: add missed release_region
Message-Id: <CANhBUQ1JV3drHn-HO2urK-Q7yUNtLhk09UuBG7F=qV7Lid=0ww@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200310023550eucas1p10797f834d7dc16f634cf644011462393@eucas1p1.samsung.com>
 <20200310023536.13622-1-hslester96@gmail.com>
 <1f5e6f52-c638-f73e-cf9d-88eb641a010d@samsung.com>
In-Reply-To: <1f5e6f52-c638-f73e-cf9d-88eb641a010d@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org

On Fri, Mar 20, 2020 at 8:01 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> On 3/10/20 3:35 AM, Chuhong Yuan wrote:
> > The driver forgets to free the I/O region in remove and probe
> > failure.
> > Add the missed calls to fix it.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> > Changes in v3:
> >   - Revise the commit message.
> >   - Add an error handler to suit the "goto error" before request_region().
> >   - Revise the order of operations in remove.
> >
> >  drivers/video/fbdev/vesafb.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
> > index a1fe24ea869b..c7bc9ace47d4 100644
> > --- a/drivers/video/fbdev/vesafb.c
> > +++ b/drivers/video/fbdev/vesafb.c
> > @@ -439,7 +439,7 @@ static int vesafb_probe(struct platform_device *dev)
> >                      "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
> >                       vesafb_fix.smem_len, vesafb_fix.smem_start);
> >               err = -EIO;
> > -             goto err;
> > +             goto err_release_region;
> >       }
> >
> >       printk(KERN_INFO "vesafb: framebuffer at 0x%lx, mapped to 0x%p, "
> > @@ -458,15 +458,17 @@ static int vesafb_probe(struct platform_device *dev)
> >
> >       if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
> >               err = -ENOMEM;
> > -             goto err;
> > +             goto err_release_region;
> >       }
> >       if (register_framebuffer(info)<0) {
> >               err = -EINVAL;
> >               fb_dealloc_cmap(&info->cmap);
> > -             goto err;
> > +             goto err_release_region;
> >       }
> >       fb_info(info, "%s frame buffer device\n", info->fix.id);
> >       return 0;
> > +err_release_region:
> > +     release_region(0x3c0, 32);
>
> This is incorrect.
>
> The cleanup order should be the reverse of the probing order.
>
> Also request_region() return value is not checked by the driver
> (there is a comment that it can fail and is optional):
>
>         /* request failure does not faze us, as vgacon probably has this
>          * region already (FIXME) */
>         request_region(0x3c0, 32, "vesafb");
>
> so what would happen in such case? It seems that unconditionally
> doing the release will result in freeing the I/O region owned by
> the other driver (vgacon)..
>

Maybe we can add a field to represent whether the request succeeds?
request_region() returns source *, we can store it and check whether
it is null when
we are going to call release_region().

> >  err:
> >       arch_phys_wc_del(par->wc_cookie);
> >       if (info->screen_base)
> > @@ -481,6 +483,7 @@ static int vesafb_remove(struct platform_device *pdev)
> >       struct fb_info *info = platform_get_drvdata(pdev);
> >
> >       unregister_framebuffer(info);
> > +     release_region(0x3c0, 32);
> >       framebuffer_release(info);
> >
> >       return 0;
> >
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
