From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 28 Feb 2014 15:39:50 +0000
Subject: Re: [PATCH 0/9] Doc/DT: DT bindings for various display components
Message-Id: <5310ADC6.1020904@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="p8n5P3VfH8Gl3GM2wG4OglNPCCOQMg1qf"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <531087C0.1090501@gmail.com> <53108B9C.5000006@ti.com>
 <5310945A.9040106@gmail.com>
In-Reply-To: <5310945A.9040106@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>

--p8n5P3VfH8Gl3GM2wG4OglNPCCOQMg1qf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28/02/14 15:51, Sebastian Hesselbarth wrote:

>> TPD requires a power. Who turns that on? It also has two GPIOs, LS_OE
>> and CT_CP_HPD, which need to be controlled based on what the user want=
s
>> and the state of the HPD line. Who controls those?
>=20
> Strictly speaking TPD12S015 has _no_ GPIO but only buffers. It

What do you mean with that? That TPD doesn't provide GPIOs that you
could control, in the sense that SoCs do? Sure. I didn't mean that. I
meant it has gpios in the same sense that, say, a panel might have a
'enable' gpio.

Somebody needs to control the gpio state. For a panel, I would say it's
the panel driver's job. And the gpio would be present in the panel's DT
node. The same way for TDP.

> translates one voltage to another. The controlling instance is
> your "video card" that is really interested in the actual state
> of HPD signal.

Well. I think it's the driver for the respective hardware device that
handles the gpio. Of course, that driver will usually get information
from somewhere else when to use those gpios. It may be the "video card",
but really, the video card driver also gets the information if to enable
the output from somewhere else.

> Also the same for power, TPD12S015 doesn't decide to be powered up
> or down but the "video card" does. We have GPIO regulators that
> deal with that situation already.

The same here. TPD driver gets told to enable itself (or some particular
feature that it supports). It will then enable the required powers.

> Consider the same board but replace TPD12S015 with another level-
> shifter, you still want OMAP video driver work with that out-of-the-box=
,

Right. For this exact reason, the TPD is a separate driver. I can easily
leave it out, or replace it with any other similar chip. Or the TPD
driver can be used on some other platform.

OMAP video driver doesn't know anything about TPD, as TPD is not part of
OMAP video hardware, or even OMAP SoC.

How would this work without TPD, or with, say, TPD1234567, which instead
has 5 GPIOs that need to be set in particular order? The video card
driver would need to know the exact details of all possible level
shifters out there? Or?

> don't you? Fact is, OMAP IP requires GPIOs to sense HPD status hence
> that GPIO is a property of the corresponding OMAP node. How level-
> translation happens is irrelevant here.

No it doesn't. There are different ways to handle HPD on OMAP HDMI. It's
true that the HDMI IP supports directly handling HPD, but that's not
used as there were some issues with it (I don't remember what). The HPD
can as well be handled outside the HDMI driver.

If the HDMI IP would be handling the HPD, then, yes, HDMI node would
have HPD gpio defined.

> Thinking about it again, HPD gpio shouldn't be a property of the
> connector at all but again the controlling instance. The connector
> cannot deal with the information provided by HPD nor can it determine
> if anyone is listening to HPD events.

Well, this goes into the driver implementation details, but I disagree.

You have a video pipeline, let's say it's just SoC's HDMI encoder, and
HDMI connector. In this particular case, the HDMI encoder IP has no
support for HPD. On top of that, you have a "video card" driver,
"display subsystem" driver, or whatever you want to call it, which is in
control of the video pipeline. Let's call it controller.

The controller asks to get notified of a HPD event from the video
pipeline. It doesn't care if the HPD is handled by the HDMI encoder
driver or the connector driver. They can each handle it, in ways that
suit the particular hardware they control. Of course, handling it in
only one place usually makes sense.

When the controller is notified of a HPD, it can then decide what to do.
If the user has told it to enable video output on HPD, the controller
can command the video pipeline to be enabled.

>> Well, I think the HPD gpio should be where it's most logical to have i=
t.
>=20
> Right, but this is usually the controlling instance and not the
> consuming one. E.g. to detect presence of an MMC card by GPIO, you'd
> put that into the MMC _controller_ not any card node.

I'm not familiar with MMC, so there it may be clear. With video, we can
have arbitrarily long video pipeline chains, with each component changed
to some other, differently behaving component.

Let's think of another case. SoC's DSI encoder, an external HDMI
encoder, and a HDMI connector. Who handles the HPD? Surely not the SoC's
DSI encoder, as there's no such concept as HPD in DSI? The "video card"
driver? Maybe, but from the video card's perspective, it is driving a
DSI peripheral, and again no HPD in DSI.

The logical place there is the external HDMI encoder. And again, the
HDMI encoder doesn't independently handle decisions about what to do
when HPD happens. It just catches it, and tells somebody wiser about it.

And really, what's the difference with, say, an external HDMI encoder
and TPD? Ok, lots =3D). But they both take video input in, output video,
and require some config/control to make the chip work.

I totally agree that TPD is on the simpler side of components. But I
think it fits right in into the model, and it works great on OMAP.
Compared to older version, where TPD support was baked into the OMAP
HDMI driver, which was a mess.

>> I mean, you could have a setup where you have the SoC HDMI encoder and=

>> and the HDMI connector, and the HPD pin goes directly to the HDMI
>> encoder, which has HW support for it. In that case, the HDMI encoder
>> node should contain the HPD, and the HDMI encoder should handle it.
>=20
> I wonder, if in case of an dedicated HPD pin, you would ever expose tha=
t
> in DT.

Yes, if it's a dedicated pin, no configuration information needed, thus
no information needed in DT. Well, pinctrl maybe.

> Having a driver for a dumb connector seems to be a little exaggerated.
> Consider your generic HDMI connector "driver" connected to dedicated HP=
D
> case above. It is pretty useless then. OTOH video controllers with
> dedicated HPD know very well they can control HPD themselves, video
> controllers without dedicated HPD also know very well that they need
> GPIO for it.

Yes, I have to say I'm not 100% sure about the connectors. They could
perhaps be left out. But they make things consistent, in my opinion, as
they present a terminator for the video pipeline.

Say, you could have these two different boards:

SoC HDMI -> TPD -> HDMI connector

SoC HDMI -> TPD -> Embedded HDMI panel

In both cases, there's a component at the end, which is the end of the
pipeline (as far as we're concerned). I think it makes the driver side a
bit cleaner, and doesn't leave the TPD's output "hanging out" there.

Also I have used the connector drivers for actual work. The DVI
connector has support for reading EDID via i2c. This is again something
that you can argue that, hey, it should be the "video card" doing it.
But it fits quite well into the DVI connector, and there's no other
hardware component that has any support for the EDID.

I again see the above so that the video pipeline offers a way to read
EDID. Where exactly that's done and how it happens on the hardware
level, the controller doesn't care.

>> In OMAP's case, we have the TPD chip between the HDMI encoder and the
>> connector, and the logical place to handle HPD GPIO in that case is th=
e
>> TPD driver, as that's where the HPD is connected to and the TPD needs =
to
>> be configured according to the state of the HPD.
>=20
> Is it really the logical place to handle HPD? I'd have put it into the
> HDMI encoder because it's the unit most interested in the state of HPD.=


At least in OMAP's case, when not using the HDMI encoder's support for
HPD, the HDMI encoder is not interested at all about the HPD.

> Please, don't get me wrong, I like all this to be baked into a binding =
-
> just wondering if a level-shifter driver plus corresponding DT node
> is too much detail in here.

Thanks for the comments, I appreciate it. I hope I've convinced you
enough =3D).

 Tomi



--p8n5P3VfH8Gl3GM2wG4OglNPCCOQMg1qf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTEK3GAAoJEPo9qoy8lh71I5sP/3M6APzt8nxll+6Gpb9iEIC4
FL2yUa/dlEj/ziFhDmTztQoGJliSfwYOhcHKNpVgiywBRMG26Dtf/w3oXxI1SWoi
3VePfTpSSLswO4AAlzlPhC/3+6+a6FUaqmfEqizZW6ggQmxpXVROZ/aw/yTxG6BK
Do82cJOgIpb+HkKfT98IUff6OQGNl+F36G1Z1Y6htNZD0MccgTXsJUdKYh6sGBFR
WvBVxxZdMbWUfLqEedyouAU2wj5Uadtrad4GEXowoqaxhMhOAPc6AAJw5yANOSmv
wOoDNp2il6+a3i8+ZwVDgLRCzgraOszXuM/IprNL53dCTTCA1LN23KhjKcatImI7
TzHKtVi6y3hEo6iwoZhX61E/JHm+PAFyWiPbtJ4GDr/xFw6Lx0ybrbWhI5IZOV9Z
gXSp/wUy/lzgxwVAvJiTAQ9NAEVqo8MjiNX1+TJJk9v4Eoc7b5Z7ZEKrcm2go57T
6JkdgChOx1e5GEfx5siK2yC21ZWOEhMVwiBl4DPc7e2gVMNGXlxvBVTOk7LByMlj
u3q/gJWKzLtWGkKqFHxSEOG6gmE4kKrZ+McNnR56fI+9DNu75xpd59PVV2wapBJa
L4mpTM6zf6ED/sx5rf3pQpxlSqG5YkxMHwUHHMsjje6h0OxPfa7yTmSujcaRmLE+
IBJSmaSoji35lKJe/2Cw
=tc65
-----END PGP SIGNATURE-----

--p8n5P3VfH8Gl3GM2wG4OglNPCCOQMg1qf--
