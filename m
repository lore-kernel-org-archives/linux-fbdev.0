From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Thu, 30 May 2013 15:43:55 +0000
Subject: Re: [PATCH 05/32] OMAPDSS: fix dss_get_ctx_loss_count for DT
Message-Id: <20130530154355.GM19468@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
 <1369906493-27538-6-git-send-email-tomi.valkeinen@ti.com>
 <20130530110945.GI19468@game.jcrosoft.org>
 <51A737DC.1010900@ti.com>
In-Reply-To: <51A737DC.1010900@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On 14:28 Thu 30 May     , Tomi Valkeinen wrote:
> On 30/05/13 14:09, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 12:34 Thu 30 May     , Tomi Valkeinen wrote:
> >> When using DT, dss device does not have platform data. However,
> >> dss_get_ctx_loss_count() uses dss device's platform data to find the
> >> get_ctx_loss_count function pointer.
> >>
> >> To fix this, dss_get_ctx_loss_count() needs to be changed to get the
> >> platform data from the omapdss device, which is a "virtual" device and
> >> always has platform data.
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >> ---
> >>  drivers/video/omap2/dss/dss.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> >> index 94f66f9..bd01608 100644
> >> --- a/drivers/video/omap2/dss/dss.c
> >> +++ b/drivers/video/omap2/dss/dss.c
> >> @@ -157,7 +157,8 @@ static void dss_restore_context(void)
> >>  
> >>  int dss_get_ctx_loss_count(void)
> >>  {
> >> -	struct omap_dss_board_info *board_data = dss.pdev->dev.platform_data;
> >> +	struct platform_device *core_pdev = dss_get_core_pdev();
> >> +	struct omap_dss_board_info *board_data = core_pdev->dev.platform_data;
> > 
> > 	how about store the pdata in the drivers internal struct and if !dt
> > 	you ust do this
> > 
> > 	dss_dev->pdata = *pdev->dev.platform_data;
> > 
> > 	to copy it and we do not alloc it for dt
> 
> It's not quite that simple. We need some OMAP arch functions (like
> get_ctx_loss_count here) that are not currently exposed via any other
> method to drivers except passing a function pointer with platform data.
> We need that also when booting with DT.
> 
> We have a bunch of devices for the display subsystem hardware blocks,
> like the "dss" here. When booting with DT, these blocks are represented
> in the DT data, and do not have platform data.
> 
> We also have a "virtual" device, "omapdss", which doesn't match any hw
> block. It's created in the arch setup stage. It's really a legacy thing,
> but with DT it can be used conveniently to pass the platform data.
> 
> The problem this patch fixes is that we used to pass the arch functions
> for each of those HW block drivers. But with DT, we need to get the arch
> functions from the "omapdss" device, gotten with dss_get_core_pdev().

ok

do not take it bad is it worth the effort those 54 patches?

is not better to work on DRM?
just an open question

Best Regards,
J.
> 
>  Tomi
> 
> 


