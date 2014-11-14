From: Tony Lindgren <tony@atomide.com>
Date: Fri, 14 Nov 2014 18:01:04 +0000
Subject: Re: [PATCH 4/4] arm: dts: omap3-gta04: Add static configuration for devconf1 register
Message-Id: <20141114180104.GT31250@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-5-git-send-email-marek@goldelico.com>
 <5463585D.9070209@ti.com> <20141112150210.GC26481@atomide.com>
 <5464969F.30708@ti.com> <20141113182848.GQ26481@atomide.com>
 <alpine.DEB.2.02.1411132251320.17030@utopia.booyaka.com>
 <20141113235840.GS26481@atomide.com> <5465AFF6.506@ti.com>
In-Reply-To: <5465AFF6.506@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [141113 23:33]:
> On 11/14/2014 01:58 AM, Tony Lindgren wrote:
> 
> The PRCM/clock cleanups that I have under work basically splits the clock
> inits under their respective IP blocks; currently everything is registered
> under generic PRCM. System control module will be one of the clock providers
> (and is going to look like a driver), which will be registering its own
> clocks.

Yes that's nice. The clock modules in the SCM should probably use the
syscon mapping unless there's a clear separate IO area for them. And
then use pinctrl for registers that are muxes for external pins unless
they are in some dedicated clock register area.

> This doesn't change the fact that pinctrl is directly mapping its
> own register space atm though, it might be possible to re-route this to use
> the generic system control module if need be though.

Mapping dedicated IO areas to individual drivers is not a problem. These
drivers can eventually be children of a core SCM driver if needed.
 
> I guess its just a political decision which way we want to go, currently we
> have lots of system control clocks under the clock data (for
> AM33xx,AM43xx,OMAP3), but we can remove these easily if need be. In some
> cases it is nicer to have the data in the clock tree though, the drivers
> don't need to care if they are touching a clock or a pinctrl entity. Some
> people have been converting additional stuff to CCF outside of PRCM, like
> Archit did some work to try and get control module clock support for DRA7,
> and Tomi has been talking to convert some of the DSS internal clocks to CCF
> also.

Setting up CCF drivers for SCM makes sense to me. I suggest the
following guidelines:

1. If there's a clear separate dedicated IO area in SCM, it can be
   a driver implementing a Linux generic framework for CCF, regulators,
   pinctrl, or PHY.

2. For the random control registers, we should use syscon or
   pinctrl-single to implement Linux generic framwork functions for
   CCF, regulators, pinctrl or PHY.

3. For resource management, we can have a core SCM driver that takes
   care of the save and restore of registers and clocking if needed.
   I believe currently SCM clocks are always enabled though. We can
   set the drivers in #1 and #2 abobe to be childer of the core SCM
   driver if we ever need to manage clocks during runtime.

Regards,

Tony
