From: Tony Lindgren <tony@atomide.com>
Date: Thu, 13 Nov 2014 18:28:49 +0000
Subject: Re: [PATCH 4/4] arm: dts: omap3-gta04: Add static configuration for devconf1 register
Message-Id: <20141113182848.GQ26481@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-5-git-send-email-marek@goldelico.com>
 <5463585D.9070209@ti.com> <20141112150210.GC26481@atomide.com>
 <5464969F.30708@ti.com>
In-Reply-To: <5464969F.30708@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [141113 03:33]:
> On 12/11/14 17:02, Tony Lindgren wrote:
> 
> >> And, with a quick grep, I see CONTROL_DEVCONF1 touched in multiple
> >> places in the kernel. I wonder if adding a pinmux entry for it could
> >> cause some rather odd problems.
> > 
> > They can all use pinctrl-single no problem.
> 
> Can, but don't. That's my worry. If we touch the DEVCONF1 via pinmux,
> and we have code in mach-omap2 that also touch DEVCONF1, without any
> knowledge (and locking) between those...

Hmm yeah the McBSP clock mux could be racy as the mux register for
McBSP is treated as a clock. This register muxes the clock between
external pin and internal clock. Considering that this should be
selectable at board level as the external clock probably needs to be
used if level shifters are being used, it should be really handled by
pinctrl-single.

The other use for hsmmc.c and pdata-quirks.c for the one time mux for
MMC clock from the MMC clock pin. That can be done with pinctrl-single
from the MMC driver too for DT based booting.

Then we just have the save and restore of the registers for
off-idle.
 
> So _maybe_ that's not an issue, as the pinmux config we have here is
> fixed, and done once at boot time, and maybe the code in mach-omap2 that
> touch DEVCONF1 is also ran just once and not at the same time as the
> pinmux. But I don't know if that's so.

It seems we could just do a read-only check for McBSP in the clock
code for the mux register, or even completely drop that code from
cclock3xxx_data.c and start using the pinctrl for that mux.

Paul & Tero, got any comments here?

Regards,

Tony
