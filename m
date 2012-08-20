From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 20 Aug 2012 09:04:07 +0000
Subject: Re: [PATCH 02/10] video: exynos_dp: Check DPCD return codes
Message-Id: <004901cd7eb2$c1514660$43f3d320$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344398064-13563-3-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1344398064-13563-3-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wednesday, August 08, 2012 12:54 PM Sean Paul wrote:

> 
> Add return code checks to the DPCD transactions in the SW link training.
> 
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Reviewed-by: Mandeep Singh Baines <msb@chromium.org>
> ---
>  drivers/video/exynos/exynos_dp_core.c |   65 ++++++++++++++++++++++-----------
>  1 files changed, 44 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index c6c016a..1836e33 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -258,8 +258,9 @@ static void exynos_dp_set_lane_lane_pre_emphasis(struct exynos_dp_device *dp,
>  	}
>  }
> 
> -static void exynos_dp_link_start(struct exynos_dp_device *dp)
> +static int exynos_dp_link_start(struct exynos_dp_device *dp)
>  {
> +	int ret;
>  	u8 buf[5];
>  	int lane;
>  	int lane_count;
> @@ -273,8 +274,10 @@ static void exynos_dp_link_start(struct exynos_dp_device *dp)
>  		dp->link_train.cr_loop[lane] = 0;
> 
>  	/* Set sink to D0 (Sink Not Ready) mode. */
> -	exynos_dp_write_byte_to_dpcd(dp, DPCD_ADDR_SINK_POWER_STATE,
> +	ret = exynos_dp_write_byte_to_dpcd(dp, DPCD_ADDR_SINK_POWER_STATE,
>  				DPCD_SET_POWER_STATE_D0);
> +	if (ret)
> +		return ret;

Could you use 'retval' instead of 'ret'?



> 
>  	/* Set link rate and count as you want to establish*/
>  	exynos_dp_set_link_bandwidth(dp, dp->link_train.link_rate);
> @@ -283,8 +286,10 @@ static void exynos_dp_link_start(struct exynos_dp_device *dp)
>  	/* Setup RX configuration */
>  	buf[0] = dp->link_train.link_rate;
>  	buf[1] = dp->link_train.lane_count;
> -	exynos_dp_write_bytes_to_dpcd(dp, DPCD_ADDR_LINK_BW_SET,
> +	ret = exynos_dp_write_bytes_to_dpcd(dp, DPCD_ADDR_LINK_BW_SET,
>  				2, buf);
> +	if (ret)
> +		return ret;
> 
>  	/* Set TX pre-emphasis to minimum */
>  	for (lane = 0; lane < lane_count; lane++)
> @@ -303,9 +308,13 @@ static void exynos_dp_link_start(struct exynos_dp_device *dp)
>  	for (lane = 0; lane < lane_count; lane++)
>  		buf[lane] = DPCD_PRE_EMPHASIS_PATTERN2_LEVEL0 |
>  			    DPCD_VOLTAGE_SWING_PATTERN1_LEVEL0;
> -	exynos_dp_write_bytes_to_dpcd(dp,
> +	ret = exynos_dp_write_bytes_to_dpcd(dp,
>  		DPCD_ADDR_TRAINING_LANE0_SET,
>  		lane_count, buf);
> +	if (ret)
> +		return ret;
> +
> +	return ret;
>  }
> 
>  static unsigned char exynos_dp_get_lane_status(u8 link_status[6], int lane)
> @@ -475,6 +484,7 @@ static int exynos_dp_check_max_cr_loop(struct exynos_dp_device *dp,
> 
>  static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
>  {
> +	int ret;
>  	u8 data;
>  	u8 link_status[6];
>  	int lane;
> @@ -488,8 +498,11 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
> 
>  	usleep_range(100, 101);
> 
> -	exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
> +	ret = exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
>  				6, link_status);
> +	if (ret)
> +		return ret;
> +
>  	lane_count = dp->link_train.lane_count;
> 
>  	if (exynos_dp_clock_recovery_ok(link_status, lane_count) = 0) {
> @@ -503,18 +516,22 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
> 
>  		buf[0] = DPCD_SCRAMBLING_DISABLED |
>  			 DPCD_TRAINING_PATTERN_2;
> -		exynos_dp_write_byte_to_dpcd(dp,
> +		ret = exynos_dp_write_byte_to_dpcd(dp,
>  			DPCD_ADDR_TRAINING_PATTERN_SET,
>  			buf[0]);
> +		if (ret)
> +			return ret;
> 
>  		for (lane = 0; lane < lane_count; lane++) {
>  			exynos_dp_set_lane_link_training(dp,
>  				dp->link_train.training_lane[lane],
>  				lane);
>  			buf[lane] = dp->link_train.training_lane[lane];
> -			exynos_dp_write_byte_to_dpcd(dp,
> +			ret = exynos_dp_write_byte_to_dpcd(dp,
>  				DPCD_ADDR_TRAINING_LANE0_SET + lane,
>  				buf[lane]);
> +			if (ret)
> +				return ret;
>  		}
>  		dp->link_train.lt_state = EQUALIZER_TRAINING;
>  	} else {
> @@ -551,18 +568,21 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
>  					dp->link_train.training_lane[lane],
>  					lane);
>  				buf[lane] = dp->link_train.training_lane[lane];
> -				exynos_dp_write_byte_to_dpcd(dp,
> +				ret = exynos_dp_write_byte_to_dpcd(dp,
>  					DPCD_ADDR_TRAINING_LANE0_SET + lane,
>  					buf[lane]);
> +				if (ret)
> +					return ret;
>  			}
>  		}
>  	}
> 
> -	return 0;
> +	return ret;
>  }
> 
>  static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
>  {
> +	int ret;
>  	u8 link_status[6];
>  	int lane;
>  	int lane_count;
> @@ -573,8 +593,10 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
> 
>  	usleep_range(400, 401);
> 
> -	exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
> +	ret = exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
>  				6, link_status);
> +	if (ret)
> +		return ret;
>  	lane_count = dp->link_train.lane_count;
> 
>  	if (exynos_dp_clock_recovery_ok(link_status, lane_count) = 0) {
> @@ -614,9 +636,11 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
>  						dp->link_train.training_lane[lane],
>  						lane);
>  					buf[lane] = dp->link_train.training_lane[lane];
> -					exynos_dp_write_byte_to_dpcd(dp,
> +					ret = exynos_dp_write_byte_to_dpcd(dp,
>  						DPCD_ADDR_TRAINING_LANE0_SET + lane,
>  						buf[lane]);
> +					if (ret)
> +						return ret;
>  				}
>  			}
>  		}
> @@ -624,7 +648,7 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
>  		exynos_dp_reduce_link_rate(dp);
>  	}
> 
> -	return 0;
> +	return ret;
>  }
> 
>  static void exynos_dp_get_max_rx_bandwidth(struct exynos_dp_device *dp,
> @@ -692,28 +716,25 @@ static void exynos_dp_init_training(struct exynos_dp_device *dp,
> 
>  static int exynos_dp_sw_link_training(struct exynos_dp_device *dp)
>  {
> -	int retval = 0;
> -	int training_finished;
> +	int ret = 0, training_finished = 0;
> 
>  	/* Turn off unnecessary lane */
>  	if (dp->link_train.lane_count = 1)
>  		exynos_dp_set_analog_power_down(dp, CH1_BLOCK, 1);
> 
> -	training_finished = 0;
> -
>  	dp->link_train.lt_state = START;
> 
>  	/* Process here */
> -	while (!training_finished) {
> +	while (!ret && !training_finished) {
>  		switch (dp->link_train.lt_state) {
>  		case START:
> -			exynos_dp_link_start(dp);
> +			ret = exynos_dp_link_start(dp);
>  			break;
>  		case CLOCK_RECOVERY:
> -			exynos_dp_process_clock_recovery(dp);
> +			ret = exynos_dp_process_clock_recovery(dp);
>  			break;
>  		case EQUALIZER_TRAINING:
> -			exynos_dp_process_equalizer_training(dp);
> +			ret = exynos_dp_process_equalizer_training(dp);
>  			break;
>  		case FINISHED:
>  			training_finished = 1;
> @@ -722,8 +743,10 @@ static int exynos_dp_sw_link_training(struct exynos_dp_device *dp)
>  			return -EREMOTEIO;
>  		}
>  	}
> +	if (ret)
> +		dev_err(dp->dev, "eDP link training failed (%d)\n", ret);
> 
> -	return retval;
> +	return ret;
>  }
> 
>  static int exynos_dp_set_link_train(struct exynos_dp_device *dp,
> --
> 1.7.7.3

