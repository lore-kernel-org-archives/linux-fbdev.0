From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 03 Mar 2014 06:05:26 +0000
Subject: Re: [PATCH 5/9] Doc/DT: Add DT binding documentation for MIPI DPI Panel
Message-Id: <53141BA6.4040702@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9numtJOld7uFmmaqJIdc6GxIIkABnUkbL"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	
 <1393590016-9361-6-git-send-email-tomi.valkeinen@ti.com>
 <1393594836.3802.32.camel@paszta.hi.pengutronix.de>
In-Reply-To: <1393594836.3802.32.camel@paszta.hi.pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--9numtJOld7uFmmaqJIdc6GxIIkABnUkbL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 28/02/14 15:40, Philipp Zabel wrote:
> Am Freitag, den 28.02.2014, 14:20 +0200 schrieb Tomi Valkeinen:
>> Add DT binding documentation for MIPI DPI Panel.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Reviewed-by: Archit Taneja <archit@ti.com>
>> ---
>>  .../devicetree/bindings/video/panel-dpi.txt        | 43 +++++++++++++=
+++++++++
>>  1 file changed, 43 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/video/panel-dpi.=
txt
>>
>> diff --git a/Documentation/devicetree/bindings/video/panel-dpi.txt b/D=
ocumentation/devicetree/bindings/video/panel-dpi.txt
>> new file mode 100644
>> index 000000000000..72636c6f1c67
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/video/panel-dpi.txt
>> @@ -0,0 +1,43 @@
>> +Generic MIPI DPI Panel
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Required properties:
>> +- compatible: "panel-dpi"
>> +
>> +Optional properties:
>> +- label: a symbolic name for the panel
>> +- gpios: panel enable gpio and backlight enable gpio
>> +
>> +Required nodes:
>> +- "panel-timing" containing video timings
>> +  (Documentation/devicetree/bindings/video/display-timing.txt)
>> +- Video port for DPI input
>=20
> I don't see anything MIPI specific here. Couldn't this be added to the
> existing simple-panel binding?

Hmm, well, the simple-panel bindings doesn't define video ports, and not
even a common compatible property.

 Tomi



--9numtJOld7uFmmaqJIdc6GxIIkABnUkbL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTFBupAAoJEPo9qoy8lh71+vYP/3WVF6gzXQo+DMWInjGZ45sx
dLJxl96xVQ+YjsOkqOYk6PwBGV69dRQtue5L2zTgLs5ttaQ4OZ5ycbRyLEavDtXo
lz8e1PFJGVVwP7f5NpDXhyHFT0bJmcondA3MOC5fA5Vw+jVgZ71LhBYI3ItG2PaC
74/E1tnZOQgoKAJin0/xGhPcZ4i0EDdfg6ELmMyCf0ZImlrcBI1hKb/90WpTqSgM
2VuRweiOdEEu2aS5OiLYtKMogXapSZnc75+GTwZ5aFKzgtKhFIHyoT41gMTFQQgm
CYdYSrCHm+8xoOE3nfms/kxEcKg/r2Mbjn08TcZm5UdQsTIq1fGi7nnk9yDTrkRR
du91gtXUI/5j6wdBEtMPKI6qdkSno62L3KfZySlT4FcSGoEKu6dCS0oH/S0kSqst
DW/xr9ulnLAttDy1/zI86DGUz6JbDfIOL9wnVbT8Ea8kJ9o/9yBGytMv/4RKNpDk
fm0JBCxI06RZh7rrVQBIlHX5JxA5/4dcgMKEjT6+nCpz8BWD96OfJEsBgcH/kwiA
Sq3tRg6Xd+nemHPInGCJNN1vzGI7cjQ4T9pQNKti4SioCQScim88098vXKIvrdAz
QeK8do7bimGrRPQBGScJAdWtSzxSenng18KiFGjISNZE1E9mhj8PJjnLNWMLnfDL
kICuEZ0HBSEC8pVsbzM6
=9Nwa
-----END PGP SIGNATURE-----

--9numtJOld7uFmmaqJIdc6GxIIkABnUkbL--
