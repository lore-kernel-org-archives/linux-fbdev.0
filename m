From: Rajendra Nayak <rnayak@ti.com>
Date: Tue, 26 Jun 2012 05:12:26 +0000
Subject: Re: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
Message-Id: <4FE941EA.7050108@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>			
 <1340372890-10091-6-git-send-email-rnayak@ti.com>		
 <1340604478.12683.25.camel@lappyti> <4FE80C43.6090802@ti.com>	
 <1340611133.3395.3.camel@deskari> <4FE85005.4090303@ti.com>
 <1340630090.3395.85.camel@deskari>
In-Reply-To: <1340630090.3395.85.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 25 June 2012 06:44 PM, Tomi Valkeinen wrote:
> venc and hdmi use clk_enable/disable in runtime PM callbacks (suspend&
> resume). If I understand correctly, the callbacks are not called in
> atomic context if pm_runtime_irq_safe() has not been used. And it is not
> used in omapdss.
>
> dsi uses clk_enable/disable in a different manner, but not in atomic
> context.
>
> So as far as I see, clocks are never handled in atomic context. Is
> everything related to the base clk stuff already in mainline? Can I take
> the clk_prepare/unprepare patch into my omapdss tree?

Well the Common Clk framework is already in mainline, but we still don;t
have CONFIG_COMMON_CLK enabled for our builds yet. So until we do so,
clk_prepare/unprepare will just be stubs which do nothing.
I will repost the patch getting rid of the clk_prepare/unprepare and
adding clk_prepare_enable/disable_unprepare instead.

>
>
> A question about clk_prepare/unprepare, not directly related: let's say
> I have a driver for some HW block. The driver doesn't use clk functions,
> but uses runtime PM. The driver also sets pm_runtime_irq_safe().
>
> Now, the driver can call pm_runtime_get_sync() in an atomic context, and
> this would lead to the underlying framework (hwmod, omap_device, I don't
> know who =) enabling the func clock for that HW. But this would happen
> in atomic context, so the underlying framework can't use clk_prepare.
>
> How does the underlying framework handle that case? (sorry if that's a
> stupid question =).

No, its not a stupid question at all. I have been thinking about this
too to figure out whats the best way to handle this. For now, the
patches I posted, do an early clk_prepare (like I did for dss) for all
hwmod clocks as I have no way to know which ones will have their
_enable, _idle etc called in atomic context. Maybe I should see if there
is a way I can do so only for those devices which end up calling a
pm_runtime_irq_safe() and not do it early for all.

>

