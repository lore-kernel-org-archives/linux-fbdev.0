From: Donghwa Lee <dh09.lee@samsung.com>
Date: Fri, 09 Mar 2012 00:07:02 +0000
Subject: Re: [PATCH] fb: exynos: Fix MIPI/DSI front/back porch settings
Message-Id: <4F5949A6.5030106@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331220954-13177-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1331220954-13177-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi, Laurent,

On Fri, Mar 9, 2012 at 00:35 AM, Laurent Pinchart wrote:

> The exynos_mipi_dsi_set_main_disp_[hv]porch() functions take front and
> back porch arguments in that order. This maps to the fb_videomode
> right/lower_margin and left/upper_margin respectively. Fix the caller
> accordingly.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/video/exynos/exynos_mipi_dsi_common.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 

It looks good to me.

Acked-by: Donghwa Lee <dh09.lee@samsung.com>

> diff --git a/drivers/video/exynos/exynos_mipi_dsi_common.c b/drivers/video/exynos/exynos_mipi_dsi_common.c
> index 14909c1..99f6451 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi_common.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi_common.c
> @@ -738,11 +738,11 @@ int exynos_mipi_dsi_set_display_mode(struct mipi_dsim_device *dsim,
>  		if (dsim_config->auto_vertical_cnt = 0) {
>  			exynos_mipi_dsi_set_main_disp_vporch(dsim,
>  				dsim_config->cmd_allow,
> -				timing->upper_margin,
> -				timing->lower_margin);
> +				timing->lower_margin,
> +				timing->upper_margin);
>  			exynos_mipi_dsi_set_main_disp_hporch(dsim,
> -				timing->left_margin,
> -				timing->right_margin);
> +				timing->right_margin,
> +				timing->left_margin);
>  			exynos_mipi_dsi_set_main_disp_sync_area(dsim,
>  				timing->vsync_len,
>  				timing->hsync_len);


