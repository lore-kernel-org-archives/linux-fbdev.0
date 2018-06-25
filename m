From: kgunda@codeaurora.org
Date: Mon, 25 Jun 2018 06:06:05 +0000
Subject: Re: [PATCH V3 5/7] backlight: qcom-wled: Add support for WLED4 peripheral
Message-Id: <b40a7640af6a99bfbcb0b21025dafd38@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-6-git-send-email-kgunda@codeaurora.org>
 <20180620051417.GI15126@tuxbook-pro>
 <27aa7ff8f7e0cd8fdca5d3ee17bb1ef4@codeaurora.org>
 <20180622230903.GM3402@tuxbook-pro>
In-Reply-To: <20180622230903.GM3402@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, Daniel Thompson <daniel.thompson@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org

On 2018-06-23 04:39, Bjorn Andersson wrote:
> On Wed 20 Jun 04:00 PDT 2018, kgunda@codeaurora.org wrote:
> 
>> On 2018-06-20 10:44, Bjorn Andersson wrote:
>> > On Tue 19 Jun 04:13 PDT 2018, Kiran Gunda wrote:
>> >
>> > > WLED4 peripheral is present on some PMICs like pmi8998 and
>> > > pm660l. It has a different register map and configurations
>> > > are also different. Add support for it.
>> > >
>> > > Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> > > ---
>> > >  drivers/video/backlight/qcom-wled.c | 635
>> > > ++++++++++++++++++++++++++++--------
>> > >  1 file changed, 503 insertions(+), 132 deletions(-)
>> >
>> > Split this further into a patch that does structural preparation of
>> > WLED3 support and then an addition of WLED4, the mixture makes parts of
>> > this patch almost impossible to review. Please find some comments below.
>> >
>> Sure. I will split it in the next series.
> 
> Thanks!
> 
>> > >
>> > > diff --git a/drivers/video/backlight/qcom-wled.c
>> > > b/drivers/video/backlight/qcom-wled.c
>> > [..]
>> > >
>> > >  /* WLED3 sink registers */
>> > >  #define WLED3_SINK_REG_SYNC				0x47
>> >
>> > Drop the 3 from this if it's common between the two.
>> >
>> > > -#define  WLED3_SINK_REG_SYNC_MASK			0x07
>> > > +#define  WLED3_SINK_REG_SYNC_MASK			GENMASK(2, 0)
>> > > +#define  WLED4_SINK_REG_SYNC_MASK			GENMASK(3, 0)
>> > >  #define  WLED3_SINK_REG_SYNC_LED1			BIT(0)
>> > >  #define  WLED3_SINK_REG_SYNC_LED2			BIT(1)
>> > >  #define  WLED3_SINK_REG_SYNC_LED3			BIT(2)
>> > > +#define  WLED4_SINK_REG_SYNC_LED4			BIT(3)
>> > >  #define  WLED3_SINK_REG_SYNC_ALL			0x07
>> > > +#define  WLED4_SINK_REG_SYNC_ALL			0x0f
>> > >  #define  WLED3_SINK_REG_SYNC_CLEAR			0x00
>> > >
>> > [..]
>> > > +static int wled4_set_brightness(struct wled *wled, u16 brightness)
>> >
>> > Afaict this is identical to wled3_set_brightness() with the exception
>> > that there's a minimum brightness and the base address for the
>> > brightness registers are different.
>> >
>> > I would suggest that you add a min_brightness to wled and that you
>> > figure out a way to carry the brightness base register address; and by
>> > that you squash these two functions.
>> >
>> There are four different parameters. 1) minimum brightness 2) WLED 
>> base
>> addresses
>> 3) Brightness base addresses 4) the brightness sink registers address
>> offsets also
>> different for wled 3 and wled4. (in wled3 0x40, 0x42, 0x44, where as 
>> in
>> wled4 0x57, 0x67, 0x77, 0x87).
>> 
> 
> Sorry, I must have gotten lost in the defines, I see the difference
> between the two register layouts now. If you retain the old mechanism 
> of
> doing the math openly in the function this would have been obvious.
> 
>> Irrelevant to this patch, but wled5 has some more extra registers to
>> set the brightness.  Keeping this in mind, it is better to have
>> separate functions? Otherwise we will have to use the version checks
>> in the wled_set_brightness function, if we have the common function.
> 
> Okay, so it sounds reasonable to split this out to some degree.
> 
> Regards,
> Bjorn
> --
Thanks for that !
> To unsubscribe from this list: send the line "unsubscribe 
> linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
