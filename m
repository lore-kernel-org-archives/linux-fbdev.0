From: Tony Lindgren <tony@atomide.com>
Date: Tue, 11 Nov 2014 15:00:19 +0000
Subject: Re: [PATCH 3/4] arm: dts: omap3-gta04: Add handling for tv output
Message-Id: <20141111150018.GL31454@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-4-git-send-email-marek@goldelico.com>
 <20141110233050.GC31454@atomide.com> <5461BDC6.7090308@ti.com>
In-Reply-To: <5461BDC6.7090308@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [141110 23:44]:
> Tony,
> 
> On 11/11/14 01:30, Tony Lindgren wrote:
> > * Marek Belisko <marek@goldelico.com> [141103 14:01]:
> >> Add handling for gta04 tv out chain:
> >> venc -> opa362 -> svideo
> >>
> >> Signed-off-by: Marek Belisko <marek@goldelico.com>
> >> ---
> >>  arch/arm/boot/dts/omap3-gta04.dtsi | 48 ++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 48 insertions(+)
> > 
> > Applying this patch into omap-for-v3.19/dt thanks.
> 
> There are changes needed for this series, so don't apply yet.
> 
> I'll try to find the time to do a review and send comments soon.

I've already pushed out the omap-for-v3.19/dt branch with
this patch buried in it. I'd rather not start redoing the
branch if the $subject patch is mostly correct and usable
with changes to the driver patches.

However, if the $subject patch needs to be redone for
the driver changes, let me know and I'll redo the branch.

Regards,

Tony
