From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 12 Sep 2016 13:58:55 +0000
Subject: Re: [PATCH] backlight: arcxcnn: devicetree bindings for ArticSand devices
Message-Id: <20160912140015.GF9789@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471893084-4551-1-git-send-email-olimpiu@arcticsand.com>
 <20160823182057.GA8472@rob-hp-laptop>
 <CAF-XLW+v9c-+W2Jr2gjN+6ziijDHRtZ6_a9Rpb6TZ5+4CfALJw@mail.gmail.com>
In-Reply-To: <CAF-XLW+v9c-+W2Jr2gjN+6ziijDHRtZ6_a9Rpb6TZ5+4CfALJw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Olimpiu Dejeu <olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org

On Fri, 09 Sep 2016, Olimpiu Dejeu wrote:

> On Tue, Aug 23, 2016 at 2:20 PM, Rob Herring <robh@kernel.org> wrote:
>=20
> > On Mon, Aug 22, 2016 at 03:11:24PM -0400, Olimpiu Dejeu wrote:
> > > This is the device tree bindings documentation file
> > >
> > > Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
> > >
> > > ---
> > >  .../bindings/video/backlight/arcxcnn.txt           | 29
> > ++++++++++++++++++++++
> >
> >
> Check your directory location. Things have moved.
> >
> > Not sure what you mean. This seems to be the right place. Please advise.

What kernel version are you on?

Documentation/devicetree/bindings/leds/backlight

> > >  1 file changed, 29 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/video/backlight/
> > arcxcnn.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/video/backlight/arcxcn=
n.txt
> > b/Documentation/devicetree/bindings/video/backlight/arcxcnn.txt
> > > new file mode 100644
> > > index 0000000..9cd7315
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/video/backlight/arcxcnn.txt
> > > @@ -0,0 +1,29 @@
> > > +arcxcnn bindings
> > > +
> > > +Required properties:
> > > +  - compatible: "arc,arcxcnn", "arc,arc2c0608"
> >
> > One per line please.
> >
> > Is arcxcnn a specific chip? If not drop it. No wildcards in compatible
> > strings.
> >
> > Wild-cards can be dropped but there could be a large family of similar
> chips that would be supported with this one driver. How would one add
> support for a range of chips, some of which don't exist yet?

If they do not exist, then do not mention them in this document.

Every other chip needs to be named individually.

[...]

> > > +  - pwm-period: PWM period value. Set only PWM input mode used (u32)
> > > +  - prg-addr: Register address of ROM area to be updated (u32) low 8
> > bits used
> > > +  - prg-val: Register value to be updated (u32) low 8 bits used
> >
> > What is this for? This should be a specific property or properties to do
> > explicit things, not a generic fill registers/rom with magic values.
> >
> > We need to expose some registers for test without exposing underlying
> functionality. Do you suggest not documenting this in the bindings yet
> keeping the code in the driver? We followed the pattern from the lp855x_bl
> driver.

If you are supplying addresses, use the reg property.

> > > +
> > > +Example:
> > > +
> > > +     /* ARC2C0608 */
> > > +     backlight@30 {
> > > +             compatible =3D "arc,arc2c0608";
> > > +             reg =3D <0x30>;
> > > +
> > > +             init-brt =3D <123>;
> > > +
> > > +             /* LED0+1 string enabled */
> > > +             prg_06h {
> > > +                     prg-addr =3D <0x06>;
> > > +                     prg-val =3D <0x83>;
> > > +             };
> > > +
> > > +     };
> > >
> >

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
