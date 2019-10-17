From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 17 Oct 2019 11:29:41 +0000
Subject: Re: [PATCH V7 6/6] backlight: qcom-wled: Add auto string detection logic
Message-Id: <20191017112941.qqvgboyambzw63i3@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1571220826-7740-1-git-send-email-kgunda@codeaurora.org>
 <1571220826-7740-7-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1571220826-7740-7-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: bjorn.andersson@linaro.org, jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wed, Oct 16, 2019 at 03:43:46PM +0530, Kiran Gunda wrote:
> The auto string detection algorithm checks if the current WLED
> sink configuration is valid. It tries enabling every sink and
> checks if the OVP fault is observed. Based on this information
> it detects and enables the valid sink configuration.
> Auto calibration will be triggered when the OVP fault interrupts
> are seen frequently thereby it tries to fix the sink configuration.
> 
> The auto-detection also kicks in when the connected LED string
> of the display-backlight malfunctions (because of damage) and
> requires the damaged string to be turned off to prevent the
> complete panel and/or board from being damaged.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>

It's a complex bit of code but I'm OK with it in principle. Everything
below is about small details and/or nitpicking.


> +static void wled_ovp_work(struct work_struct *work)
> +{
> +	struct wled *wled = container_of(work,
> +					 struct wled, ovp_work.work);
> +	enable_irq(wled->ovp_irq);
> +}
> +

A bit of commenting about why we have to wait 10ms before enabling the
OVP interrupt would be appreciated.


> +static irqreturn_t wled_ovp_irq_handler(int irq, void *_wled)
> +{
> +	struct wled *wled = _wled;
> +	int rc;
> +	u32 int_sts, fault_sts;
> +
> +	rc = regmap_read(wled->regmap,
> +			 wled->ctrl_addr + WLED3_CTRL_REG_INT_RT_STS, &int_sts);
> +	if (rc < 0) {
> +		dev_err(wled->dev, "Error in reading WLED3_INT_RT_STS rc=%d\n",
> +			rc);
> +		return IRQ_HANDLED;
> +	}
> +
> +	rc = regmap_read(wled->regmap, wled->ctrl_addr +
> +			 WLED3_CTRL_REG_FAULT_STATUS, &fault_sts);
> +	if (rc < 0) {
> +		dev_err(wled->dev, "Error in reading WLED_FAULT_STATUS rc=%d\n",
> +			rc);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (fault_sts &
> +		(WLED3_CTRL_REG_OVP_FAULT_BIT | WLED3_CTRL_REG_ILIM_FAULT_BIT))
> +		dev_dbg(wled->dev, "WLED OVP fault detected, int_sts=%x fault_sts= %x\n",
> +			int_sts, fault_sts);
> +
> +	if (fault_sts & WLED3_CTRL_REG_OVP_FAULT_BIT) {
> +		mutex_lock(&wled->lock);
> +		disable_irq_nosync(wled->ovp_irq);

We're currently running the threaded ISR for this irq. Do we really need
to disable it?

> +
> +		if (wled_auto_detection_required(wled))
> +			wled_auto_string_detection(wled);
> +
> +		enable_irq(wled->ovp_irq);
> +
> +		mutex_unlock(&wled->lock);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +

Snip.


> +static int wled_remove(struct platform_device *pdev)
> +{
> +	struct wled *wled = dev_get_drvdata(&pdev->dev);
> +
> +	cancel_delayed_work_sync(&wled->ovp_work);
> +	mutex_destroy(&wled->lock);

Have the irq handlers been disabled at this point?

Also, if you want to destroy the mutex shouldn't that code be 
introduced in the same patch that introduces the mutex?
> +
> +	return 0;
> +}


Daniel.
