From: Donghwa Lee <dh09.lee@samsung.com>
Date: Tue, 20 Nov 2012 02:12:32 +0000
Subject: Re: [PATCH 2/2] video: exynos-mipi-dsi: Adding DT support to exynos mipi driver
Message-Id: <50AAE710.3050900@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352547285-12302-3-git-send-email-shaik.ameer@samsung.com>
In-Reply-To: <1352547285-12302-3-git-send-email-shaik.ameer@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 10 Nov, 2012 20:34, Shaik Ameer Basha wrote:

> This patch adds the DT support for the exynos mipi-dsi driver.
> for DT support mipi device node should supply the following
> information to the mipi-dsi driver.
> 1] dsim_config information
> 2] d-phy setting information
> 3] lcd poweron, reset information
> 4] fb_videomode information
> [...]

>  

> diff --git a/include/video/exynos_mipi_dsim.h b/include/video/exynos_mipi_dsim.h
> index 772c770..6d9b01d 100644
> --- a/include/video/exynos_mipi_dsim.h
> +++ b/include/video/exynos_mipi_dsim.h
> @@ -230,6 +230,7 @@ struct mipi_dsim_device {
>  	struct mipi_dsim_master_ops	*master_ops;
>  	struct mipi_dsim_lcd_device	*dsim_lcd_dev;
>  	struct mipi_dsim_lcd_driver	*dsim_lcd_drv;
> +	struct mipi_dsim_phy_config	*dsim_phy_config;
>  
>  	unsigned int			state;
>  	unsigned int			data_lane;
> @@ -295,6 +296,32 @@ struct mipi_dsim_master_ops {
>  };
>  
>  /*
> + * phy node structure for mipi-dsim.
> + *
> + * @reg_enable_dphy	: base address to memory mapped D-PHY enable register
> + * @ctrlbit_enable_dphy : control bit for enabling D-PHY
> + * @reg_reset_dsim	: base address to memory mapped DSIM reset register
> + * @ctrlbit_reset_dsim	: control bit for resetting DSIM
> + */
> +struct mipi_dsim_phy_config_type1 {
> +	void __iomem	*reg_enable_dphy;
> +	int		ctrlbit_enable_dphy;
> +	void __iomem	*reg_reset_dsim;
> +	int		ctrlbit_reset_dsim;
> +};
> +
> +enum mipi_dsim_phy_config_type {
> +	MIPI_DSIM_PHY_CONFIG_TYPE1,
> +};
> +
> +struct mipi_dsim_phy_config {
> +	enum mipi_dsim_phy_config_type type;
> +	union {
> +		struct mipi_dsim_phy_config_type1 phy_cfg_type1;
> +	};
> +};
> +
> +/*
>   * device structure for mipi-dsi based lcd panel.
>   *
>   * @name: name of the device to use with this device, or an


Hi,

Does mipi-phy-type1 means MIPI_PHYx_CONTROL register of PMU?
If so, why did you define only 'type1'? Even if you do not use 'type0' 
on your case, should be defined 'type0' in the 'mipi_dsim_phy_config_type'?

And Is it correct to access to the PMU registers directly in the mipi 
dsi driver to control mipi-phyx?

Thanks, 
Donghwa Lee
