From: Rob Herring <robh@kernel.org>
Date: Wed, 12 Aug 2020 23:05:08 +0000
Subject: Re: [PATCH] dt-bindings: Whitespace clean-ups in schema files
Message-Id: <CAL_JsqKBzqMHMMRwBJUjomxOpZAop_+TXBjLCb6ntwZzNMy=3Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200812203618.2656699-1-robh@kernel.org>
 <f5dedf2d8d8057de3eaa2f9126f44cebb0653b09.camel@perches.com>
In-Reply-To: <f5dedf2d8d8057de3eaa2f9126f44cebb0653b09.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, dri-devel <dri-devel@lists.freedesktop.org>, MTD Maling List <linux-mtd@lists.infradead.org>, Linux I2C <linux-i2c@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, devicetree@vger.kernel.org, "open list:THERMAL" <linux-pm@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Linux HWMON List <linux-hwmon@vger.kernel.org>, netdev <netdev@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>

On Wed, Aug 12, 2020 at 4:32 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-08-12 at 14:36 -0600, Rob Herring wrote:
> > Clean-up incorrect indentation, extra spaces, long lines, and missing
> > EOF newline in schema files. Most of the clean-ups are for list
> > indentation which should always be 2 spaces more than the preceding
>                                      ^
> > keyword.

keyword is the key part...

> []
> > diff --git a/Documentation/devicetree/bindings/arm/arm,integrator.yaml b/Documentation/devicetree/bindings/arm/arm,integrator.yaml
> > index 192ded470e32..f0daf990e077 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,integrator.yaml
> > +++ b/Documentation/devicetree/bindings/arm/arm,integrator.yaml
> > @@ -67,9 +67,9 @@ patternProperties:
> >        compatible:
> >          items:
> >            - enum:
> > -            - arm,integrator-ap-syscon
> > -            - arm,integrator-cp-syscon
> > -            - arm,integrator-sp-syscon
> > +              - arm,integrator-ap-syscon
> > +              - arm,integrator-cp-syscon
> > +              - arm,integrator-sp-syscon
>
> Confused a bit here.
>           - enum:
>         10 spaces to dash
> old line:
>             - arm,integrator-ap-syscon
>         12 spaces to dash
> new line:
>               - arm,integrator-ap-syscon
>         14 spaces to dash
>
> Is it supposed to be 2 spaces more than the preceding line
> or 4 more?

If the preceding line is a list entry (i.e. starts with '-'), then
it's 4 more spaces. It's always 2 more spaces than the preceding
keyword start (aka json-schema vocabulary).

Arguably, this style is a bit inconsistent in that the '-' counts
toward as indentation of the current line, but not the preceding line.
However, I think this style is a bit less error prone and easier to
review. With the other style (always N more spaces) it's harder to
distinguish lists vs. dicts. For example, you can have something like
this:

- key:
  - foo
  - bar

- key:
    foo
    bar

- key:
  - foo
    bar

All 3 of these could be valid. Which one was intended? (Can't really
tell here, but you can with actual DT schema.)

Rob
