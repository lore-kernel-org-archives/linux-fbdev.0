From: Grant Likely <grant.likely@linaro.org>
Date: Tue, 11 Nov 2014 21:49:50 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v4 0/5] simplefb: add clock handling code
Message-Id: <20141111214950.7FCABC41610@trevor.secretlab.ca>
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

On Sat, 1 Nov 2014 04:47:56 +0800
, Rob Herring <robherring2@gmail.com>
 wrote:
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

I've spent most of today rereading the entire thread and thinking about
this issue. Given that the clock binding is a well established core
binding at this point, it is entirely reasonable for a generic driver to
have part of the binding specify the clock resources that it depends on
to keep working. The binding needs to be very clear that it is a mere
dependency, and that the OS must not make any attempt to modify the
clock settings, but it is reasonable indicate to the OS that the clocks
are used by the firmware framebuffer, and turning them off will cause
the framebuffer will break. The best place to provide that guidance is
directly in the node.

If we were talking about a resource that didn't have a well established
binding, ie, the video path configuration, then I'd still say no way
because there is no way to do it generically. Claiming clocks on the
other hand is straight forward and simple.

Aside from wanting the documentation to be more explicit about what the
driver does with the clocks, I don't have a problem with doing it.

However, I am concerned about handover. I've lost track over the entire
thread on whether the handover mechanism has been resolved, and I would
really like to have a proposed solution to this documented in the
binding. The fact that there is nothing tying the simple framebuffer to
the actual hardware backing the framebuffer is concerning. It means the
kernel needs to guess which graphics device is associated with the
framebuffer.

The best solution in my opinion is to embed the simplefb properties
directly into the graphics device node (Yes, I know some have argued
that the graphics subsystem is composed of multiple devices; That
doesn't matter. Just choose one of the device nodes; the device that
actually DMAs the video buffer is probably the correct choice). That
makes it crystal clear which graphics controller owns the framebuffer.
There is precedence in DT bindings for putting current state into the
tree. offb.c is trying to solve the exact same problem. It also means
that we can use the driver model to provide mutual exclusion between
probing simplefb and a full-featured driver.

That approach would require some modifications of the binding to make
sure properties don't conflict with the device specific properties. The
easiest way is to allow the properties to live in a sub node so that the
reg property doesn't conflict.

However, I'm not stuck on this approach. The solution must be
unambiguious, and the handover mechanism must be thought through, but it
doesn't /have/ to be what I suggested above if a proposal that can be
well argued as better.

Hans, let's talk about this tomorrow. #devicetree on freenode? It looks like
I'm committed to volunteer at my daughters school tomorrow morning, but
the afternoon looks good.

g.

