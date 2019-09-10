From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Sep 2019 07:59:50 +0000
Subject: Re: [PATCH] FBTFT: fb_agm1264k: usleep_range is preferred over udelay
Message-Id: <CAMuHMdXz568p=GFJmz6MfuxDxA_QkLMrGcK2hG3C99ReL1fH5A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190909012605.15051-1-srrmvlt@gmail.com> <20190909095625.GB17624@kroah.com>
 <20190909115006.GB3437@sreeram-MS-7B98>
In-Reply-To: <20190909115006.GB3437@sreeram-MS-7B98>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sreeram Veluthakkal <srrmvlt@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, driverdevel <devel@driverdev.osuosl.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, nishadkamdar@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, payal.s.kshirsagar.98@gmail.com

Hi Sreeram,

On Tue, Sep 10, 2019 at 2:25 AM Sreeram Veluthakkal <srrmvlt@gmail.com> wrote:
> On Mon, Sep 09, 2019 at 10:56:25AM +0100, Greg KH wrote:
> > On Sun, Sep 08, 2019 at 08:26:05PM -0500, Sreeram Veluthakkal wrote:
> > > This patch fixes the issue:
> > > FILE: drivers/staging/fbtft/fb_agm1264k-fl.c:88:
> > > CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
> > > +       udelay(20);
> > >
> > > Signed-off-by: Sreeram Veluthakkal <srrmvlt@gmail.com>

Thanks for your patch!

> > > --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> > > +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> > > @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
> > >     dev_dbg(par->info->device, "%s()\n", __func__);
> > >
> > >     gpiod_set_value(par->gpio.reset, 0);
> > > -   udelay(20);
> > > +   usleep_range(20, 40);
> >
> > Is it "safe" to wait 40?  This kind of change you can only do if you
> > know this is correct.  Have you tested this with hardware?
> >
> > thanks,
> >
> > greg k-h
>
> Hi Greg, No I haven't tested it, I don't have the hw. I dug depeer in to the usleep_range
>
> https://github.com/torvalds/linux/blob/master/kernel/time/timer.c#L1993
>         u64 delta = (u64)(max - min) * NSEC_PER_USEC;
>
>  * The @delta argument gives the kernel the freedom to schedule the
>  * actual wakeup to a time that is both power and performance friendly.
>  * The kernel give the normal best effort behavior for "@expires+@delta",
>  * but may decide to fire the timer earlier, but no earlier than @expires.
>
> My understanding is that keeping delta 0 (min=max ) would be equivalent.
> I can revise the patch to usleep_range(20, 20) or usleep_range(20, 21) for a 1 usec delta.
> What do you suggest?

Please read the comment above the line you're referring to:

 * In non-atomic context where the exact wakeup time is flexible, use
 * usleep_range() instead of udelay().  The sleep improves responsiveness
 * by avoiding the CPU-hogging busy-wait of udelay(), and the range reduces
 * power usage by allowing hrtimers to take advantage of an already-
 * scheduled interrupt instead of scheduling a new one just for this sleep.

Is this function always called in non-atomic context?
If it  may be called in atomic context, replacing the udelay() call by a
usleep*() call will break the driver.

See also "the first and most important question" in
Documentation/timers/timers-howto.rst, as referred to by the checkpatch.pl
message.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
