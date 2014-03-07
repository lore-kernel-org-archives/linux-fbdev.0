From: Tony Lindgren <tony@atomide.com>
Date: Fri, 07 Mar 2014 16:49:29 +0000
Subject: Re: [PATCHv3 00/41] OMAPDSS: DT support v3
Message-Id: <20140307164929.GC3789@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <531823C5.1020008@ti.com>
In-Reply-To: <531823C5.1020008@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140305 23:32]:
> Hi Tony,
> 
> On 21/01/14 12:56, Tomi Valkeinen wrote:
> > Hi,
> > 
> > Here's version 3 of the DSS DT series.
> 
> Can you have a look at the arch/arm/ parts in the series and ack if
> they're ok, i.e, patches 1, 2, 32.

Patches 1, 2 & 32 look OK to me, so for those please feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>

There's a minor merge conflict in pdata-quirks.c, but that's trivial
so it should be OK for you to queue those along with the DSS patches.

> Then there are the .dts patches, 22-30, for which I haven't been able to
> get any acks. I'm not sure who I should get acks from for those, but I
> don't mind adding yours if you want to give it.
> 
> The .dts patches have had minor changes compared to the ones posted
> here, according to the DT bindings review comments, but nothing much has
> changed.

These will cause unnecessary merge conflicts all over the place:

Auto-merging arch/arm/boot/dts/omap4.dtsi
CONFLICT (content): Merge conflict in arch/arm/boot/dts/omap4.dtsi
Auto-merging arch/arm/boot/dts/omap4-sdp.dts
CONFLICT (content): Merge conflict in arch/arm/boot/dts/omap4-sdp.dts
Auto-merging arch/arm/boot/dts/omap4-panda-common.dtsi
CONFLICT (content): Merge conflict in arch/arm/boot/dts/omap4-panda-common.dtsi
Auto-merging arch/arm/boot/dts/omap3.dtsi
Auto-merging arch/arm/boot/dts/omap3-n900.dts
CONFLICT (content): Merge conflict in arch/arm/boot/dts/omap3-n900.dts
Auto-merging arch/arm/boot/dts/omap3-igep0020.dts
CONFLICT (content): Merge conflict in arch/arm/boot/dts/omap3-igep0020.dts
Auto-merging arch/arm/boot/dts/omap3-beagle.dts
CONFLICT (content): Merge conflict in arch/arm/boot/dts/omap3-beagle.dts
Auto-merging arch/arm/boot/dts/omap3-beagle-xm.dts
CONFLICT (content): Merge conflict in arch/arm/boot/dts/omap3-beagle-xm.dts

How about do a pull request for just the .dts changes against current
omap-for-v3.15/dt branch ASAP for me so I can pull it in? That is assuming
that just the .dts changes alone won't break anything.

Then make sure your series works both ways and maybe do a follow up
patch that flips things over after the dependencies are merged.

Regards,

Tony
