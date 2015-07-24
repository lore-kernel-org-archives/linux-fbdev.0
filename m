From: Rob Herring <robherring2@gmail.com>
Date: Fri, 24 Jul 2015 15:39:06 +0000
Subject: Re: [PATCH] backlight: pm8941-wled: Add default-brightness property
Message-Id: <CAL_JsqKcNjsLJPxQiWsjVtwsX2nsYGLSzjmX0cwo1QsZ+JE4Hg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437681127-15760-1-git-send-email-bjorn.andersson@sonymobile.com> <CAF6AEGsJdLYzCA_=M8hf1XfhRxFAaY6VFdSBRP+y56uKsnQHiA@mail.gmail.com>
In-Reply-To: <CAF6AEGsJdLYzCA_=M8hf1XfhRxFAaY6VFdSBRP+y56uKsnQHiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Clark <robdclark@gmail.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>

On Fri, Jul 24, 2015 at 8:10 AM, Rob Clark <robdclark@gmail.com> wrote:
> On Thu, Jul 23, 2015 at 3:52 PM, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
>> Add the possibility of specifying the default brightness in DT.
>>
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>> ---
>>
>> This depends on the patch moving pm8941-wled to backlight [1]. The dt property
>> is used by several other backlight drivers, so I considered this to be a
>> "common" property and it's hence not prefixed with "qcom,".
>>
>> [1] https://lkml.org/lkml/2015/7/21/906
>>
>>  Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt | 1 +
>>  drivers/video/backlight/pm8941-wled.c                             | 4 ++++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt b/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
>> index 424f8444a6cd..37503f8c3620 100644
>> --- a/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
>> +++ b/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
>> @@ -5,6 +5,7 @@ Required properties:
>>  - reg: slave address
>>
>>  Optional properties:
>> +- default-brightness: value from: 0-4095
>>  - label: The name of the backlight device
>>  - qcom,cs-out: bool; enable current sink output
>>  - qcom,cabc: bool; enable content adaptive backlight control
>> diff --git a/drivers/video/backlight/pm8941-wled.c b/drivers/video/backlight/pm8941-wled.c
>> index c704c3236034..b875e58df0fc 100644
>> --- a/drivers/video/backlight/pm8941-wled.c
>> +++ b/drivers/video/backlight/pm8941-wled.c
>> @@ -373,6 +373,7 @@ static int pm8941_wled_probe(struct platform_device *pdev)
>>         struct backlight_device *bl;
>>         struct pm8941_wled *wled;
>>         struct regmap *regmap;
>> +       u32 val = 0;
>>         int rc;
>
> as discussed on IRC, it would be better if the default read back the
> current settings (so-as to inherit bootloader splash smoothly..
> drm/msm supports a memory-region phandle, for example, so it can take
> over the bootloader splash-screen as stolen-mem)
>
> and it would I think be useful to have a comment in the bindings file
> explaining that you *should* use the default-brightness property to
> set a sane default if bootloader isn't putting up a splash, and you
> should *not* use the property if it is..

+1

What if you have neither? Set to max brightness? 75%?

This could also be used for the bootloader to communicate to the
kernel what the current level is if it is not readable. I've seen one
backlight recently which you change the level by doing some number of
pulses on a gpio and a long pulse to turn off. So there is no way to
know current level without turning off the backlight (unless you
hardcode the bootloader's level in the kernel like the vendor did).

Rob
