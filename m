From: Mike Turquette <mturquette@linaro.org>
Date: Sat, 04 Oct 2014 20:38:37 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v3] dt-bindings: Add a clocks property to the simple-framebuffer bindin
Message-Id: <20141004203837.4379.55504@quantum>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1412345120-24588-1-git-send-email-hdegoede@redhat.com>
 <CAL_JsqKU2n8p=YfJua3k-mR40bG_4SiZY8_-SL-MXtuWN5NeHg@mail.gmail.com>
 <542EDE11.3010802@redhat.com>
 <CAL_Jsq+3c7ToCGaR4Nz7dDXvebBKzzMv85swzy2mzOou+gM5iw@mail.gmail.com>
 <CAKON4OxrcgWvJM_BCKwLDRBodaFC1h8Csu_srzjJSM=L+gpuaA@mail.gmail.com>
 <CAMuHMdVSyqJA6uTPiemco0guhG1MKgkCBV7Tik-Ndd_fs28=NQ@mail.gmail.com>
 <CAKON4OwZahPqPPqorFvgK+YNeYfqH87FTuX=umhZ42uGR32MMA@mail.gmail.com>
In-Reply-To: <CAKON4OwZahPqPPqorFvgK+YNeYfqH87FTuX=umhZ42uGR32MMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Quoting jonsmirl@gmail.com (2014-10-03 14:50:24)
> On Fri, Oct 3, 2014 at 5:26 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Oct 3, 2014 at 10:55 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> >> On Thu, Oct 2, 2014 at 9:46 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>> On Thu, Oct 2, 2014 at 3:34 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> >>>> Does the clock and regulator cleanup happen before drivers can load
> >>>> off from initrd? I didn't think it did but I might be wrong.
> >>>
> >>> Yes
> >>>
> >>> drivers/base/power/domain.c:late_initcall(genpd_poweroff_unused);
> >>> drivers/clk/clk.c:late_initcall_sync(clk_disable_unused);
> >>> drivers/regulator/core.c:late_initcall_sync(regulator_init_complete);
> >>
> >> What do you think about putting these calls onto an ioctl somewhere
> >> and then eliminating the late_initcall(..)? A tiny user space app
> >> could then hit that ioctl after all of the loadable device drivers are
> >> loaded. Add the command to make this ioctl call to busybox or udev.
> >> After all, it is not fatal if these calls aren't made, all they do is
> >> save power. Add a link in rc.d or somewhere similar to run this app at
> >> the appropriate time.
> >>
> >> Switching these over to an ioctl allows a window to be opened for
> >> device specific driver loading before the clock/regulator clean up
> >> happens.
> >>
> >> Now all of this mess of protecting clocks and regulator disappears.
> >> Instead get the device specific drivers written and loaded, then run
> >> the cleanup app which hits the ioctl(). All of the correct
> >> clock/regulators will be claimed and then this clean code will do the
> >> right thing.
> >>
> >> From my perspective it appears that this cleanup is being done too
> >> early which then triggers a need to protect things from cleanup.
> >
> > Not doing the cleanup doesn't help.
> >
> > If someone else calls clk_disable() on a clock which shares a parent
> > with the clock you're silently using, that clock will still be disabled.
> > This can happen at any time.
> 
> Could we start all of the regulators and clocks off with a reference
> count of one, but not do anything to change their state? Then this
> ioctl() would decrement that extra reference. Removing the extra
> reference would then disable everything that isn't claimed.

No. That is too ugly.

Regards,
Mike

> 
> 
> >
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
> 
> 
> 
> -- 
> Jon Smirl
> jonsmirl@gmail.com
