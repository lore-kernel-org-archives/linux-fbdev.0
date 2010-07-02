From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 02 Jul 2010 09:18:03 +0000
Subject: Re: [PATCH 0/6] fbdev: sh-mobile: HDMI support for SH-Mobile SoCs
Message-Id: <Pine.LNX.4.64.1007011406561.17489@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1006301128310.17489@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1006301128310.17489@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Magnus

On Thu, 1 Jul 2010, Magnus Damm wrote:

> Hi Guennadi,
> 
> On Wed, Jun 30, 2010 at 6:55 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > This patch set adds a static HDMI support to SH-Mobile SoCs, specifically,
> > to sh7372 (ap4evb) in this version. "Static" means only 720p is supported
> > ATM. Also hotplug support is implemented without changing the framebuffer
> > geometry. Dynamic geometry reconfiguration is planned for a future patch.
> 
> I just gave your patches a quick try, and they seem to work fine on my
> AP4EVB board.
> 
> The timings are not perfect for my 16:9 LG monitor, but this is much
> better than nothing. I suppose next step will be to parse the EDID and
> dynamically configure the LCDC.

Yep, that's also my target.

> This version ties in the LCDC, but
> does nothing with sound, right?

Right.

> With this set of patches the HDMI port comes up as /dev/fb1. My AP4EVB
> board does not have any LCD panel mounted - both MIPI-DSI ports are
> empty and I have not bothered attaching the Ecovec WVGA panel. I've
> heard that's the case for most AP4EVB boards these days. So /dev/fb0
> ends up being unused.


Well, that's easy - we just put lcdc(0) after pcdc1 in the device list in 
board-ap4evb.c.

> Not sure how to get console output to /dev/fb1 easily - in my quick
> test I ended up removing the LCDC0 platform devices to get the HDMI on
> /dev/fb0.

Don't know about the console, I used gstreamer with "fbdevsink 
device=/dev/fb1" sink.

> Also, I'm very sad to discover that the penguin is gone. I
> wonder why, hint-hint. =)

Well, why - that's clear - no fish;) The reason is, that I'm saving power 
as long as no display is connected, and for that I use "fb_set_suspend()." 
I think, we want to keep it this way, right? I can relatively easily 
extend the driver to check-and-wait for a plugged in and turned on monitor 
at startup. At the moment I first initialise HDMI, it enables interrupts, 
receives a hotplug interrupt, starts reading EDID and enables EDID done 
interrupt. While waiting for that interrupt, the framebuffer begins its 
initialisation, tries to turn the display on, using the "platform" 
callback, the HDMI driver sees, that the display is not yet recognised, 
sets the "suspended" flag in framebuffer info. At the end of probing the 
LCDC driver checks that flag (or that's what it should do anyway), and if 
set, turns its own clock off and runtime-suspends itself. I can try to 
eliminate this first suspend / resume cycle for the case, when you probe 
with the monitor already turned on. But if you turn it on later, or if you 
turn it off and on later again - the penguin will be gone anyway, similar 
to if you switch ttys.

> I'll look at the patches in more detail tomorrow.

Good, thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
