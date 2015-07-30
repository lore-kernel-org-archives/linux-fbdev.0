From: Rob Herring <robherring2@gmail.com>
Date: Thu, 30 Jul 2015 15:26:19 +0000
Subject: Re: [PATCH] backlight: pm8941-wled: Add default-brightness property
Message-Id: <CAL_JsqJYxDROqbv-wh37=MjwbsEtrYKFTvC1NfneonLH2_gL2A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437681127-15760-1-git-send-email-bjorn.andersson@sonymobile.com>
 <CAL_JsqKxdF5sj=edURFLDCk1OyCJR-w6+STL4r3zM6+be3tjhg@mail.gmail.com> <20150729235139.GC6519@usrtlx11787.corpusers.net>
In-Reply-To: <20150729235139.GC6519@usrtlx11787.corpusers.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Clark <robdclark@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>

On Wed, Jul 29, 2015 at 6:51 PM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> On Fri 24 Jul 08:29 PDT 2015, Rob Herring wrote:
>
>> On Thu, Jul 23, 2015 at 2:52 PM, Bjorn Andersson
>> <bjorn.andersson@sonymobile.com> wrote:
>> > Add the possibility of specifying the default brightness in DT.
>> >
>> > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>> > ---
>> >
>> > This depends on the patch moving pm8941-wled to backlight [1]. The dt property
>> > is used by several other backlight drivers, so I considered this to be a
>> > "common" property and it's hence not prefixed with "qcom,".
>>
>> Well, we have "default-brightness" and "default-brightness-level" used
>> by 1 driver each. But default-brightness-level is much more commonly
>> used (in dts files) since it is in the pwm backlight binding, so we
>> should go with it. I'd like to see this moved to a common backlight
>> doc.
>>
>
> As I looked at these, the default-brightness used in tps65217 is a value
> between 0 and 100, so that can be interpreted as a percentage.
>
> The pwm binding however uses a separate array of "brightness-levels" and
> then default-brightness-level is supposed to be an index into that
> array.

Uggg. I missed that minor detail...


> As we're trying to specify a default brightness within the range [0,
> max_brightness) the latter doesn't make much sense.
>
> Therefor my suggestion is that we make the "default-brightness" the
> common property and we define it as a percentage of [0,max_brightness).

Okay.

I wonder if we should have units such as
"default-brightness-percentage" or "default-brightness-%" so it is
clear. Otherwise, we might have some people doing a range of [0,max].
The former is a bit long and the latter is a bit unusual.

>> Really, I think all the backlight documentation should be merged with
>> LEDs docs. Things like "default-on" are common. But I won't ask to do
>> that here.
>
> I think the backlight framework should be merged with the LED framework.
> There's several hw blocks that are split between the two, with an mfd
> tying them together...

Fully agree. BTW, doing that doesn't have to be in sync between the
bindings and drivers. Of course, if we've designed the bindings with
sub devices to fit the MFD structure, then that is another problem.

Rob
