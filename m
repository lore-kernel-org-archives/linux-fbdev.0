From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 16 Oct 2015 11:42:03 +0000
Subject: Re: [PATCHv4 3/3] devicetree: Add led-backlight binding
Message-Id: <5620E28B.4040002@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="haLONVOnUUprtr8snVRC0RBTSsU7pednB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443605522-1118-1-git-send-email-tomi.valkeinen@ti.com>
 <1443605522-1118-4-git-send-email-tomi.valkeinen@ti.com>
 <CAL_JsqJ+xYpX86DNHFCOEqV85FRh-Xzh1wg3p6guA0QeWG4+pg@mail.gmail.com>
 <561F9961.30008@ti.com>
 <CAL_Jsq+trQ3jLczxvtzqfpUKBgxaazPdGyjLg+NT2YFva0_xbA@mail.gmail.com>
 <561FBC4F.6030306@ti.com>
 <CAL_JsqJ0JUuwkVKtWbzqEWemx7wME61KYxgvv=vNUT8FiMtGYw@mail.gmail.com>
In-Reply-To: <CAL_JsqJ0JUuwkVKtWbzqEWemx7wME61KYxgvv=vNUT8FiMtGYw@mail.gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

--haLONVOnUUprtr8snVRC0RBTSsU7pednB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On 15/10/15 21:55, Rob Herring wrote:

>> True, but those child nodes are very limited. As I see it, those child=

>> nodes really describe the outputs of the LED chip, not what's on the
>> other end of the lines.
>=20
> The child nodes are supposed to be the other end. In the flash case,
> the properties are constraints on the flash LED (i.e. different flash
> LEDs will have different max currents).

Right, but what I meant is that the max current is applied to the LED
controller hardware, so in that sense it can be considered as a property
of the LED controller.

If there was, say, a flash that supports changing the color of the
light, that property would be applied to the flash HW so it'd be a
property of the "other end".

>> If on the other end of the lines is a more complex device, we need a
>> proper device driver for it, with a proper DT node with compatible
>> property etc.
>>
>> Now, one could argue that a "backlight" that gets the LED signal from =
a
>> LED chip is really just a simple LED. But there are complications:
>=20
> I would say backlights are a complex example of LEDs. Of course, there
> are backlights not based on LEDs, but we're not talking about those
> here.

I like the GPIO/PWM binding model, as it doesn't force any
node-hierarchy to the consumer of the GPIO/PWM. I don't see LED
controller output being any different than PWM, but the current LED
bindings still force the consumers of the LED signal to be a child of
the LED controller.

How about an LCD module, controlled via i2c, which takes a LED PWM
signal as an input, but needs i2c commands to enable the actual
backlight? So kind of i2c controlled smart LED. Or if the LCD module
takes two LED PWM signal inputs to achieve some fancy backlight effects.

Yes, it's theoretical HW, and I know some people don't like to discuss
such things... But the above example is easily accomplished with the
GPIO/PWM style bindings, but I don't have any idea how it could be done
with the current LED bindings.

>> - Our board needs a GPIO to enable the backlight. I can't say what
>> exactly the GPIO does as my HW skills don't go far enough, but all thi=
s
>> is after the LED chip. I also see the circuitry using powers, which in=

>> our case happen to be always on so we don't need to enable them explic=
itly.
>=20
> The GPIO is probably controlling a transistor to connect the LED anode
> to ground and therefore turn it on. These have nothing to do with
> backlights really, but really are common to LEDs. Every LED needs a
> supply rail too. This may come for a regulator or directly from an LED
> driver IC.

There's something a bit more complex there. The gpio controls TI
TPS6108x (http://www.ti.com/lit/ds/symlink/tps61081.pdf "High-Voltage
DC-DC Boost Converter").

But possibly all that can still be considered as you described.

> If the flash LED binding doesn't have these, then it is only a matter o=
f time.
>=20
>>
>> - We need a backlight device/driver (because of the Linux SW stack).
>=20
> From a binding perspective, not my problem. The problem with the
> driver needs driving the binding definition is the drivers can change
> over time. IIRC there has been some discussion of combining the 2
> subsystems in the kernel, so we don't want to create something defined
> by current kernel needs.

True. But on the other hand I would also not want to force new drivers
to use the current binding model, if it doesn't quite fit.

So if the PWM/GPIO model is fine, and LED controllers are really very
similar, shouldn't we extend the LED bindings towards PWM/GPIO model
rather than trying to fit everything into the current LED bindings?

Of course, even if everybody would agree with the above, this particular
backlight binding is rather simple, and I think we can fit it in the
current model. But that then raises the question, if led-backlight and
pwm-backlight are about the same, why are the binding model different.

>> So, maybe it would be possible to construct all that in a LED child
>> node, and the LED driver would create a child device for the nodes whi=
ch
>> have 'compatible' property. But then, that would be very different fro=
m
>> pwm-backlight, and the parent-child relationships are usually used to
>> indicate a control relationship, right?
>=20
> This is along the lines I was thinking, but don't see how it is very
> different at the binding level. The parent-child relationship is

In my experience, the relationship between the nodes is usually the most
difficult part with bindings, both in the design side and the driver
implementation side.

So if pwm-backlight links to the pwm source using a phandle, and
led-backlight links by child-parent relationship, I see them as quite
different, even if the rest of the properties are the same.

> typically control path or just what is downstream from the parent
> device. Some bindings like GPIO and PWM don't follow this, but that is
> often because they are just additional sideband interfaces on top of
> the main control interface. I think simply making the "backlight" node
> from the pwm-backlight binding a child works. We probably need a
> different compatible string though (led-backlight is as good as

So hmm... You mean using the pwm-backlight node, without the "pwms"
property, as the source is implicit? So:

/* tlc59108 is an i2c device */
tlc59116@40 {
	#address-cells =3D <1>;
	#size-cells =3D <0>;
	compatible =3D "ti,tlc59108";
	reg =3D <0x40>;

	wan@0 {
		label =3D "wrt1900ac:amber:wan";
		reg =3D <0x0>;
	};

	bl@2 {
		label =3D "backlight";
		reg =3D <0x2>;

		compatible =3D "led-backlight";
		brightness-levels =3D <0 243 245 247 248 249 251 252 255>;
		default-brightness-level =3D <8>;

		enable-gpios =3D <&pcf_lcd 13 GPIO_ACTIVE_LOW>;
	};
};

At the moment each LED controller driver does its own DT parsing, and
there's no common code for anything related to DT in the LED framework
and the LED framework is not even aware of DT nodes or such (which is
why I needed a bit hackish approach in my patches to find the nodes).

I have a gut feeling that going into this direction will require quite a
bit of restructuring in the LED drivers, so I think I need to leave this
task for others due to lack of time.

> anything). I also think we should require child nodes to have a
> compatible string which we didn't do for flash devices. It's probably
> not too late to fix that.

That is probably a good idea.

> I think there are 2 cases of PWM connection to LEDs to consider. The
> PWM is an input to a LED driver chip or the PWM directly controls the
> LED (attached to the anode). The current pwm-backlight binding covers
> the latter. In the former case, pwms should probably be in the parent
> (LED driver IC node). Of course, if the driver IC has no s/w
> controllable interface beyond PWM, then it probably doesn't need to be
> modeled at all in DT.

I guess one option would also be to create an MFD of the LED controller,
so that it would offer some of the outputs as plain PWMs. Then
pwm-backlight could be used directly.

 Tomi


--haLONVOnUUprtr8snVRC0RBTSsU7pednB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWIOKLAAoJEPo9qoy8lh71SxoP/0+dLBjEnGDYUYcOC4djv5q1
Ub/rMRwNkSg4AQvCM3E1Exyh3rW5UmAlX2DCWLcw1gRGIOhbDgHys+H0VkLdTKw5
y8UHBxsv5S5xsUlMNtDATerLwEe8HTnxoIuCuiXfdJxAvvuMAZ8aHL7ieLWzKnhd
sZkwBzycyKLkLVLJwImelgQyQNe2g44AR+mI9J/k9gSb+wfHTiOEB7G3kZzQxF7q
1Oj863CuKQD6I+r6ubakV0z3naVL6sY8Tjm0Nhwox8zLaexIvIWul8R1odKVPWb3
vz5+DGtF29aHoWgksTQ1h1+OXZ/pbWUpZfjUixORshtD/3iDH9Ii4rMiKE5/+8tq
HLxAH1u6yU7DgPwo3en586HnDVXMEqBjVWPlh36ydysILfeq7OBJ3Fuluvi1IVRq
marznZM47lSHSlFSVucke7S0E9/kx2zGLdNuxt9vv207UHXX6BeMb7So5DHbOSg6
yoN/Y/Z2cuuFseawWGTCfWOqeq8Svc+P/b1wRlo9IF1ANDrV5mJXq+dJRX2Z0wjC
5evQvnVW6i4vEQeudcmn/wKca05bTfV6cu5NZbDzUvXRPOQU0xB0XFbOoldmWGwa
+D47393YZgXhxV/XGubuaHFFSz+2WRNaUE3mSj0lZtlOx73bMCeU6GBX9y3u1lex
DadKB9yo5I591NtTbeKC
=gTvG
-----END PGP SIGNATURE-----

--haLONVOnUUprtr8snVRC0RBTSsU7pednB--
