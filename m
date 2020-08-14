From: Rob Herring <robh@kernel.org>
Date: Fri, 14 Aug 2020 14:51:24 +0000
Subject: Re: [PATCH] dt-bindings: Whitespace clean-ups in schema files
Message-Id: <CAL_JsqKekx0VO4NROwLrgrU8+L584HaLHM9i3kCZvU+g5myeGw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200812203618.2656699-1-robh@kernel.org>
 <d5808e9c-07fe-1c28-b9a6-a16abe9df458@lucaceresoli.net>
In-Reply-To: <d5808e9c-07fe-1c28-b9a6-a16abe9df458@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, dri-devel <dri-devel@lists.freedesktop.org>, MTD Maling List <linux-mtd@lists.infradead.org>, Linux I2C <linux-i2c@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, devicetree@vger.kernel.org, "open list:THERMAL" <linux-pm@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Linux HWMON List <linux-hwmon@vger.kernel.org>, netdev <netdev@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>

On Thu, Aug 13, 2020 at 4:31 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> Hi Rob,
>
> On 12/08/20 22:36, Rob Herring wrote:
> > Clean-up incorrect indentation, extra spaces, long lines, and missing
> > EOF newline in schema files. Most of the clean-ups are for list
> > indentation which should always be 2 spaces more than the preceding
> > keyword.
> >
> > Found with yamllint (which I plan to integrate into the checks).
>
> [...]
>
> > diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > index 3d4e1685cc55..28c6461b9a9a 100644
> > --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > @@ -95,10 +95,10 @@ allOf:
> >        # Devices without builtin crystal
> >        properties:
> >          clock-names:
> > -            minItems: 1
> > -            maxItems: 2
> > -            items:
> > -              enum: [ xin, clkin ]
> > +          minItems: 1
> > +          maxItems: 2
> > +          items:
> > +            enum: [ xin, clkin ]
> >          clocks:
> >            minItems: 1
> >            maxItems: 2
>
> Thanks for noticing, LGTM.
>
> [...]
>
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> > index d7dac16a3960..36dc7b56a453 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> > @@ -33,8 +33,8 @@ properties:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >
> >    touchscreen-min-pressure:
> > -    description: minimum pressure on the touchscreen to be achieved in order for the
> > -                 touchscreen driver to report a touch event.
> > +    description: minimum pressure on the touchscreen to be achieved in order
> > +      for the touchscreen driver to report a touch event.
>
> Out of personal taste, I find the original layout more pleasant and
> readable. This third option is also good, especially for long descriptions:
>
>   description:
>     minimum pressure on the touchscreen to be achieved in order for the
>     touchscreen driver to report a touch event.
>
> At first glance yamllint seems to support exactly these two by default:
>
> > With indentation: {spaces: 4, check-multi-line-strings: true}

Turning on check-multi-line-strings results in 10K+ warnings, so no.

The other issue is the style ruamel.yaml wants to write out is as the
patch does above. This matters when doing some scripted
transformations where we read in the files and write them back out. I
can somewhat work around that by first doing a pass with no changes
and then another pass with the actual changes, but that's completely
scriptable. Hopefully, ruamel learns to preserve the style better.

Rob
