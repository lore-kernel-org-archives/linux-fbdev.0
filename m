From: Tony Lindgren <tony@atomide.com>
Date: Tue, 13 Jan 2015 15:56:35 +0000
Subject: Re: [PATCH v4 3/3] arm: dts: omap3-gta04: Add handling for tv output
Message-Id: <20150113155634.GD2419@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417642402-20538-1-git-send-email-marek@goldelico.com>
 <1417642402-20538-4-git-send-email-marek@goldelico.com>
 <54B4EF43.50300@ti.com>
In-Reply-To: <54B4EF43.50300@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [150113 02:14]:
> On 03/12/14 23:33, Marek Belisko wrote:
> > Add handling for gta04 tv out chain:
> > venc -> opa362 -> svideo
> > 
> > Use invert-polarity in venc node because opa362
> > is doing polarity inversion also.
> > 
> > Signed-off-by: Marek Belisko <marek@goldelico.com>
> > ---
> >  arch/arm/boot/dts/omap3-gta04.dtsi | 49 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> 
> Looks fine to me.
> 
> Tony, do you want to pick this up? I can take the first two patches via
> fbdev.

OK will pick the dtsi change.

Thanks,

Tony
