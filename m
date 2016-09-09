From: Olimpiu Dejeu <olimpiu@arcticsand.com>
Date: Fri, 09 Sep 2016 18:50:25 +0000
Subject: Re: [PATCH] backlight: arcxcnn: devicetree bindings for ArticSand devices
Message-Id: <1473447025-11381-1-git-send-email-olimpiu@arcticsand.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471893084-4551-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1471893084-4551-1-git-send-email-olimpiu@arcticsand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh@kernel.org
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, jg1.han@samsung.com

--

On Tue, Aug 23, 2016 at 2:20 PM, Rob Herring <robh@kernel.org> wrote:

> On Mon, Aug 22, 2016 at 03:11:24PM -0400, Olimpiu Dejeu wrote:
> > This is the device tree bindings documentation file
> >
> > Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
> >
> > ---
> >  .../bindings/video/backlight/arcxcnn.txt           | 29
> ++++++++++++++++++++++
>
>
> Check your directory location. Things have moved.
>

Not sure what you mean. This seems to be the right place. Please advise.

> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/video/backlight/
> arcxcnn.txt
> >
> > diff --git a/Documentation/devicetree/bindings/video/backlight/arcxcnn.txt
> b/Documentation/devicetree/bindings/video/backlight/arcxcnn.txt
> > new file mode 100644
> > index 0000000..9cd7315
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/video/backlight/arcxcnn.txt
> > @@ -0,0 +1,29 @@
> > +arcxcnn bindings
> > +
> > +Required properties:
> > +  - compatible: "arc,arcxcnn", "arc,arc2c0608"
>
> One per line please.
>
> Is arcxcnn a specific chip? If not drop it. No wildcards in compatible
> strings.
>

Wild-cards can be dropped but there could be a large family of similar
chips that would be supported with this one driver. How would one add
support for a range of chips, some of which don't exist yet?


> > +  - reg: I2C slave address (u8)
> > +
> > +Optional properties:
> > +  - bl-name: Backlight device name (string)
>
> Use the common bindings. label?
>
> > +  - init-brt: Initial value of backlight brightness (u32) low 16 bits
> used
>
> Use common bindings.
>

Ok


> > +  - pwm-period: PWM period value. Set only PWM input mode used (u32)
> > +  - prg-addr: Register address of ROM area to be updated (u32) low 8
> bits used
> > +  - prg-val: Register value to be updated (u32) low 8 bits used
>
> What is this for? This should be a specific property or properties to do
> explicit things, not a generic fill registers/rom with magic values.
>

We need to expose some registers for test without exposing underlying
functionality. Do you suggest not documenting this in the bindings yet
keeping the code in the driver? We followed the pattern from the lp855x_bl
driver.


> > +
> > +Example:
> > +
> > +     /* ARC2C0608 */
> > +     backlight@30 {
> > +             compatible = "arc,arc2c0608";
> > +             reg = <0x30>;
> > +
> > +             init-brt = <123>;
> > +
> > +             /* LED0+1 string enabled */
> > +             prg_06h {
> > +                     prg-addr = <0x06>;
> > +                     prg-val = <0x83>;
> > +             };
> > +
> > +     };
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

