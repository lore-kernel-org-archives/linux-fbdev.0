From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 17 May 2018 12:31:35 +0000
Subject: Re: [PATCH V1 2/5] backlight: qcom-wled: Add support for WLED4 peripheral
Message-Id: <CAL_JsqLQvSpB3CiS1sA5AXwbvC0xkd1HqEYsjY+=oripMXSwuA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
 <1525341432-15818-3-git-send-email-kgunda@codeaurora.org>
 <20180507162004.GB2259@tuxbook-pro>
 <f970143860bd64624e7fad58333df1be@codeaurora.org>
 <82fa847760309cb3382bf0a8da50162c@codeaurora.org>
In-Reply-To: <82fa847760309cb3382bf0a8da50162c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-fbdev@vger.kernel.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>

On Thu, May 17, 2018 at 4:47 AM,  <kgunda@codeaurora.org> wrote:
> On 2018-05-08 15:55, kgunda@codeaurora.org wrote:
>>
>> On 2018-05-07 21:50, Bjorn Andersson wrote:
>>>
>>> On Thu 03 May 02:57 PDT 2018, Kiran Gunda wrote:
>>>
>>>> WLED4 peripheral is present on some PMICs like pmi8998
>>>> and pm660l. It has a different register map and also
>>>> configurations are different. Add support for it.
>>>>
>>>
>>> Several things are going on in this patch, it needs to be split to
>>> not hide the functional changes from the structural/renames.
>>>
>> Ok. I will split it in the next series.
>>>>
>>>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>>>> ---
>>>>  .../bindings/leds/backlight/qcom-wled.txt          | 172 ++++-
>>>>  drivers/video/backlight/qcom-wled.c                | 749
>>>> +++++++++++++++------
>>>>  2 files changed, 696 insertions(+), 225 deletions(-)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>>>> b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>>>> index fb39e32..0ceffa1 100644
>>>> --- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>>>> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>>>> @@ -1,30 +1,129 @@
>>>>  Binding for Qualcomm Technologies, Inc. WLED driver
>>>>
>>>> -Required properties:
>>>> -- compatible: should be "qcom,pm8941-wled"
>>>> -- reg: slave address
>>>> -
>>>> -Optional properties:
>>>> -- default-brightness: brightness value on boot, value from: 0-4095
>>>> -       default: 2048
>>>> -- label: The name of the backlight device
>>>> -- qcom,cs-out: bool; enable current sink output
>>>> -- qcom,cabc: bool; enable content adaptive backlight control
>>>> -- qcom,ext-gen: bool; use externally generated modulator signal to dim
>>>> -- qcom,current-limit: mA; per-string current limit; value from 0 to 25
>>>> -       default: 20mA
>>>> -- qcom,current-boost-limit: mA; boost current limit; one of:
>>>> -       105, 385, 525, 805, 980, 1260, 1400, 1680
>>>> -       default: 805mA
>>>> -- qcom,switching-freq: kHz; switching frequency; one of:
>>>> -       600, 640, 685, 738, 800, 872, 960, 1066, 1200, 1371,
>>>> -       1600, 1920, 2400, 3200, 4800, 9600,
>>>> -       default: 1600kHz
>>>> -- qcom,ovp: V; Over-voltage protection limit; one of:
>>>> -       27, 29, 32, 35
>>>> -       default: 29V
>>>> -- qcom,num-strings: #; number of led strings attached; value from 1 to
>>>> 3
>>>> -       default: 2
>>>> +WLED (White Light Emitting Diode) driver is used for controlling
>>>> display
>>>> +backlight that is part of PMIC on Qualcomm Technologies, Inc. reference
>>>> +platforms. The PMIC is connected to the host processor via SPMI bus.
>>>> +
>>>> +- compatible
>>>> +       Usage:        required
>>>> +       Value type:   <string>
>>>> +       Definition:   should be "qcom,pm8941-wled" or
>>>> "qcom,pmi8998-wled".
>>>> +                     or "qcom,pm660l-wled".
>>>
>>>
>>> Better written as
>>>
>>>                 should be one of:
>>>                         X
>>>                         Y
>>>                         Z
>>>
>> Will do it in the next series.
>>>>
>>>> +
>>>> +- reg
>>>> +       Usage:        required
>>>> +       Value type:   <prop encoded array>
>>>> +       Definition:   Base address of the WLED modules.
>>>> +
>>>> +- interrupts
>>>> +       Usage:        optional
>>>> +       Value type:   <prop encoded array>
>>>> +       Definition:   Interrupts associated with WLED. Interrupts can be
>>>> +                     specified as per the encoding listed under
>>>> +                     Documentation/devicetree/bindings/spmi/
>>>> +                     qcom,spmi-pmic-arb.txt.
>>>
>>>
>>> Better to describe that this should be the "short" and "ovp" interrupts
>>> in this property than in the interrupt-names.
>>>
>> Ok. I will do it in the next series.
>>>>
>>>> +
>>>> +- interrupt-names
>>>> +       Usage:        optional
>>>> +       Value type:   <string>
>>>> +       Definition:   Interrupt names associated with the interrupts.
>>>> +                     Must be "short" and "ovp". The short circuit
>>>> detection
>>>> +                     is not supported for PM8941.
>>>> +
>>>> +- label
>>>> +       Usage:        required
>>>> +       Value type:   <string>
>>>> +       Definition:   The name of the backlight device
>>>> +
>>>> +- default-brightness
>>>> +       Usage:        optional
>>>> +       Value type:   <u32>
>>>> +       Definition:   brightness value on boot, value from: 0-4095
>>>> +                     Default: 2048
>>>> +
>>>> +- qcom,current-limit
>>>> +       Usage:        optional
>>>> +       Value type:   <u32>
>>>> +       Definition:   uA; per-string current limit
>>>
>>>
>>> You can't change unit on an existing property, that breaks any existing
>>> dts using the qcom,pm8941-wled compatible.
>>>
>>
>>>> +                     value:
>>>> +                     For pm8941: from 0 to 25000 with 5000 ua step
>>>> +                                 Default 20000 uA
>>>> +                     For pmi8998: from 0 to 30000 with 5000 ua step
>>>> +                                  Default 25000 uA.
>>>
>>>
>>> These values could be described just as well in mA, so keep the original
>>> unit - in particular since the boot-limit is in mA...
>>>
>> Ok. Will keep the original as is in the next series.
>
> Here, I may have to go with the approach as in "qcom,ovp". Because for
> pm8941
> the current step is 1 mA (I have wrongly mentioned as 5000uA here) and for
> PMI8998
> the current step is 2.5 mA. Hence, I will add another variable
> "qcom,current-limit-ua"
> just like "qcom,ovp-mv".

Use unit suffixes defined in bindings/property-units.txt.

Rob
