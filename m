From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Sun, 02 Nov 2014 15:28:48 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v4 0/5] simplefb: add clock handling code
Message-Id: <CAKON4Oyw46zjq8QJNAFi9qWA9-6MpXtGavzVmXQT3SPqH=NpjQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <544F737A.7000109@ti.com>
 <CAL_JsqJ2JRg7k21CEVe4-At7enD+y3TN_7wfqhY0OHZm-_j17w@mail.gmail.com>
 <544F7E5D.60104@redhat.com> <5450CAA5.5020205@ti.com>
 <CAL_JsqKWqq+H5ymUW3n8tkmLJHEUGaKDLX5+orJmGUQ3ECQwUQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKWqq+H5ymUW3n8tkmLJHEUGaKDLX5+orJmGUQ3ECQwUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Oct 31, 2014 at 4:47 PM, Rob Herring <robherring2@gmail.com> wrote:
>
> On Wed, Oct 29, 2014 at 7:08 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > Hi Hans, Rob,
> >
> > On 28/10/14 13:30, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 10/28/2014 12:11 PM, Rob Herring wrote:
> >
> >>> Yes, I object to the binding still as it has not changed from what was
> >>> previously posted.
> >>
> >> It would be helpful if you could explain why you object. Last time you
> >> said: " You are mixing in a hardware description that is simply inaccurate."
> >>
> >> I then explained that this is not hardware description, but runtime state
> >> information, as it tells the kernel which clocks were chosen to drive the
> >> display (out of typically a list of possible options, depending on which
> >> output is used, etc.). Just like which memory address the bootloader has
> >> chosen to scan out the video image from.
> >>
> >> Then you got quiet, so sorry, but this time your objection really is too
> >> late. You cannot simply go quiet halfway through a discussion and then pop
> >> up again when a new version is posted to say "I object" yet another time,
> >> you've had your chance to make your arguments last time, and chose to stay
> >> quiet after I explained in detail that this is not hardware description but
> >> state information, so now it is simply too late.
> >>
> >> These bindings have been discussed at Plumbers with various interested people
> >> present, and the conclusion was that this really is the best way to handle this,
> >> so this patch is:
> >>
> >>     Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>     Reviewed-by: Mike Turquette <mturquette@linaro.org>
> >>     Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >>     Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >>
> >> And David Herrman who is working on simpledrm, which will be merged soon, which
> >> will also use the simplefb bindings also agrees. So we have the simplefb maintainer,
> >> simpledrm maintainer, and the clk subsystem maintainer + 2 other maintainers all
> >> agreeing on a way forward, the time for bikeshedding now really really really is
> >> over.
> >>
> >> Tomi, can you please let us know how you plan to proceed with this ?
> >
> > I won't merge DT bindings via fbdev tree, if a DT maintainer says no.
> >
> > I took Rob's silence to the earlier series as a silent ack for your
> > explanation. Obviously that was not the case.
> >
> > Rob, please advice asap what should be done to the bindings to get your
> > ack. As Hans explained above, this discussion has been going on for a
> > long time, and afaik this series is the best way forward of all the
> > options discussed.
>
> I still think for the most part this is a kernel problem. It is a
> kernel policy to turn off unused clocks. The clock framework could
> just as easily decide that any clocks enabled at boot and left
> un-managed (i.e. w/o a driver) are kept on until they are managed. I'm
> not saying this can't be in DT, only that DT is not the only solution
> here. This problem is not unique to simplefb. A serial console could
> stop working if no serial driver is loaded before unused clocks are
> disabled. CPU core clocks have a similar issue as well (often enabled
> in platform code). I want to see this solved in a generic way for any
> clock.


I am in agreement this point of view. This is a problem in the Linux
kernel. It is not a generic problem.

The Linux problem is that during boot device drivers are loaded in two
phases - built-in and loadable modules. The clock-regulator clean up
is happening too early. It happens after the built-in drivers load and
before the loadable modules have a chance to load. That's simply the
wrong place for that clean up happen.  A simple alternative would be
to make a tiny loadable module that triggers the clean up. Then adjust
your boot scripts to load this module after the other ones have
loaded. But instead of fixing this simple timing flaw in the Linux
boot process a complex mechanism is being created to work around it.

Simplefb is also being developed as a way of protecting the BIOS setup
of the framebuffer past the boot process and out into use as a normal
user space console.  I in no way support this use. We have experienced
decades of problems on the x86 with VGA and BIOSes that I do not wish
to repeat in the ARM world. Write a correct, device specific
framebuffer driver for this piece of hardware. That device specific
driver will load before the clock/regulator cleanup and claim all of
the correct resources.

>
>
> As regulators were also mentioned, they already have a
> "regulator-boot-on" property defined. Perhaps this is suitable to be
> mirrored for clocks. If it is not, then I'm wondering why we have it.
> A key difference here is that the property is part of the provider and
> can be dealt with in the clock driver rather than requiring a
> temporary driver.
>
> Rob
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.




-- 
Jon Smirl
jonsmirl@gmail.com
