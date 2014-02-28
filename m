From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 28 Feb 2014 16:12:23 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <5310B567.7040605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="orJMs4cg3oEKUxhgVOG12N4bokLulnr6I"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
 <20140228155937.GQ21483@n2100.arm.linux.org.uk>
In-Reply-To: <20140228155937.GQ21483@n2100.arm.linux.org.uk>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--orJMs4cg3oEKUxhgVOG12N4bokLulnr6I
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28/02/14 17:59, Russell King - ARM Linux wrote:

>> +dvi0: connector@0 {
>> +	compatible =3D "dvi-connector";
>> +	label =3D "dvi";
>> +
>> +	i2c-bus =3D <&i2c3>;
>> +
>> +	dvi_connector_in: endpoint {
>> +		remote-endpoint =3D <&tfp410_out>;
>> +	};
>> +};
>=20
> This looks far too simplistic.  There are different classes of DVI
> connector - there is:
>=20
> DVI A - analogue only
> DVI D - digital only (single and dual link)
> DVI I - both (single and dual digital link)
>=20
> DRM at least makes a distinction between these three classes, and this
> disctinction is part of the user API.  How would a display system know
> which kind of DVI connector is wired up on the board from this DT
> description?

Yes, I think that's a valid change. But do we also need to specify
single/dual link, in addition to the three types?

I guess the compatible string is the easiest way for differentation, at
least for the three main types, i.e. "dvi-d-connector" etc.

"dvi-d-1l-connector" and "dvi-d-2l-connector" for the single/dual link?
That looks a bit funny.

 Tomi



--orJMs4cg3oEKUxhgVOG12N4bokLulnr6I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTELVnAAoJEPo9qoy8lh71zAAQAI7D6sTc6fpNcul0qrzf5/Ts
vXMXkzs42KeshpY0967RerXCz5DK2TMLSlPhlvBsfaeq4v85RyBzQ01DywIsXbsq
RCeO1x4kJfMygPGZgtnxkpojUlgkHAxkLL3REYxrowx41OOD+dBKvbeBu1+ZmoJT
E9uXVRVMtousyLKUEYKL97tvtGVF8UZ2I+U8pmAbw2Abo3CkVHR+2m2bQUP65wKU
dCqNgLH4knxAn2f8xjVp3z0PF1rB37HNV1EbnE0zpXB9jokhV+uklBA2DdY2n5dH
XieuZVX2aIS7OLqDDin6t7ciq3lGpAQMOvTJ8xVm6UR5AFXjKkRhzppIN+Cwatt4
fitsjX+XhY75KvMu/WAclm84ZFQkmjZJy5tj+6Uqp52+h2XGOSTBMCyGf5Mli7zb
zOz/bHJrO93iCcWZV88gHZhjUGRghHbjPA2ybUEO6hFWR5LJBKXwmIMCOGId6KIZ
byx8ZfuyzvMBkYBIBo3rJSZU8ox8EGjDCDQrTFZnB09ZbgHZY9ZJOLfuAu/5aKV6
3NuCujsiYTsNfswpVVv4uIf++zfkmcj4PTpAdb38Q9ESF6ioAgpgF13Qco5xi01a
1p9jPLQWiZ/+sDRG7XVDf/qrQ/v2CTpJkxuYfal61eTC+GwtOISVpQr8eRqtlZi2
qqaNhVIRtahsF4zhFRn0
=ch7q
-----END PGP SIGNATURE-----

--orJMs4cg3oEKUxhgVOG12N4bokLulnr6I--
