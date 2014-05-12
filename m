From: Tony Lindgren <tony@atomide.com>
Date: Mon, 12 May 2014 14:40:35 +0000
Subject: Re: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and probably 3630
Message-Id: <20140512144035.GD31772@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-2-git-send-email-tony@atomide.com>
 <536C860E.1000501@ti.com>
 <CALbNGRR3U1veFgXmOWpfG3yNVESdxi2t79WDrJwOZ1oShuG1yA@mail.gmail.com>
 <20140511144209.GA28266@atomide.com>
 <CALbNGRQpieZ+b-PvC+K2Zxb3hOd6KOCrPVOnveds-fXENn8GJg@mail.gmail.com>
In-Reply-To: <CALbNGRQpieZ+b-PvC+K2Zxb3hOd6KOCrPVOnveds-fXENn8GJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

* Andreas Müller <schnitzeltony@googlemail.com> [140512 01:20]:
> On Sun, May 11, 2014 at 4:42 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Andreas Müller <schnitzeltony@googlemail.com> [140509 14:07]:
> >> On Fri, May 9, 2014 at 9:38 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >> > On 30/04/14 02:52, Tony Lindgren wrote:
> >> >> Otherwise we can get often errors like the following and the
> >> >> display won't come on:
> >> >>
> >> >> omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
> >> >> omapdss APPLY error: SYNC_LOST on channel lcd, restarting
> >> >> the output with video overlays disabled
> >> >>
> >> >> There are some earlier references to this issue:
> >> >>
> >> >> http://www.spinics.net/lists/linux-omap/msg59511.html
> >> >> http://www.spinics.net/lists/linux-omap/msg59724.html
> >> >
> >> resend - my client had HTML enabled...
> >>
> >> FWIW: I have had issues long time ago [1]. With mainline 3.14.3 I had
> >> still the reboot problem on old 600MHz OMAP 3530. Applying this patch
> >> solved the issues. For other versions I had no chance to reproduce the
> >> original wakup issue mentioned in old thread
> >
> > Sorry I'm a bit confused now. Is the reboot issue a separate issue
> > related to the twl4030 generic scripts for 3530?
> >
> > And then this patch fixes dm3730 wake-up (from suspend?) issues?
> >
> > Or do we have some other bug where we wrongly hit omap3630_dss_feats
> > on 3530 somehow?
> (What I think) I have done: Have 3.14.3 still booting with legacy
> board init (please don't kill me for that). Without applying your
> patch old OMAP3530 crashed at every reboot with SYNCH_LOST.
> 
> After applying your patch reboot works fine.
> 
> Looking into id-code makes me wonder what changes on 36xx-features do
> to 35xx devices (treated as 34xx - right?). The only way that this
> happens is for unknown hawkeye fallthough. I suggest you simply forget
> my note and I will find out what really 'fixed' dss reboot problem.

Yeah 35xx should be treated as 34xx so sounds like there might be
some detection problem if this patch does something for your board.

Regards,

Tony
