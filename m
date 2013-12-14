From: Tony Lindgren <tony@atomide.com>
Date: Sat, 14 Dec 2013 14:09:14 +0000
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Message-Id: <20131214140913.GA12324@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
 <1703598.NbqXAMAFOI@avalon>
 <52AADBE0.3030203@ti.com>
 <3426377.keoaFgiZkl@avalon>
 <52AB2C25.6000507@ti.com>
 <20131213172234.GD28184@atomide.com>
 <52AC0A18.30405@ti.com>
In-Reply-To: <52AC0A18.30405@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131213 23:36]:
> On 2013-12-13 19:22, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [131213 07:49]:
> >> Hi Laurent, Tony,
> >>
> >> On 2013-12-13 16:37, Laurent Pinchart wrote:
> >>
> >>>>> - dsi_enable_pads, dsi_disable_pads: Those don't seem to be used in
> >>>>> mainline. What's their purpose, and how are they implemented on platforms
> >>>>> that make use of them ? Is the pinmux API an option ?
> >>>>
> >>>> They are used in mainline, grep again =).
> >>>
> >>> The only implementations I can find in arch/arm/mach-omap2/display.c are
> >>>
> >>> static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
> >>> {
> >>>         return 0;
> >>> }
> >>>
> >>> static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
> >>> {
> >>> }
> >>
> >> Yep. It seems Tony removed the muxing for -rc2 in
> >> e30b06f4d5f000c31a7747a7e7ada78a5fd419a1 ARM: OMAP2+: Remove legacy mux
> >> code for display.c
> >>
> >> Tony, that patch removes DSI muxing, which is not done via DT. I can't
> >> test right now, but I presume DSI displays don't work at all after -rc2.
> > 
> > Hmm I suggest you test against commit adfe9361b236 (ARM: dts: Add basic
> > devices on am3517-evm) as it does not yet remove the legacy data and
> > that's what's heading to linux next soonish.
> 
> That commit is not in the mainline. I'm talking about mainline.
> v3.13-rc3 contains e30b06f4d5f000c31a7747a7e7ada78a5fd419a1, and that
> breaks DSI displays (just tested). It needs to be reverted (although the
> HDMI parts can probably be removed).
> 
> Why was e30b06f4d5f000c31a7747a7e7ada78a5fd419a1 merged into -rc2? It's
> not a fix, just a cleanup.

Hmm OK sorry looks like I removed some non-legacy mux framework code
by accident. The omap_mux_* parts clearly are dead code for omap4 as
it's been DT only since v3.10, but the omap4_dsi_mux_pads() is not
using omap_mux_* functions.

Yes, let's revert e30b06f4d5f0 except for the dead code parts, which
seems to be omap4_tpd12s015_mux_pads(), right?
 
> > With the DT configured displays that muxing needs to be done in the
> > DSS driver(s) using pinctrl-single.
> 
> We don't have any DT configured displays in the mainline.

Yes sorry omap4_dsi_mux_pads() should not have been removed.
 
> pinctrl-single doesn't support the kind of register that contains the
> DSI muxing. I don't know yet how that should be done. In any case, the
> muxing via DT should've been added at the same time as removing the
> muxing via platform callback in e30b06f4d5f000c31a77.
> 
> > BTW, I suspect quite a few of the DSI using boards have been broken a
> > while before 0b2aa8bed3e1 (gpio: twl4030: Fix regression for twl gpio
> > output) as at least the following have been using TWL GPIO to enable
> > the panel:
> > 
> > board-3430sdp.c
> > board-devkit8000.c
> > board-ldp.c
> > board-omap3stalker.c
> > 
> > This was the case at least for LDP.
> 
> Only 4430sdp has a DSI display in the mainline. Those boards have DPI
> displays.

Oops right, those are DPI.

Regards,

Tony
