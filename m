From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 28 Feb 2014 13:14:04 +0000
Subject: Re: [PATCH 0/9] Doc/DT: DT bindings for various display components
Message-Id: <53108B9C.5000006@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Gtu5vU8V650wFqLEo8P7fwcHnl389Qh5u"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <531087C0.1090501@gmail.com>
In-Reply-To: <531087C0.1090501@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>

--Gtu5vU8V650wFqLEo8P7fwcHnl389Qh5u
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28/02/14 14:57, Sebastian Hesselbarth wrote:

> Out of curiosity, will there be DT nodes for pull-up resistors soon,
> too? ;)

If they don't work automatically, yes, we need DT nodes and drivers for
them.

> Honestly, TPD12S015 is a level shifter, there is nothing in it that
> would justify a DT node nor a driver.

TPD requires a power. Who turns that on? It also has two GPIOs, LS_OE
and CT_CP_HPD, which need to be controlled based on what the user wants
and the state of the HPD line. Who controls those?

> Above you already note, that connector nodes should offer HPD in the
> future, but I guess the binding should represent that now already.

I think it can be added when somebody uses it. I don't see why that
would cause trouble later to those that don't use it.

> I will be a DT stub anyway, the corresponding video sink driver will
> have to look it up.

I'm not sure what you mean with that. Yes, it's not the most complex DT
nodes out there.

> Looking through the bindings for DVI and HDMI, I guess HPD gpio is
> better kept in those nodes. From the relevant (DT) properties DVI and
> HDMI connectors are in no way different.

Well, I think the HPD gpio should be where it's most logical to have it.

I mean, you could have a setup where you have the SoC HDMI encoder and
and the HDMI connector, and the HPD pin goes directly to the HDMI
encoder, which has HW support for it. In that case, the HDMI encoder
node should contain the HPD, and the HDMI encoder should handle it.

Or, your HDMI encoder could not have any kind of support for HPD. In
that case you could have the HDMI connector driver handle the hotplug
event. You could of course make the HDMI encoder driver handle the HPD
gpio, but I usually try to have the driver handle the hardware device in
question.

In OMAP's case, we have the TPD chip between the HDMI encoder and the
connector, and the logical place to handle HPD GPIO in that case is the
TPD driver, as that's where the HPD is connected to and the TPD needs to
be configured according to the state of the HPD.

 Tomi



--Gtu5vU8V650wFqLEo8P7fwcHnl389Qh5u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTEIucAAoJEPo9qoy8lh71G8kP/RfFSLElGL/z1dyjwbWAmPmz
eVj+7Tq5+cuTG7Y3dxE+G5xckYQhg+/Z57CPq6N5Yygk9Lpo03UlPcDY9TRosM0N
Fr4bp/VN9fKOugS0uNyqgaXfjBUX+ZlqGOM+Ume6Mqsk1yFZQxBKuref/vK+DKgz
vg+0r9JIR2Plid6OzSgwMgifH6231A+qLGgb2+pn/nnODLiErUrbFGBUqiOTDFW5
1DjzcJbnVxkugu/uEc4/VNU1V5hwPcDNGuOg9RT9Dv0+KGRRW2NpFTkai1C/zS/t
4rwGwHrOYTIMIL74ZAKBsw4lcH3qAZyESuiy62xEB7D38CyoYpf+3E87omYBd3Pe
ijsPjNWk5aNAWDxEZCGww/kojARuZgMKWXv4zqbbVMhbgMgDpJmlD7IteuuUE3C5
DrcnbRxR+r87Wf/UOXyClm02goBNKWf/n9tzLGyO1rW8I5fr9cKC/KH4FsGPyCeh
wgKGIU0hE/jAbDSEHEHExkb0Qnl3iyYL3S/jBzMpv3J7WZbg2UdjpeZADIRHoMgn
JyLPvGYd5fawoyYP2658aVynVtU6Wyko/hu7Vgk7qI2KQL6yjhAuw4x1Gw+bO2J4
lexYWssKEhXtNfJDgvDFfkWYHKs959OjH2nCAMn+Z6uFZfl9yYoySsDLpW5n4jY1
xT1dUXUYVb4d2kZp1qwt
=j3cF
-----END PGP SIGNATURE-----

--Gtu5vU8V650wFqLEo8P7fwcHnl389Qh5u--
