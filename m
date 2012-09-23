From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 23 Sep 2012 19:50:01 +0000
Subject: Re: [PATCH] video: exynos_dp: increase AUX channel voltage level
Message-Id: <505F67E9.4000803@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <003e01cd90bb$8332a1b0$8997e510$%han@samsung.com>
In-Reply-To: <003e01cd90bb$8332a1b0$8997e510$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 09/12/2012 07:52 AM, Jingoo Han wrote:
> The value of AUX channel differential amplitude current is changed
> from 8 mA to 16 mA, in order to increase AUX channel voltage level.
> In this case, AUX channel voltage level can be changed from 400 mV
> to 800 mV, when resistance between AUX TX and RX is 100 ohm.
> 
> According to DP spec, although the normative voltage level is 390 mV,
> the informative voltage level is 430 mV. So, 800 mV can be helpful
> to improve voltage margin of AUX channel.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied. But it might be a good idea to keep the old definition in the
header file for documentation purposes.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/exynos/exynos_dp_reg.c |    2 +-
>  drivers/video/exynos/exynos_dp_reg.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
> index 20e441f..5fd1214 100644
> --- a/drivers/video/exynos/exynos_dp_reg.c
> +++ b/drivers/video/exynos/exynos_dp_reg.c
> @@ -77,7 +77,7 @@ void exynos_dp_init_analog_param(struct exynos_dp_device *dp)
>  	writel(reg, dp->reg_base + EXYNOS_DP_ANALOG_CTL_3);
>  
>  	reg = PD_RING_OSC | AUX_TERMINAL_CTRL_50_OHM |
> -		TX_CUR1_2X | TX_CUR_8_MA;
> +		TX_CUR1_2X | TX_CUR_16_MA;
>  	writel(reg, dp->reg_base + EXYNOS_DP_PLL_FILTER_CTL_1);
>  
>  	reg = CH3_AMP_400_MV | CH2_AMP_400_MV |
> diff --git a/drivers/video/exynos/exynos_dp_reg.h b/drivers/video/exynos/exynos_dp_reg.h
> index 125b27c..0e79031 100644
> --- a/drivers/video/exynos/exynos_dp_reg.h
> +++ b/drivers/video/exynos/exynos_dp_reg.h
> @@ -187,7 +187,7 @@
>  #define PD_RING_OSC				(0x1 << 6)
>  #define AUX_TERMINAL_CTRL_50_OHM		(0x2 << 4)
>  #define TX_CUR1_2X				(0x1 << 2)
> -#define TX_CUR_8_MA				(0x2 << 0)
> +#define TX_CUR_16_MA				(0x3 << 0)
>  
>  /* EXYNOS_DP_TX_AMP_TUNING_CTL */
>  #define CH3_AMP_400_MV				(0x0 << 24)

