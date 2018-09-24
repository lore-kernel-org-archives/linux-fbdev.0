From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 24 Sep 2018 21:41:04 +0000
Subject: Re: [PATCH] backlight: lm3639: Unconditionally call led_classdev_unregister
Message-Id: <CAKwvOdnRzGhDZw-O_5khqsi4Bi7QOrrQ9GBpfhxUGxkOkuX6CA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180921202130.12480-1-natechancellor@gmail.com>
 <CAKwvOdnj5M1xTKue7qZCV-2=hLTATnB-J1QOVvaVVa+8h+vq4A@mail.gmail.com> <20180921231047.GA25998@flashbox>
In-Reply-To: <20180921231047.GA25998@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Fri, Sep 21, 2018 at 4:10 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Fri, Sep 21, 2018 at 03:48:50PM -0700, Nick Desaulniers wrote:
> > On Fri, Sep 21, 2018 at 1:23 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Clang warns that the address of a pointer will always evaluated as true
> > > in a boolean context.
> > >
> > > drivers/video/backlight/lm3639_bl.c:403:14: warning: address of
> > > 'pchip->cdev_torch' will always evaluate to 'true'
> > > [-Wpointer-bool-conversion]
> > >         if (&pchip->cdev_torch)
> > >         ~~   ~~~~~~~^~~~~~~~~~
> > > drivers/video/backlight/lm3639_bl.c:405:14: warning: address of
> > > 'pchip->cdev_flash' will always evaluate to 'true'
> > > [-Wpointer-bool-conversion]
> > >         if (&pchip->cdev_flash)
> > >         ~~   ~~~~~~~^~~~~~~~~~
> > > 2 warnings generated.
> > >
> > > These statements have been present since 2012, introduced by
> > > commit 0f59858d5119 ("backlight: add new lm3639 backlight
> > > driver"). Given that they have been called unconditionally since
> > > then presumably without any issues, removing the always true if
> > > statements to fix the warnings without any real world changes.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/119
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >
> > > Alternatively, it's possible the address wasn't supposed to be taken or
> > > the dev in these structs should be checked instead. I don't have this
> > > hardware to make that call so I would appreciate some review and
> > > opinions on what was intended here.
> > >
> > > Thanks!
> > >
> > >  drivers/video/backlight/lm3639_bl.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
> > > index cd50df5807ea..086611c7bc03 100644
> > > --- a/drivers/video/backlight/lm3639_bl.c
> > > +++ b/drivers/video/backlight/lm3639_bl.c
> > > @@ -400,10 +400,8 @@ static int lm3639_remove(struct i2c_client *client)
> > >
> > >         regmap_write(pchip->regmap, REG_ENABLE, 0x00);
> > >
> > > -       if (&pchip->cdev_torch)
> > > -               led_classdev_unregister(&pchip->cdev_torch);
> > > -       if (&pchip->cdev_flash)
> > > -               led_classdev_unregister(&pchip->cdev_flash);
> > > +       led_classdev_unregister(&pchip->cdev_torch);
> > > +       led_classdev_unregister(&pchip->cdev_flash);
> >
> > led_classdev_unregister() requires that its arg is non-null (as it
> > dereferences it without any kind of check).  It's not clear that
> > i2c_get_clientdata() can never return a null pointer, so I think all
> > references to pchip in this function should instead be guarded with a
> > null check.  Would you mind making that change and sending a v2?
> >
>
> Hi Nick,
>
> I did a quick grep throughout the tree and I didn't see any place where
> there were null checks for i2c_get_clientdata, leading me to believe
> that such a check isn't necessary although I am nowhere close to an expert
> into this stuff.

This seems to be the case.  We should start using
__attribute__((returns_nonnull)) (gated on gcc 5+).
I *think* that the device's driver_data is actually set in
drivers/video/backlight/backlight.c.  Looks like
CONFIG_BACKLIGHT_LM3639 depends on CONFIG_BACKLIGHT_CLASS_DEVICE so I
feel more confident in your patch.
I would still prefer the maintainers to review though.

> I'm not sure I follow the rest of the request though,
> where should the check be? Before regmap_write?
>
> Furthermore, the probe function seems to make sure all of these get
> initialized properly, doesn't remove imply that probe was successful?
>
> Thank you for the comment and review!
> Nathan
>
> > >         if (pchip->bled)
> > >                 device_remove_file(&(pchip->bled->dev), &dev_attr_bled_mode);
> > >         return 0;
> > > --
> > > 2.19.0
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
