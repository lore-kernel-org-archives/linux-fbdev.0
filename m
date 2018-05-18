From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 18 May 2018 12:20:44 +0000
Subject: Re: [PATCH V1 2/5] backlight: qcom-wled: Add support for WLED4 peripheral
Message-Id: <CAL_JsqJtn9hZJuF2uHC-jDMyM2HS2McBs4fy7JoS_rYj9h0j_w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
 <1525341432-15818-3-git-send-email-kgunda@codeaurora.org>
 <20180507162004.GB2259@tuxbook-pro>
 <f970143860bd64624e7fad58333df1be@codeaurora.org>
 <82fa847760309cb3382bf0a8da50162c@codeaurora.org>
 <CAL_JsqLQvSpB3CiS1sA5AXwbvC0xkd1HqEYsjY+=oripMXSwuA@mail.gmail.com>
 <7143faaec2d0b7b0fd7e0f3b512839d8@codeaurora.org>
In-Reply-To: <7143faaec2d0b7b0fd7e0f3b512839d8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-fbdev@vger.kernel.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-arm-msm-owner@vger.kernel.org, Linux LED Subsystem <linux-leds@vger.kernel.org>

On Thu, May 17, 2018 at 10:10 AM,  <kgunda@codeaurora.org> wrote:
> On 2018-05-17 18:01, Rob Herring wrote:
>>
>> On Thu, May 17, 2018 at 4:47 AM,  <kgunda@codeaurora.org> wrote:
>>>
>>> On 2018-05-08 15:55, kgunda@codeaurora.org wrote:
>>>>
>>>>
>>>> On 2018-05-07 21:50, Bjorn Andersson wrote:
>>>>>
>>>>>
>>>>> On Thu 03 May 02:57 PDT 2018, Kiran Gunda wrote:
>>>>>
>>>>>> WLED4 peripheral is present on some PMICs like pmi8998
>>>>>> and pm660l. It has a different register map and also
>>>>>> configurations are different. Add support for it.

[...]

>>>>>> +                     value:
>>>>>> +                     For pm8941: from 0 to 25000 with 5000 ua step
>>>>>> +                                 Default 20000 uA
>>>>>> +                     For pmi8998: from 0 to 30000 with 5000 ua step
>>>>>> +                                  Default 25000 uA.
>>>>>
>>>>>
>>>>>
>>>>> These values could be described just as well in mA, so keep the
>>>>> original
>>>>> unit - in particular since the boot-limit is in mA...
>>>>>
>>>> Ok. Will keep the original as is in the next series.
>>>
>>>
>>> Here, I may have to go with the approach as in "qcom,ovp". Because for
>>> pm8941
>>> the current step is 1 mA (I have wrongly mentioned as 5000uA here) and
>>> for
>>> PMI8998
>>> the current step is 2.5 mA. Hence, I will add another variable
>>> "qcom,current-limit-ua"
>>> just like "qcom,ovp-mv".
>>
>>
>> Use unit suffixes defined in bindings/property-units.txt.
>
> Thanks for pointing it ! hope I can use "qcom,current-limit-microamp" and
> "qcom,ovp-millivolt". I am asking this because i found only "-microvolt".
> "-millivolt" is not present in the bindings you pointed.

That's by design so everyone doesn't just pick whatever random units
they like. Does microvolts not give you enough range?

Rob
