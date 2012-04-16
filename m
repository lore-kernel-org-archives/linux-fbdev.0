From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 16 Apr 2012 00:31:52 +0000
Subject: RE: [PATCH] video: exynos_dp: add analog and pll control setting
Message-Id: <000d01cd1b68$5188f010$f49ad030$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <001301cd1230$5c9a7910$15cf6b30$%han@samsung.com>
In-Reply-To: <001301cd1230$5c9a7910$15cf6b30$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

> -----Original Message-----
> From: Florian Tobias Schandinat [mailto:FlorianSchandinat@gmx.de]
> Sent: Monday, April 16, 2012 6:40 AM
> To: Jingoo Han
> Cc: linux-fbdev@vger.kernel.org
> Subject: Re: [PATCH] video: exynos_dp: add analog and pll control setting
> 
> Hi Jingoo,
> 
> On 04/04/2012 06:58 AM, Jingoo Han wrote:
> > This patch adds analog and pll control setting. This control setting
> > is used for DP TX PHY block.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/video/exynos/exynos_dp_core.h |    1 +
> >  drivers/video/exynos/exynos_dp_reg.c  |   14 ++++++++++++++
> >  drivers/video/exynos/exynos_dp_reg.h  |    6 ++++++
> >  3 files changed, 21 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
> > index 90ceaca..519c3a6 100644
> > --- a/drivers/video/exynos/exynos_dp_core.h
> > +++ b/drivers/video/exynos/exynos_dp_core.h
> > @@ -39,6 +39,7 @@ struct exynos_dp_device {
> >  void exynos_dp_enable_video_mute(struct exynos_dp_device *dp, bool enable);
> >  void exynos_dp_stop_video(struct exynos_dp_device *dp);
> >  void exynos_dp_lane_swap(struct exynos_dp_device *dp, bool enable);
> > +void exynos_dp_init_analog_param(struct exynos_dp_device *dp);
> >  void exynos_dp_init_interrupt(struct exynos_dp_device *dp);
> >  void exynos_dp_reset(struct exynos_dp_device *dp);
> >  void exynos_dp_config_interrupt(struct exynos_dp_device *dp);
> > diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
> > index 6548afa..d9c66fd 100644
> > --- a/drivers/video/exynos/exynos_dp_reg.c
> > +++ b/drivers/video/exynos/exynos_dp_reg.c
> > @@ -65,6 +65,19 @@ void exynos_dp_lane_swap(struct exynos_dp_device *dp, bool enable)
> >  	writel(reg, dp->reg_base + EXYNOS_DP_LANE_MAP);
> >  }
> >
> > +void exynos_dp_init_analog_param(struct exynos_dp_device *dp)
> > +{
> > +	writel(0x10, dp->reg_base + EXYNOS_DP_ANALOG_CTL_1);
> > +
> > +	writel(0x0c, dp->reg_base + EXYNOS_DP_ANALOG_CTL_2);
> > +
> > +	writel(0x85, dp->reg_base + EXYNOS_DP_ANALOG_CTL_3);
> > +
> > +	writel(0x66, dp->reg_base + EXYNOS_DP_PLL_FILTER_CTL_1);
> > +
> > +	writel(0x0, dp->reg_base + EXYNOS_DP_TX_AMP_TUNING_CTL);
> 
> can you please add some comments to the above what these hex magic
> actually means/why you write exactly those values to the registers?

OK, I will send the patch v2.
It will include what is the meaning and why it is needed.

Thank you.

> 
> > +}
> > +
> >  void exynos_dp_init_interrupt(struct exynos_dp_device *dp)
> >  {
> >  	/* Set interrupt pin assertion polarity as high */
> > @@ -131,6 +144,7 @@ void exynos_dp_reset(struct exynos_dp_device *dp)
> >
> >  	writel(0x00000101, dp->reg_base + EXYNOS_DP_SOC_GENERAL_CTL);
> >
> > +	exynos_dp_init_analog_param(dp);
> >  	exynos_dp_init_interrupt(dp);
> >  }
> >
> > diff --git a/drivers/video/exynos/exynos_dp_reg.h b/drivers/video/exynos/exynos_dp_reg.h
> > index 42f608e..291e852 100644
> > --- a/drivers/video/exynos/exynos_dp_reg.h
> > +++ b/drivers/video/exynos/exynos_dp_reg.h
> > @@ -24,6 +24,12 @@
> >
> >  #define EXYNOS_DP_LANE_MAP			0x35C
> >
> > +#define EXYNOS_DP_ANALOG_CTL_1			0x370
> > +#define EXYNOS_DP_ANALOG_CTL_2			0x374
> > +#define EXYNOS_DP_ANALOG_CTL_3			0x378
> > +#define EXYNOS_DP_PLL_FILTER_CTL_1		0x37C
> > +#define EXYNOS_DP_TX_AMP_TUNING_CTL		0x380
> > +
> >  #define EXYNOS_DP_AUX_HW_RETRY_CTL		0x390
> >
> >  #define EXYNOS_DP_COMMON_INT_STA_1		0x3C4
> 
> Thanks,
> 
> Florian Tobias Schandinat

