From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 03 Apr 2019 01:50:09 +0000
Subject: Re: [PATCH v2 2/3] dt-bindings: backlight: add lm3630a bindings
Message-Id: <CAL_JsqKCJ0hwBX1P2abLjfMPZow3SJGO65PQ1Fa+Qz9DFHCXSg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-3-masneyb@onstation.org>
 <68229e7f-4749-cde5-f541-793ab614084d@ti.com>
 <20190402132440.GA10359@basecamp>
In-Reply-To: <20190402132440.GA10359@basecamp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Masney <masneyb@onstation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Marek <jonathan@marek.ca>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>

On Tue, Apr 2, 2019 at 8:24 AM Brian Masney <masneyb@onstation.org> wrote:
>
> On Tue, Apr 02, 2019 at 07:56:55AM -0500, Dan Murphy wrote:
> > This would connect control bank B to control bank A.  Or just use a flag to denote to connect them
> > and not use led-sources.  But led-sources is the property of choice.
> >
> > led@0 {
> >       reg = <0>;
> >       led-sources = < 0 1 >;
> >       label = "main-lcd";
> >       default-brightness = <200>;
> >       max-brightness = <255>;
> > };
>
> OK, I see. I wondered how we could do that in device tree.
>
> > > +    properties:
> > > +      label:
> > > +        description: |
> > > +          The label for this LED. If omitted, the label is taken from the node
> > > +          name (excluding the unit address). It has to uniquely identify a
> > > +          device, i.e. no other LED class device can be assigned the same label.
> > > +
> > > +      led-sources:
> > > +        description: |
> > > +          List of device current outputs the LED is connected to.
> > > +        allOf:
> > > +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +          - minItems: 1
> > > +            maxItems: 2
> > > +            items:
> > > +              minimum: 0
> > > +              maximum: 1
> > > +
> >
> > label and led-sources are already defined in the common.txt no need to redefine them here.
>
> If I'm going to use the new-style bindings, then I'll need to convert
> common.txt over to use the new format as well so that the automated
> schema validations will work. I'm willing to do that work if there is
> interest from the LED / backlight maintainers. The main issue is that
> there are 62 references to the file common.txt in the directory
> Documentation/devicetree/bindings/leds/. Would the maintainers prefer:

That would be awesome.

> - Once common.txt is converted to common.yaml, make common.txt only
>   have a line stating that the common bindings were moved into
>   common.yaml. We can remove this file once all of the other bindings
>   are converted to the new-style format.
>
> - Update all references to common.txt to common.yaml. (1 patch or 62
>   patches?)

I'd probably go with the former if I had to pick. The real
complication here is there's some other changes in flight.

>
> - Or, just go with the older-style binding format for now.

I'm okay if you write it with the assumption that the common
properties have a schema even if they don't yet. All that means is you
don't need to define the type, but only the additional constraints.
There doesn't have to be a reference back to the common property
(those references tend to get broken as we can see here). With
everything as structured data, we could even generate references or
have some tool that can lookup the common definitions.

Rob
