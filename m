From: kgunda@codeaurora.org
Date: Fri, 18 Oct 2019 06:54:56 +0000
Subject: Re: [PATCH V7 6/6] backlight: qcom-wled: Add auto string detection logic
Message-Id: <bd369e2d809d642867f712499df0eb33@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1571220826-7740-1-git-send-email-kgunda@codeaurora.org>
 <1571220826-7740-7-git-send-email-kgunda@codeaurora.org>
 <20191017112941.qqvgboyambzw63i3@holly.lan>
 <fa32f7ec727cb2626ad877a6cef32a1b@codeaurora.org>
 <20191017133954.7vgqjgwxojmjw446@holly.lan>
In-Reply-To: <20191017133954.7vgqjgwxojmjw446@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: bjorn.andersson@linaro.org, jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org

On 2019-10-17 19:09, Daniel Thompson wrote:
> On Thu, Oct 17, 2019 at 05:47:47PM +0530, kgunda@codeaurora.org wrote:
>> On 2019-10-17 16:59, Daniel Thompson wrote:
>> > On Wed, Oct 16, 2019 at 03:43:46PM +0530, Kiran Gunda wrote:
>> > > The auto string detection algorithm checks if the current WLED
>> > > sink configuration is valid. It tries enabling every sink and
>> > > checks if the OVP fault is observed. Based on this information
>> > > it detects and enables the valid sink configuration.
>> > > Auto calibration will be triggered when the OVP fault interrupts
>> > > are seen frequently thereby it tries to fix the sink configuration.
>> > >
>> > > The auto-detection also kicks in when the connected LED string
>> > > of the display-backlight malfunctions (because of damage) and
>> > > requires the damaged string to be turned off to prevent the
>> > > complete panel and/or board from being damaged.
>> > >
>> > > Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> >
>> > It's a complex bit of code but I'm OK with it in principle. Everything
>> > below is about small details and/or nitpicking.
>> >
>> >
>> > > +static void wled_ovp_work(struct work_struct *work)
>> > > +{
>> > > +	struct wled *wled = container_of(work,
>> > > +					 struct wled, ovp_work.work);
>> > > +	enable_irq(wled->ovp_irq);
>> > > +}
>> > > +
>> >
>> > A bit of commenting about why we have to wait 10ms before enabling the
>> > OVP interrupt would be appreciated.
>> >
>> >
>> Sure. Will add the comment in the next series.
>> > > +static irqreturn_t wled_ovp_irq_handler(int irq, void *_wled)
>> > > +{
>> > > +	struct wled *wled = _wled;
>> > > +	int rc;
>> > > +	u32 int_sts, fault_sts;
>> > > +
>> > > +	rc = regmap_read(wled->regmap,
>> > > +			 wled->ctrl_addr + WLED3_CTRL_REG_INT_RT_STS, &int_sts);
>> > > +	if (rc < 0) {
>> > > +		dev_err(wled->dev, "Error in reading WLED3_INT_RT_STS rc=%d\n",
>> > > +			rc);
>> > > +		return IRQ_HANDLED;
>> > > +	}
>> > > +
>> > > +	rc = regmap_read(wled->regmap, wled->ctrl_addr +
>> > > +			 WLED3_CTRL_REG_FAULT_STATUS, &fault_sts);
>> > > +	if (rc < 0) {
>> > > +		dev_err(wled->dev, "Error in reading WLED_FAULT_STATUS rc=%d\n",
>> > > +			rc);
>> > > +		return IRQ_HANDLED;
>> > > +	}
>> > > +
>> > > +	if (fault_sts &
>> > > +		(WLED3_CTRL_REG_OVP_FAULT_BIT | WLED3_CTRL_REG_ILIM_FAULT_BIT))
>> > > +		dev_dbg(wled->dev, "WLED OVP fault detected, int_sts=%x
>> > > fault_sts= %x\n",
>> > > +			int_sts, fault_sts);
>> > > +
>> > > +	if (fault_sts & WLED3_CTRL_REG_OVP_FAULT_BIT) {
>> > > +		mutex_lock(&wled->lock);
>> > > +		disable_irq_nosync(wled->ovp_irq);
>> >
>> > We're currently running the threaded ISR for this irq. Do we really need
>> > to disable it?
>> >
>> We need to disable this IRQ, during the auto string detection logic. 
>> Because
>> in the auto string detection we configure the current sinks one by one 
>> and
>> check the
>> status register for the OVPs and set the right string configuration. 
>> We
>> enable it later after
>> the auto string detection is completed.
> 
> This is a threaded oneshot interrupt handler. Why isn't the framework
> masking sufficient for you here?
> 
> 
> Daniel.
Right .. I overlooked that it is a oneshot interrupt earlier.
I will address it in the next series.
