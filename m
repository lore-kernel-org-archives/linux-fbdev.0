From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 03 Jun 2015 11:38:43 +0000
Subject: Re: [PATCH 2/4] video: fbdev: imxfb: Constify platform_device_id
Message-Id: <556EE743.5030405@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1S34owE0uIi8WOtvBqfgBIwbp77wm7cXP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430494721-30793-2-git-send-email-k.kozlowski.k@gmail.com>
 <20150505082807.GV4047@x1>
In-Reply-To: <20150505082807.GV4047@x1>
To: linux-arm-kernel@lists.infradead.org

--1S34owE0uIi8WOtvBqfgBIwbp77wm7cXP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On 05/05/15 11:28, Lee Jones wrote:
> On Sat, 02 May 2015, Krzysztof Kozlowski wrote:
>=20
>> The platform_device_id is not modified by the driver and core uses it =
as
>> const.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>> ---
>>  drivers/video/fbdev/imxfb.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Applied, thanks.

You applied the fbdev changes in this series also, not only the
backlight changes?

 Tomi


--1S34owE0uIi8WOtvBqfgBIwbp77wm7cXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVbudDAAoJEPo9qoy8lh71MoEP/0jMU+Gf03MMrrGzeV7WwIgo
ryHRmAv1xMbWsmoWJPPtAtyZ53G5aSPUGz6RgLknPpEqBAUzgi9aObBcj0FKXifM
qwkZN71HHotJv37lhSLlqiS7voZGjoBAFj47jLe1fEklkg47g8uMJMHM0DjbEHQf
RkvAVxjPH7YjLaxKLPFo2/zlHHr5K0oi2STCwnpSHlSpmzrG3NPGrXcXsez9sjKw
yNLW8nX5wTDR3guOmrO73JuJHXXj/iJMEbGF7XGAGwZGmoHjaDwkJs0OWr5YiKbB
LDn2iabUYxYszKYAeHuDWZQElihE4dCfpT4wO1x6HkliCD2ojvzbZBzepGe+pZDz
5RFXUe3Yx/GRA+PhlmXwMsrQZWdRvVpEAvROhr0V302C6yWCwiuRM0amzOgJy88w
W0OD/bK4WfQFMUbM/ZHbHZvpAmrZ5kqFNcTlXIZ+rnnw0M5zsZoVi005VVbxIYm9
QCryER8NVLAxHzI579pjYCC033rrMTNlF6H9ZWC5wOEPAERMcujLV1MZk+Dl4DMx
X59GGfrT4yKoItMjWd+uuPW44rUz3FMNoMmu0ywGlMN45EFe5PIDoFWQuZ6Aj0aY
QfLlzBzwlRmnIrLROX6NNunL7KMz/8UEJSI94fYBzRZyfiq6Ei89rvyyutmECo/y
sSKb/vxEZXuT/rdgdqO4
=K9Z5
-----END PGP SIGNATURE-----

--1S34owE0uIi8WOtvBqfgBIwbp77wm7cXP--
