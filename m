From: Daniel Drake <dsd@laptop.org>
Date: Wed, 19 Jun 2013 17:26:43 +0000
Subject: MMP display subsystem questions
Message-Id: <CAMLZHHTmSzzcL-aqk6rMjuD8Ct2zno--p7tUGfVVsocWiyhf8A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

I am working on adding OLPC XO-1.75 (MMP2) and XO-4 (MMP3) support to
the new MMP framebuffer subsystem (drivers/video/mmp). This involves
writing devicetree bindings and documenting them, which calls for a
good understanding of the subsystem.

I have a few questions.

Is there a design document available somewhere? There are very few
explanatory comments in the code. I am interested in definitions and
explanations of:
 - Paths
 - Overlays
 - dmafetch (part of overlay configuration)
 - path_config (part of path configuration)
 - link_config (part of path configuration)

Looking at the code for answers, I am a little confused.

A path is an output device (e.g. a panel or TV). There can be multiple
outputs connected to the display controller. At the moment I am just
working with a single dumb panel.

A path can have many overlays, and according to the original commit
message, an overlay is a buffer displayed on the path's output device.
However, I simply cannot see how multiple overlays would be supported
on a path. For example let's look at this function:

static int overlay_set_addr(struct mmp_overlay *overlay, struct mmp_addr *addr)
{
struct lcd_regs *regs = path_regs(overlay->path);

/* FIXME: assert addr supported */
memcpy(&overlay->addr, addr, sizeof(struct mmp_win));
writel(addr->phys[0], &regs->g_0);

return overlay->addr.phys[0];
}

The overlay's address is written to a register that is specific to
it's parent path. If we are dealing with two overlays, how does this
work? We write both overlay addresses to the same register and the
second one "wins"? I checked all of the other overlay-related
functions and they all defer to the parent path as well.

As an experiment I modified platform data to suggest that my path has
98 overlays and the framebuffer should run on overlay 33. Nonsense,
but the framebuffer booted up as normal. It seems like there is
something missing in this path/overlay relationship.

What is the plan going forward for this overlay management? At the
moment there is only one consumer of overlays in the kernel - the
framebuffer driver. And the framebuffer will only ever use one. Who
are the other intended in-kernel users of overlays?

Moving onto dmafetch_id. Can't find any documentation here. It looks
like the only meaningful values are 0 and 1, and the only difference
is that overlay_is_vid() returns 1 if dmafetch_id is 1, and 0
otherwise. This causes some minor differences in the way registers get
programmed, but I don't understand exactly what the consequences are
here. My framebuffer works with dmafetch_id as both 0 and 1.

path_config: this value gets written to registers LCD_SCLK *and*
IOPAD_CONTROL. The bit definitions in these registers are totally
different. It seems like nonsense to share the same configuration
value between two diversely different registers - what is going on
here?

link_config: Seems to have a dual meaning. Upper 4 bits can be used to
specify dumb panel mode in registers like LCD_DUMB_CTRL. Bit 0 is
totally unrelated and triggers "swap RB" i.e. use BGR instead of RGB,
when dealing with totally different registers. Other bits are ignored.
If "disorganised" bitfields are to be haphazardly invented in this way
it would at least be nice to have documentation.

Moving onto the devicetree definition. It is clear that representing
the display controller and the panel in the device tree makes sense;
this can cause the appropriate probes to happen. But we additionally
need to trigger the probe of the framebuffer driver. I am not sure if
the framebuffer that Linux will setup is something that should be
represented in the device tree (remember that we already have display
controller and panel). Looking at the configuration items needed to
setup the framebuffer:

1. Name - doesn't really matter.

2. Pixel format - surely this question applies to all framebuffer
drivers. I guess there is a default, plus a standard framebuffer
interface that allows it to be changed?

3. Which path to use - how do other framebuffer drivers deal with
this? The question here is basically do we output to the laptop's
inbuilt LCD panel, or to the externally connected HDMI TV? Again,
maybe we can choose a sensible default and allow runtime
configuration.

4. Which overlay to use - according to my investigation above, this
doesn't actually have any meaningful effect on the driver.

5. dmafetch_id - its not clear to me what this is.


So, I don't think the framebuffer is something that should be defined
by the platform (or the device tree). Instead, maybe it should just be
initialized with good defaults when the first path becomes ready for
use.

Any clarifications appreciated.

Thanks
Daniel
