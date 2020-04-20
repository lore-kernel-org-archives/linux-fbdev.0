From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 20 Apr 2020 16:37:44 +0000
Subject: Re: [PATCH V5 4/4] backlight: qcom-wled: Add support for WLED5 peripheral that is present on PM8150L
Message-Id: <20200420163744.3qbeqwv7myzmam3d@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1586274430-28402-1-git-send-email-kgunda@codeaurora.org>
 <1586274430-28402-5-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1586274430-28402-5-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, jingoohan1@gmail.com, Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, bjorn.andersson@linaro.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, linux-arm-msm@vger.kernel.org, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, lee.jones@linaro.org, linux-leds@vger.kernel.org

On Tue, Apr 07, 2020 at 09:17:10PM +0530, Kiran Gunda wrote:
> From: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> 
> PM8150L WLED supports the following:
>     - Two modulators and each sink can use any of the modulator
>     - Multiple CABC selection options from which one can be selected/enabled
>     - Multiple brightness width selection (12 bits to 15 bits)
> 
> Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 443 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 442 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index a6ddaa9..3a57011 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> ...
> +static const u8 wled5_brightness_reg[MOD_MAX] = {
> +	[MOD_A] = WLED5_SINK_REG_MOD_A_BRIGHTNESS_LSB,
> +	[MOD_B] = WLED5_SINK_REG_MOD_B_BRIGHTNESS_LSB,
> +};
> +
> +static const u8 wled5_src_sel_reg[MOD_MAX] = {
> +	[MOD_A] = WLED5_SINK_REG_MOD_A_SRC_SEL,
> +	[MOD_B] = WLED5_SINK_REG_MOD_B_SRC_SEL,
> +};
> +
> +static const u8 wled5_brt_wid_sel_reg[MOD_MAX] = {
> +	[MOD_A] = WLED5_SINK_REG_MOD_A_BRIGHTNESS_WIDTH_SEL,
> +	[MOD_B] = WLED5_SINK_REG_MOD_B_BRIGHTNESS_WIDTH_SEL,
> +};
> +

Each of these lookup tables are used exactly once... and half the time
when this code chooses between MOD_A and MOD_B a ternary is used and
half the time these lookup tables.

I suggest these be removed.


>  static int wled3_set_brightness(struct wled *wled, u16 brightness)
>  {
>  	int rc, i;
> @@ -225,6 +291,25 @@ static int wled4_set_brightness(struct wled *wled, u16 brightness)
>  	return 0;
>  }
>  
> +static int wled5_set_brightness(struct wled *wled, u16 brightness)
> +{
> +	int rc, offset;
> +	u16 low_limit = wled->max_brightness * 1 / 1000;

Multiplying by 1 is redundant.


> +	u8 v[2];
> +
> +	/* WLED5's lower limit is 0.1% */
> +	if (brightness < low_limit)
> +		brightness = low_limit;
> +
> +	v[0] = brightness & 0xff;
> +	v[1] = (brightness >> 8) & 0x7f;
> +
> +	offset = wled5_brightness_reg[wled->cfg.mod_sel];
> +	rc = regmap_bulk_write(wled->regmap, wled->sink_addr + offset,
> +			       v, 2);
> +	return rc;
> +}
> +
>  static void wled_ovp_work(struct work_struct *work)
>  {
>  	struct wled *wled = container_of(work,
> @@ -317,11 +420,67 @@ static int wled4_ovp_fault_status(struct wled *wled, bool *fault_set)
>  	return rc;
>  }
>  
> +static int wled5_ovp_fault_status(struct wled *wled, bool *fault_set)
> +{
> +	int rc;
> +	u32 int_rt_sts, fault_sts;
> +
> +	*fault_set = false;
> +	rc = regmap_read(wled->regmap,
> +			wled->ctrl_addr + WLED3_CTRL_REG_INT_RT_STS,
> +			&int_rt_sts);
> +	if (rc < 0) {
> +		dev_err(wled->dev, "Failed to read INT_RT_STS rc=%d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = regmap_read(wled->regmap,
> +			wled->ctrl_addr + WLED3_CTRL_REG_FAULT_STATUS,
> +			&fault_sts);
> +	if (rc < 0) {
> +		dev_err(wled->dev, "Failed to read FAULT_STATUS rc=%d\n", rc);
> +		return rc;
> +	}
> +
> +	if (int_rt_sts & WLED3_CTRL_REG_OVP_FAULT_STATUS)
> +		*fault_set = true;
> +
> +	if (fault_sts & (WLED3_CTRL_REG_OVP_FAULT_BIT |
> +			       WLED5_CTRL_REG_OVP_PRE_ALARM_BIT))

Correct me if I'm wrong but isn't the only difference between the WLED4
and WLED5 code that the wled5 code also checks the
WLED5_CTRL_REG_OVP_PRE_ALARM_BIT ?

If so why do we need to pull out (and duplicate) this code code using
the function pointers?

> +		*fault_set = true;
> +
> +	if (*fault_set)
> +		dev_dbg(wled->dev, "WLED OVP fault detected, int_rt_sts=0x%x fault_sts=0x%x\n",
> +			int_rt_sts, fault_sts);
> +
> +	return rc;
> +}
> +
> @@ -615,6 +797,7 @@ static void wled_auto_string_detection(struct wled *wled)
>  
>  #define WLED_AUTO_DETECT_OVP_COUNT		5
>  #define WLED_AUTO_DETECT_CNT_DLY_US		USEC_PER_SEC
> +

Nit picking but this additional line is in the wrong patch ;-)


>  static bool wled4_auto_detection_required(struct wled *wled)
>  {
>  	s64 elapsed_time_us;
> @@ -648,6 +831,46 @@ static bool wled4_auto_detection_required(struct wled *wled)
>  	return false;
>  }
>  
> +static bool wled5_auto_detection_required(struct wled *wled)
> +{
> +	s64 elapsed_time_us;
> +
> +	if (!wled->cfg.auto_detection_enabled)
> +		return false;
> +
> +	/*
> +	 * Check if the OVP fault was an occasional one
> +	 * or if it's firing continuously, the latter qualifies
> +	 * for an auto-detection check.
> +	 */
> +	if (!wled->auto_detection_ovp_count) {
> +		wled->start_ovp_fault_time = ktime_get();
> +		wled->auto_detection_ovp_count++;
> +	} else {
> +		/*
> +		 * WLED5 has OVP fault density interrupt configuration i.e. to
> +		 * count the number of OVP alarms for a certain duration before
> +		 * triggering OVP fault interrupt. By default, number of OVP
> +		 * fault events counted before an interrupt is fired is 32 and
> +		 * the time interval is 12 ms. If we see more than one OVP fault
> +		 * interrupt, then that should qualify for a real OVP fault
> +		 * condition to run auto calibration algorithm.
> +		 */

Given the above why do we have a software mechanism to wait until the
second time the interrupt fires? I'm a bit rusty on this driver but
wasn't there already some mechanism to slightly delay turning on the
fault detection?


Daniel.
