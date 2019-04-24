From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 24 Apr 2019 15:57:50 +0000
Subject: Re: [PATCH v6 2/3] dt-bindings: backlight: add lm3630a bindings
Message-Id: <CAL_JsqJSpmG_TfNaxHKQMzVn0ig=HaBupQ22bbPAa9riuCU71Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190424092505.6578-1-masneyb@onstation.org> <20190424092505.6578-3-masneyb@onstation.org>
 <20190424142037.GA20237@amd>
In-Reply-To: <20190424142037.GA20237@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Brian Masney <masneyb@onstation.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>, Jonathan Marek <jonathan@marek.ca>

On Wed, Apr 24, 2019 at 9:20 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> > @@ -0,0 +1,129 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/backlight/lm3630a-backlight.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>
> I'm not a great fan on links to external websites. But this is comment
> for Rob.

This is simply how json-schema works. $schema says what meta-schema
this file should validate against so it's versioned if we change the
schema format. $id is just a unique identifier and is used to resolve
$ref values. Note that these aren't live urls either (but could be at
some point in the future).

> > +title: TI LM3630A High-Efficiency Dual-String White LED
> > +
> > +maintainers:
> > +  - Lee Jones <lee.jones@linaro.org>
> > +  - Daniel Thompson <daniel.thompson@linaro.org>
> > +  - Jingoo Han <jingoohan1@gmail.com>
>
> Not a great fan of duplicating MAINTAINERS information here. But this
> is a comment for Rob, again.

Hopefully this is temporary until we move to per directory MAINTAINERS
files. Not sure what happened with that.

Rob
