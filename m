From: Inki Dae <inki.dae@samsung.com>
Date: Fri, 21 Sep 2012 06:01:52 +0000
Subject: RE: [PATCH v2 2/2] video: exynos_mipi_dsi: Remove unnecessary NULL check
Message-Id: <005c01cd97be$98d8d520$ca8a7f60$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348204007-1347-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1348204007-1347-2-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Acked-by: Inki Dae <inki.dae@samsung.com>

> -----Original Message-----
> From: Sachin Kamat [mailto:sachin.kamat@linaro.org]
> Sent: Friday, September 21, 2012 2:07 PM
> To: linux-fbdev@vger.kernel.org
> Cc: inki.dae@samsung.com; FlorianSchandinat@gmx.de;
> sachin.kamat@linaro.org; patches@linaro.org
> Subject: [PATCH v2 2/2] video: exynos_mipi_dsi: Remove unnecessary NULL
> check
> 
> 'dsim' is allocated and checked for NULL in the probe function.
> Hence this check is redundant. This cleanup also fixes a potential NULL
> pointer dereference error when dsim which is NULL references its member
> in the error print message.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/video/exynos/exynos_mipi_dsi_common.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_mipi_dsi_common.c
> b/drivers/video/exynos/exynos_mipi_dsi_common.c
> index 7cc4113..3cd29a4 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi_common.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi_common.c
> @@ -79,11 +79,6 @@ irqreturn_t exynos_mipi_dsi_interrupt_handler(int irq,
> void *dev_id)
>  	struct mipi_dsim_device *dsim = dev_id;
>  	unsigned int intsrc, intmsk;
> 
> -	if (dsim = NULL) {
> -		dev_err(dsim->dev, "%s: wrong parameter\n", __func__);
> -		return IRQ_NONE;
> -	}
> -
>  	intsrc = exynos_mipi_dsi_read_interrupt(dsim);
>  	intmsk = exynos_mipi_dsi_read_interrupt_mask(dsim);
>  	intmsk = ~intmsk & intsrc;
> --
> 1.7.4.1

