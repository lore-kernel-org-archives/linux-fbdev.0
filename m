From: Rajendra Nayak <rnayak@ti.com>
Date: Mon, 25 Jun 2012 07:11:15 +0000
Subject: Re: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
Message-Id: <4FE80C43.6090802@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>	
 <1340372890-10091-6-git-send-email-rnayak@ti.com>
 <1340604478.12683.25.camel@lappyti>
In-Reply-To: <1340604478.12683.25.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 25 June 2012 11:37 AM, Tomi Valkeinen wrote:
> Hi,
>
> On Fri, 2012-06-22 at 19:18 +0530, Rajendra Nayak wrote:
>> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
>> and clk_unprepare() for the omapdss clocks.
>
> You used clk_prepare and clk_unprepare instead of clk_prepare_enable and
> clk_disable_unprepare. I didn't check the dss driver yet, but my hunch
> is that the clocks are normally not enabled/disabled from atomic
> context.
>
> What does the prepare/unprepare actually do? Is there any benefit in
> delaying preparing, i.e. is there a difference between prepare right
> after clk_get, or prepare right before clk_enable? (And similarly for
> unprepare)

clk_prepare/unprepare are useful for clocks which need the 'enable'
logic to be implemented as a slow part (which can sleep) and a fast part
(which does not sleep). For all the dss clocks in question we don't need
a slow part and hence they do not have a .clk_prepare/unprepare
platform hook.

The framework however still does prepare usecounting (it has a prepare
count and an enable count, and prepare count is expected to be non-zero
while the clock is being enabled) and uses a mutex around to guard it.
So while the dss driver would do multiple clk_enable/disable while its
active, it seems fair to just prepare/unprepare the clocks once just
after clk_get() and before clk_put() in this particular case.

>
>   Tom
>

