From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Date: Wed, 29 Jul 2015 22:37:15 +0000
Subject: Re: [PATCH] backlight: pm8941-wled: Add default-brightness property
Message-Id: <20150729223714.GB6519@usrtlx11787.corpusers.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437681127-15760-1-git-send-email-bjorn.andersson@sonymobile.com>
 <CAF6AEGsJdLYzCA_=M8hf1XfhRxFAaY6VFdSBRP+y56uKsnQHiA@mail.gmail.com>
 <CAL_JsqKcNjsLJPxQiWsjVtwsX2nsYGLSzjmX0cwo1QsZ+JE4Hg@mail.gmail.com>
 <CAF6AEGs+knSa9TvZ8fR5-_zqC4TaHuBN8+GU5_6j33Pnr16Faw@mail.gmail.com>
In-Reply-To: <CAF6AEGs+knSa9TvZ8fR5-_zqC4TaHuBN8+GU5_6j33Pnr16Faw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Clark <robdclark@gmail.com>
Cc: Rob Herring <robherring2@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>

On Fri 24 Jul 10:41 PDT 2015, Rob Clark wrote:

> On Fri, Jul 24, 2015 at 11:39 AM, Rob Herring <robherring2@gmail.com> wrote:
> > On Fri, Jul 24, 2015 at 8:10 AM, Rob Clark <robdclark@gmail.com> wrote:
> >> On Thu, Jul 23, 2015 at 3:52 PM, Bjorn Andersson
> >> <bjorn.andersson@sonymobile.com> wrote:
> >>> Add the possibility of specifying the default brightness in DT.
> >>>
> >>> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> >>> ---
> >>>
> >>> This depends on the patch moving pm8941-wled to backlight [1]. The dt property
> >>> is used by several other backlight drivers, so I considered this to be a
> >>> "common" property and it's hence not prefixed with "qcom,".
> >>>
> >>> [1] https://lkml.org/lkml/2015/7/21/906
> >>>
> >>>  Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt | 1 +
> >>>  drivers/video/backlight/pm8941-wled.c                             | 4 ++++
> >>>  2 files changed, 5 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt b/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
> >>> index 424f8444a6cd..37503f8c3620 100644
> >>> --- a/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
> >>> +++ b/Documentation/devicetree/bindings/video/backlight/pm8941-wled.txt
> >>> @@ -5,6 +5,7 @@ Required properties:
> >>>  - reg: slave address
> >>>
> >>>  Optional properties:
> >>> +- default-brightness: value from: 0-4095
> >>>  - label: The name of the backlight device
> >>>  - qcom,cs-out: bool; enable current sink output
> >>>  - qcom,cabc: bool; enable content adaptive backlight control
> >>> diff --git a/drivers/video/backlight/pm8941-wled.c b/drivers/video/backlight/pm8941-wled.c
> >>> index c704c3236034..b875e58df0fc 100644
> >>> --- a/drivers/video/backlight/pm8941-wled.c
> >>> +++ b/drivers/video/backlight/pm8941-wled.c
> >>> @@ -373,6 +373,7 @@ static int pm8941_wled_probe(struct platform_device *pdev)
> >>>         struct backlight_device *bl;
> >>>         struct pm8941_wled *wled;
> >>>         struct regmap *regmap;
> >>> +       u32 val = 0;
> >>>         int rc;
> >>
> >> as discussed on IRC, it would be better if the default read back the
> >> current settings (so-as to inherit bootloader splash smoothly..
> >> drm/msm supports a memory-region phandle, for example, so it can take
> >> over the bootloader splash-screen as stolen-mem)
> >>
> >> and it would I think be useful to have a comment in the bindings file
> >> explaining that you *should* use the default-brightness property to
> >> set a sane default if bootloader isn't putting up a splash, and you
> >> should *not* use the property if it is..
> >
> > +1
> >
> > What if you have neither? Set to max brightness? 75%?
> 
> I did chat w/ Bjorn a bit about that on irc..  his concern was some
> arbitrary percentage (like 50%) might be more or less bright depending
> on the device (although that implies to me that maybe we should have
> min and max bindings as well, rather than just assuming hw limits?
> idk)
> 

But this issue could easily be solved by having the boot loader pass an
appropriate value to the kernel through the dt property, overriding any
default from the implementation.

Or in the case when the boot does not touch the backlight the dt writer
still have the possibility of picking a better value.

> my preference is the default is somehow at least not 0%.. possibly
> motivated by the expectation that when people see a dark screen at
> boot they assume the display driver is broken :-P
> 

Right

> > This could also be used for the bootloader to communicate to the
> > kernel what the current level is if it is not readable. I've seen one
> > backlight recently which you change the level by doing some number of
> > pulses on a gpio and a long pulse to turn off. So there is no way to
> > know current level without turning off the backlight (unless you
> > hardcode the bootloader's level in the kernel like the vendor did).
> >

Right and even in the case of this driver I feel it's just adding
accidental complexity.


50% would solve Rob's problem and we're through the dt property
providing the necessary means of changing this, either to match boot
loader set levels or developers preferences.

I'll rephrase the binding document and update the driver.

Regards,
Bjorn
