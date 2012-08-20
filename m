From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 20 Aug 2012 09:22:27 +0000
Subject: Re: [PATCH 07/10] video: exynos_dp: Improve EDID error handling
Message-Id: <004d01cd7eb5$50bf7f40$f23e7dc0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344398064-13563-8-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1344398064-13563-8-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wednesday, August 08, 2012 12:54 PM Sean Paul wrote:
> 
> EDID error handling has 2 problems:
>  - It doesn't fail as early as it can
>  - The retry counts for i2c and aux transactions are huge
> 
> This patch fails if the initial i2c transaction fails, and reduces the
> aux and i2c retry counts down to 3.
> 
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Reviewed-by: Olof Johansson <olofj@chromium.org>
> ---
>  drivers/video/exynos/exynos_dp_core.c |   18 ++++++++++--------
>  drivers/video/exynos/exynos_dp_reg.c  |    9 ++++-----
>  2 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index 1c998d9..2882362 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -89,9 +89,11 @@ static int exynos_dp_read_edid(struct exynos_dp_device *dp)
>  	 */
> 
>  	/* Read Extension Flag, Number of 128-byte EDID extension blocks */
> -	exynos_dp_read_byte_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
> +	retval = exynos_dp_read_byte_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
>  				EDID_EXTENSION_FLAG,
>  				&extend_block);
> +	if (retval)
> +		return retval;
> 
>  	if (extend_block > 0) {
>  		dev_dbg(dp->dev, "EDID data includes a single extension!\n");
> @@ -177,21 +179,21 @@ static int exynos_dp_handle_edid(struct exynos_dp_device *dp)
>  {
>  	u8 buf[12];
>  	int i;
> -	int retval;
> +	int ret;
> 
>  	/* Read DPCD DPCD_ADDR_DPCD_REV~RECEIVE_PORT1_CAP_1 */
> -	exynos_dp_read_bytes_from_dpcd(dp,
> -		DPCD_ADDR_DPCD_REV,
> -		12, buf);
> +	ret = exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_DPCD_REV, 12, buf);
> +	if (ret)
> +		return ret;

Could you use 'retval' instead of 'ret'?

> 
>  	/* Read EDID */
>  	for (i = 0; i < 3; i++) {
> -		retval = exynos_dp_read_edid(dp);
> -		if (retval = 0)
> +		ret = exynos_dp_read_edid(dp);
> +		if (!ret)
>  			break;
>  	}
> 
> -	return retval;
> +	return ret;
>  }
> 
>  static void exynos_dp_enable_rx_to_enhanced_mode(struct exynos_dp_device *dp,
> diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
> index d7b1494..389e0f0 100644
> --- a/drivers/video/exynos/exynos_dp_reg.c
> +++ b/drivers/video/exynos/exynos_dp_reg.c
> @@ -547,7 +547,7 @@ int exynos_dp_write_bytes_to_dpcd(struct exynos_dp_device *dp,
>  		else
>  			cur_data_count = count - start_offset;
> 
> -		for (i = 0; i < 10; i++) {
> +		for (i = 0; i < 3; i++) {
>  			/* Select DPCD device address */
>  			reg = AUX_ADDR_7_0(reg_addr + start_offset);
>  			writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_7_0);
> @@ -612,7 +612,7 @@ int exynos_dp_read_bytes_from_dpcd(struct exynos_dp_device *dp,
>  			cur_data_count = count - start_offset;
> 
>  		/* AUX CH Request Transaction process */
> -		for (i = 0; i < 10; i++) {
> +		for (i = 0; i < 3; i++) {
>  			/* Select DPCD device address */
>  			reg = AUX_ADDR_7_0(reg_addr + start_offset);
>  			writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_7_0);
> @@ -695,7 +695,7 @@ int exynos_dp_read_byte_from_i2c(struct exynos_dp_device *dp,
>  	int i;
>  	int retval;
> 
> -	for (i = 0; i < 10; i++) {
> +	for (i = 0; i < 3; i++) {
>  		/* Clear AUX CH data buffer */
>  		reg = BUF_CLR;
>  		writel(reg, dp->reg_base + EXYNOS_DP_BUFFER_DATA_CTL);
> @@ -703,7 +703,6 @@ int exynos_dp_read_byte_from_i2c(struct exynos_dp_device *dp,
>  		/* Select EDID device */
>  		retval = exynos_dp_select_i2c_device(dp, device_addr, reg_addr);
>  		if (retval != 0) {
> -			dev_err(dp->dev, "Select EDID device fail!\n");
>  			continue;
>  		}
> 
> @@ -745,7 +744,7 @@ int exynos_dp_read_bytes_from_i2c(struct exynos_dp_device *dp,
>  	int retval = 0;
> 
>  	for (i = 0; i < count; i += 16) {
> -		for (j = 0; j < 100; j++) {
> +		for (j = 0; j < 3; j++) {
>  			/* Clear AUX CH data buffer */
>  			reg = BUF_CLR;
>  			writel(reg, dp->reg_base + EXYNOS_DP_BUFFER_DATA_CTL);
> --
> 1.7.7.3

