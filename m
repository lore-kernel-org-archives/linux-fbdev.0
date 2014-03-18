From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 18 Mar 2014 08:52:59 +0000
Subject: Re: [PATCHv2 2/8] Doc/DT: Add DT binding documentation for Analog TV Connector
Message-Id: <5328096B.5080206@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Tb4lt1J47FAALJ0ASOTug7o3Hs1T3fQxt"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>	<1395130547-18633-3-git-send-email-tomi.valkeinen@ti.com>
 <CAMuHMdVhh_qqXvUP9zUo0iCJ=O6bLqp-qTdaMQNLNcVgAgROBg@mail.gmail.com>
In-Reply-To: <CAMuHMdVhh_qqXvUP9zUo0iCJ=O6bLqp-qTdaMQNLNcVgAgROBg@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, DRI Development <dri-devel@lists.freedesktop.org>, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel@ffwll.ch>, Archit Taneja <archit@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--Tb4lt1J47FAALJ0ASOTug7o3Hs1T3fQxt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 18/03/14 10:40, Geert Uytterhoeven wrote:
> Hi Tomi,
>=20
> On Tue, Mar 18, 2014 at 9:15 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/video/analog-tv-connector.txt
>> @@ -0,0 +1,25 @@
>> +Analog TV Connector
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Required properties:
>> +- compatible: "composite-connector" or "svideo-connector"
>> +
>> +Optional properties:
>> +- label: a symbolic name for the connector
>> +
>> +Required nodes:
>> +- Video port for TV input
>=20
> Only input, not output?

Yes, I have only made the bindings for display. I have no experience on
the capture side. I can change the port bindings for the connectors to
say they may be input or output, but I have to say I have no idea
whether the bindings work for capture.

But this is also something that I think could be extended in the future,
when we have some code to actually use them on capture pipeline. For now
it may be safer to keep them only for display.

> Have you considered adding bindings for other analog connector types?
>   - composite (YCbCr),
>   - component with and without sync-on-green (RGB and RGBHV),
>   - D-terminal (D1/D2/D3/D4/D5).
>=20
> Am I missing some?

No, I haven't. I have no experience on those, and generally very little
experience on analog video. I've added bindings only for the hardware I
have.

If there are lots of different analog TV connectors, should I just split
the current "analog-tv-connector" into separate composite and svideo,
instead of trying to manage them with a single one? The reason I
combined composite and svideo was that there didn't seem anything else
to specify than the connector type.

 Tomi



--Tb4lt1J47FAALJ0ASOTug7o3Hs1T3fQxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTKAlrAAoJEPo9qoy8lh71cPkP/3ckNqL1kJhu34umjw3sGScV
rg+JGEwEebt4Wjk8AAFjJcTsNo0TzrlYQL21JSZs7VsZEznTfdcUoiTNrD0Qi/Ck
UMxsPLazmH9ysgP4s1dtdJqxV+Ns7dnNWf3RQvgqKqj1Y9lsjiSTTcDtfdJAeOBG
ZIRC1DGGbJTv6GR06km1jvd+SrA7o4aWULbgMGwfxhuHjRlM8BanMeFraShjnKU6
Ph7g1bkcMmP/kj5qH1/l0bXef6hrsRc3sp3vVdNpqBFIkK62gQ09MCWTfAfLTwe1
1XMH6q3tP4xq6SKdvU88jhMKEYvfu/DDyoM/h6exdLczcSmu5XTM+YTX8h34a2D0
OGe9ZULLRzjJwPjkgik7uXl+g853UxoXDOaMJeS5q/jrwujHcKamDYfY0/m8Hezf
9gg8yJ6l20+eB3vcSxhrEDF4xa3xu05rmGWsd5+2rQmvQSgbbJDihIsMNxD03x2r
6tidgHDwQPrKx09VkI/8IAePS9NDDfDWQbsaUohKQ6XNZRiMVNilNlBLT7odPhhS
OHzzWM32KeNALb0+9iASf8CzSfmeL5DW+9eGaJHBXZeDy1Yz0YH1TSlyBApD2sIF
fq4174AXEAfJnl2TL1uUltz/aF899PHddb+CDNAsNxCO5cAUTMzhxQeRHfmk+8K/
uDXR/jiIVjV2B4G2qV2I
=LRhV
-----END PGP SIGNATURE-----

--Tb4lt1J47FAALJ0ASOTug7o3Hs1T3fQxt--
