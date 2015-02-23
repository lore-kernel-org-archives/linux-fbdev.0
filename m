From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 23 Feb 2015 09:43:01 +0000
Subject: Re: [PATCH 2/8] fbdev: ssd1307fb: Unify init code and make controller configurable from device tree
Message-Id: <20150223094301.GA25269@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KjcUHqqCp23GY06r"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-3-git-send-email-niederp@physik.uni-kl.de>
 <20150207104225.GM2079@lukather>
 <20150207155933.4f1d0998@maestro.intranet>
 <20150212164147.GK2079@lukather>
 <20150214171232.11ccb264@maestro.intranet>
In-Reply-To: <20150214171232.11ccb264@maestro.intranet>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


--KjcUHqqCp23GY06r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 14, 2015 at 05:12:32PM +0100, Thomas Niederpr=FCm wrote:
> Am Thu, 12 Feb 2015 17:41:47 +0100
> schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
>=20
> > On Sat, Feb 07, 2015 at 03:59:33PM +0100, Thomas Niederpr=FCm wrote:
> > > Am Sat, 7 Feb 2015 11:42:25 +0100
> > > schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
> > >=20
> > > > Hi,
> > > >=20
> > > > On Fri, Feb 06, 2015 at 11:28:08PM +0100, niederp@physik.uni-kl.de
> > > > wrote:
> > > > > From: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> > > > >=20
> > > > > This patches unifies the init code for the ssd130X chips and
> > > > > adds device tree bindings to describe the hardware configuration
> > > > > of the used controller. This gets rid of the magic bit values
> > > > > used in the init code so far.
> > > > >=20
> > > > > Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> > > > > ---
> > > > >  .../devicetree/bindings/video/ssd1307fb.txt        |  11 +
> > > > >  drivers/video/fbdev/ssd1307fb.c                    | 243
> > > > > ++++++++++++++------- 2 files changed, 174 insertions(+), 80
> > > > > deletions(-)
> > > > >=20
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/video/ssd1307fb.txt
> > > > > b/Documentation/devicetree/bindings/video/ssd1307fb.txt index
> > > > > 7a12542..1230f68 100644 ---
> > > > > a/Documentation/devicetree/bindings/video/ssd1307fb.txt +++
> > > > > b/Documentation/devicetree/bindings/video/ssd1307fb.txt @@
> > > > > -15,6 +15,17 @@ Required properties: Optional properties:
> > > > >    - reset-active-low: Is the reset gpio is active on physical
> > > > > low?
> > > > > +  - solomon,segment-remap: Invert the order of data column to
> > > > > segment mapping
> > > > > +  - solomon,offset: Map the display start line to one of COM0 -
> > > > > COM63
> > > > > +  - solomon,contrast: Set initial contrast of the display
> > > > > +  - solomon,prechargep1: Set the duration of the precharge
> > > > > period phase1
> > > > > +  - solomon,prechargep2: Set the duration of the precharge
> > > > > period phase2
> > > > > +  - solomon,com-alt: Enable/disable alternate COM pin
> > > > > configuration
> > > > > +  - solomon,com-lrremap: Enable/disable left-right remap of COM
> > > > > pins
> > > > > +  - solomon,com-invdir: Invert COM scan direction
> > > > > +  - solomon,vcomh: Set VCOMH regulator voltage
> > > > > +  - solomon,dclk-div: Set display clock divider
> > > > > +  - solomon,dclk-frq: Set display clock frequency
> > > >=20
> > > > I'm sorry, but this is the wrong approach, for at least two
> > > > reasons: you broke all existing users of that driver, which is a
> > > > clear no-go,
> > >=20
> > > Unfortunately this is true. The problem is that the SSD130X
> > > controllers allow for a very versatile wiring of the display to the
> > > controller.  It's over to the manufacturer of the OLED module
> > > (disp+controller) to decide how it's actually wired and during
> > > device initialization the driver has to take care to configure the
> > > SSD130X controller according to that wiring. If the driver fails to
> > > do so you will end up having your display showing
> > > garbage.
> >=20
> > How so?
>=20
> One good example is the segment remap. It basically allows to invert the
> order of the output pins connecting to the oled panel. This gives the
> manufacturer of the module the freedom wire it the one way or the
> other, depending on the PCB restrictions/panel layout (Section 10.1.12
> of [0], 10.1.8 in [1], 9.1.8 in [2]). However, once the panel is
> connected to the controller it's determined whether the segment remap
> is needed or not. Setting the segment remap as done in the current
> initialization code for ssd1306 and ssd1307 makes my display module
> show it's contents mirrored left to right, probably since the
> manufacturer decided not to connect the panel in an inverted order.
>=20
> The same applies to the com-alt, com-lrremap and com-invdir values,
> which define different possibilities for the COM signals pin
> configuration (Section 10.1.26 of [0], 10.1.18 in [1], 9.1.18 in [2])
> and readout direction of the video memory (Section 10.1.21 of [0],
> 10.1.14 in [1], 9.1.14 in [2]). Setting com-alt incorrectly leaves
> every other line of the display blank. Setting com-lrremap incorrectly
> produces a very distorted image. Setting com-invdir incorrectly flips
> the image upside down.
>=20
> IMHO at least these four hardware-specific properties need to be known
> to the driver in order to initialize the hardware correctly.

I'd agree then.

> > Does it depend on the X, or can it change from one same controller to
> > another? to what extent?
>=20
> Unfortunately I do not posses any hardware utilizing a ssd1306 or
> ssd1307 controller. My primary and only target device is a Newhaven
> NHD-3.12-25664UCB2 OLED display module using an SSD1305 controller. I
> just inferred from the datasheets of ssd1306/7 [1,2] that they should
> behave the same since the registers are bit to bit identical (except
> for the VHCOM register). Maybe that was a bit too naive :/

I would guess it's a rather safe assumption.

> > The 1306 for example seems to not be using these values at all, while
> > the 1307 does.
>=20
> That is surprising. In that case I would like to ask the guys from
> Solomon why they describe all these options in the SSD1306 datasheet
> [1]. But in any case, isn't that good news for the problem of setting
> the default values. When the 1306 isn't using these values anyway we can
> not break the initialization by setting different default values. In
> this case the problem of the default values boils down to the segment
> remap only since this is set in the init code of the 1307, while the
> default would be to leave it off.

Indeed.

> > > Unfortunately the current sate of the initialization code of the
> > > ssd1307fb driver is not very flexible in that respect. Taking a look
> > > at the initialization code for the ssd1306 shows that it was written
> > > with one very special display module in mind. Most of the magic bit
> > > values set there are non-default values according to the
> > > datasheet. The result is that the driver works with that one
> > > particular display module but many other (differently wired) display
> > > modules using a ssd1306 controller won't work without changing the
> > > hardcoded magic bit values.
> > >=20
> > > My idea here was to set all configuration to the default values (as
> > > given in the datasheet) unless it is overwritten by DT. Of course,
> > > without a change in DT, this breaks the driver for all existing
> > > users. The only alternative would be to set the current values as
> > > default. Somehow this feels wrong to me as these values look
> > > arbitrary when you don't know what exact display module they were
> > > set for. But if you insist, I will change the default values.
> >=20
> > Unfortunately, the DT bindings are to be considered an ABI, and we
> > should support booting with older DTs (not that I personally care
> > about it, but that's another issue). So we really don't have much
> > choice here.
> >=20
> > Moreover, that issue left aside, modifying bindings like this without
> > fixing up the in-tree users is considered quite rude :)
>=20
> I didn't intend to be rude, sorry. A quick search revealed that there
> is luckily only one in-tree user, which is imx28-cfa10036.dts. In case
> it will be necessary I will include a patch to fix this.

Please do (and fix the bindings Documentation too).

> > > > and the DT itself should not contain any direct mapping of the
> > > > registers.
> > > >=20
> > >=20
> > > I think I don't get what you mean here. Is it because I do no sanity
> > > checks of the numbers set in DT? I was just looking for a way to
> > > hand over the information about the wiring of display to the
> > > driver. How would you propose to solve this?
> >=20
> > What I meant was that replicating direct registers value is usually a
> > recipe for a later failure, especially if we can have the information
> > under a generic and easy to understand manner.
> >=20
> > For example, replacing the solomon,dclk-div and solomon,dclk-frq
> > properties by a clock-frequency property in Hz, and computing the
> > divider and that register in your driver is usually better, also
> > because it allows to have different requirements / algorithms to
> > compute that if some other chip needs it.
>=20
> I'll give that a try, even though that particular one is not trivial
> since the documentation on the actual frequency that is set by the
> dclk-freq is very poor (not present for 1306/1307 [1,2], just a graph
> for 1305 [0]).
>=20
> For the properties describing the hardware pin configuration (see above)
> I see no real alternative. Maybe they can all be covered by one DT
> property like:
> solomon,com-cfg =3D PINCFG_SEGREMAP | PINCFG_COMALT | PINCFG_COMINV |
> PINCFG_COMLRRM
> each PINCFG_* setting one bit. The driver will then translate this into
> the correct settings for the 130X registers. The only problem here is
> that this implicitly assumes the default values of each bit to be 0.

A property that would be here or not is better. You can have all the
defaults you want, it's more clear in the DT, and you don't need the
macros.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--KjcUHqqCp23GY06r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU6vYlAAoJEBx+YmzsjxAgBEAP/jsGPMp9lhQsfZTElHK4vRTy
dtUGp/zVg+4/VoiG+iUJQ0jjMCdDs22YVIBMuDAx6+v3uXSDSijXDLauUW2/l2As
R2jYfiZe/bSfxYLltDJ6HVbPy2poMW5M9yGKKKX0zkdHLm/Z5RgqLB3Ju3CWN1sI
XQ1+nVkzKUrRpYwzpp2BmWNts7otAeB6ej3VWaI65tuGlsSLm2GDxlJhaLK2qSEl
v6bVs0dzwnmPQ0sobeKVNL9SM1rOh+Yr6MqQGyncgQmczEHduBVWQZIPkP7QrBNY
YcfW18HP54DpjNMhd1d3VjbQr85ZItOT5y2dRJUIcz768+TTEDvEyQesKzz+ofJy
LkA2jDTFCnN42OAqCURCkVM4bNelVXS1rZ5AdRVQFSLt3asm+P4GgGzw5HKMbzUQ
zaQg800F0HmzvjmOy2Zf0ELQ1bAymuts4OH7dnwV/JYUOFfkNxSYXM7/53L3AEaR
qL15zp0GjQE9HJHSbf/vb9wy+XLfPiRM26S+Ot9ImxoXSQxaSVkQ7HZdtZwKr8DI
xiAOvp8SY5U/5VSiggel2YEPww/Kqwiw2Qn25t4kiHNBZ8YfdghPKRJ6GVIEQPdK
cLDGZtlK+7KUX6CEGPMtjPZpn7BtsTjCI9OvoPuX9ELtjIbYyQQTlS4ppmjfyOKX
kfdNQWVdlAcJpXdT4QPh
=cxgF
-----END PGP SIGNATURE-----

--KjcUHqqCp23GY06r--
