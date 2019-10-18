From: kgunda@codeaurora.org
Date: Fri, 18 Oct 2019 05:15:08 +0000
Subject: Re: [PATCH V7 6/6] backlight: qcom-wled: Add auto string detection logic
Message-Id: <1b21d0a80847173c4a1ee1943f974bda@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1571220826-7740-1-git-send-email-kgunda@codeaurora.org>
 <1571220826-7740-7-git-send-email-kgunda@codeaurora.org>
 <20191017122653.GO4365@dell>
 <689831a9d7561f51cdb7ea0a1760d472@codeaurora.org>
 <20191017133024.GQ4365@dell>
In-Reply-To: <20191017133024.GQ4365@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: bjorn.andersson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org

On 2019-10-17 19:00, Lee Jones wrote:
> On Thu, 17 Oct 2019, kgunda@codeaurora.org wrote:
> 
>> On 2019-10-17 17:56, Lee Jones wrote:
>> > On Wed, 16 Oct 2019, Kiran Gunda wrote:
>> >
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
>> > > ---
>> > >  drivers/video/backlight/qcom-wled.c | 410
>> > > +++++++++++++++++++++++++++++++++++-
>> > >  1 file changed, 404 insertions(+), 6 deletions(-)
>> > >
>> > > diff --git a/drivers/video/backlight/qcom-wled.c
>> > > b/drivers/video/backlight/qcom-wled.c
>> > > index b5b125c..ff7c409 100644
>> > > --- a/drivers/video/backlight/qcom-wled.c
>> > > +++ b/drivers/video/backlight/qcom-wled.c
> 
> [...]
> 
>> > > +		if (int_sts & WLED3_CTRL_REG_OVP_FAULT_STATUS)
>> > > +			dev_dbg(wled->dev, "WLED OVP fault detected with SINK %d\n",
>> > > +				i + 1);
>> >
>> > I haven't reviewed the whole patch, but this caught my eye.
>> >
>> > I think this should be upgraded to dev_warn().
>> >
>> Thought of keeping these messages silent, Because the string 
>> configuration
>> will be corrected in this
>> and informing it at end of the auto string detection.
> 
> [...]
> 
>> > > +	} else {
>> > > +		dev_warn(wled->dev, "New WLED string configuration found %x\n",
>> > > +			 sink_valid);
>> >
>> > Why would the user care about this?  Is it not normal?
>> >
>> Actually, it comes here if the user provided string configuration in 
>> the
>> device tree is in-correct.
>> That's why just informing the user about the right string 
>> configuration,
>> after the auto string detection.
> 
> Then I think we need to be more forthcoming.  Tell the user the
> configuration is incorrect and what you've done to rectify it.
> 
> "XXX is not a valid configuration - using YYY instead"
> 
Sure. Will update it in the next series.
> [...]
> 
>> > > +static int wled_configure_ovp_irq(struct wled *wled,
>> > > +				  struct platform_device *pdev)
>> > > +{
>> > > +	int rc;
>> > > +	u32 val;
>> > > +
>> > > +	wled->ovp_irq = platform_get_irq_byname(pdev, "ovp");
>> > > +	if (wled->ovp_irq < 0) {
>> > > +		dev_dbg(&pdev->dev, "ovp irq is not used\n");
>> >
>> > I assume this is optional.  What happens if no IRQ is provided?
>> >
>> Here OVP IRQ is used to detect the wrong string detection. If it is 
>> not
>> provided the auto string detection logic won't work.
> 
> "OVP IRQ not found - disabling automatic string detection"
> 
Sure. Will update it in the next series.
>> > If, for instance, polling mode is enabled, maybe something like this
>> > would be better?
>> >
>> >       dev_warn(&pdev->dev, "No IRQ found, falling back to polling
>> > mode\n");
