From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Date: Thu, 30 Jul 2015 16:44:33 +0000
Subject: Re: [PATCH] backlight: pm8941-wled: Add default-brightness property
Message-Id: <20150730164433.GE6519@usrtlx11787.corpusers.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437681127-15760-1-git-send-email-bjorn.andersson@sonymobile.com>
 <CAL_JsqKxdF5sj=edURFLDCk1OyCJR-w6+STL4r3zM6+be3tjhg@mail.gmail.com>
 <20150729235139.GC6519@usrtlx11787.corpusers.net>
 <CAL_JsqJYxDROqbv-wh37=MjwbsEtrYKFTvC1NfneonLH2_gL2A@mail.gmail.com>
In-Reply-To: <CAL_JsqJYxDROqbv-wh37=MjwbsEtrYKFTvC1NfneonLH2_gL2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Clark <robdclark@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>

On Thu 30 Jul 08:26 PDT 2015, Rob Herring wrote:

> On Wed, Jul 29, 2015 at 6:51 PM, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
> > On Fri 24 Jul 08:29 PDT 2015, Rob Herring wrote:
[..]
> > As we're trying to specify a default brightness within the range [0,
> > max_brightness) the latter doesn't make much sense.
> >
> > Therefor my suggestion is that we make the "default-brightness" the
> > common property and we define it as a percentage of [0,max_brightness).
> 
> Okay.
> 
> I wonder if we should have units such as
> "default-brightness-percentage" or "default-brightness-%" so it is
> clear. Otherwise, we might have some people doing a range of [0,max].
> The former is a bit long and the latter is a bit unusual.
> 

I discussed this further with my colleague and gave it some though over
the night;

If the boot loader sets the brightness, it would need to convert this to
a percentage just to have the kernel convert it back - with a expected
lack of precision (especially w/ non-linear brightness ranges or odd
step-sizes).

In the case where it's manually tweaked by the developer he/she would
most likely modify the brightness through sysfs until a reasonable value
is found; and we have that extra step again of converting this to a
percentage.


Therefor I think it's better to just specify this in "units of
brightness" - which would be a unit-less property.

Regards,
Bjorn
