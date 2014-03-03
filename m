From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 03 Mar 2014 06:25:43 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <53142067.2000208@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qIJsvadShJQco67wOGKOOOMHAKMmHcJg4"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	
 <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
 <1393595008.3802.35.camel@paszta.hi.pengutronix.de>
In-Reply-To: <1393595008.3802.35.camel@paszta.hi.pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--qIJsvadShJQco67wOGKOOOMHAKMmHcJg4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 28/02/14 15:43, Philipp Zabel wrote:
> Hi Tomi,
>=20
> Am Freitag, den 28.02.2014, 14:20 +0200 schrieb Tomi Valkeinen:
>> Add DT binding documentation for DVI Connector.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Reviewed-by: Archit Taneja <archit@ti.com>
>> ---
>>  .../devicetree/bindings/video/dvi-connector.txt    | 26 +++++++++++++=
+++++++++
>>  1 file changed, 26 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/video/dvi-connec=
tor.txt
>>
>> diff --git a/Documentation/devicetree/bindings/video/dvi-connector.txt=
 b/Documentation/devicetree/bindings/video/dvi-connector.txt
>> new file mode 100644
>> index 000000000000..6a0aff866c78
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/video/dvi-connector.txt
>> @@ -0,0 +1,26 @@
>> +DVI Connector
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Required properties:
>> +- compatible: "dvi-connector"
>> +
>> +Optional properties:
>> +- label: a symbolic name for the connector
>> +- i2c-bus: phandle to the i2c bus that is connected to DVI DDC
>=20
> For the i.MX bindings I had called this property 'ddc', but
> Documentation/devicetree/bindings/panel/simple-panel.txt already
> uses 'ddc-i2c-bus'. We should definitely standardize this.

I like 'ddc-i2c-bus'.

 Tomi



--qIJsvadShJQco67wOGKOOOMHAKMmHcJg4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTFCBnAAoJEPo9qoy8lh71oVEP/0yQjssvAaqupYlHnv4hINEK
SVcbt7AMwh79ANQRm7vkXyc+ubltji9X+Vbqy05ooX6fHYy4Vd2hbYTV7j/7rjvE
kKKqI9gvGqWIvez6U/AwbDWjud/IySz7qSSdnLItcNcv9r0BQxKwgzllcAezH3kd
XjCC3TmDD7Tp7ElgzmMBnma22eQyvb0Bc8AkbULzDq3RCPrj67NNXVQEErPqoJCW
o457f1CpZiXm2EdDTgqIpa7KS5Ko31T6UU6ci5Icd7vm9c/ZMZzTUVQZNgxCYRg0
xjSKZ5VBW4xDSZnEnqsoLIkf1wPkfQLaLr+ge384SRmnX0w5WnIOqQrcfpdMJuzS
+JowCG8a9uODPFMIU9DbRz5D2mTOA3EiwfjHG0i70XsR6ql8pCEa2cdlAeZf6Six
lkXFsIdz9R6N2kXzz0AwzzJ7b+i4Jq3Yq2IWSyPURcla+OFMIR0NcCVO1AhLRcJw
FhEzoFv/L59RRlSc/O6D7kA45fMq6mkGqSpwXQzQdQ9NqemSVfwsjCwl0jxar1Fk
KX4fR8s9QDAaR7Sd4bcFoyRx1Z8Ne/DVHMqc15InC/W18Ju1VgDSl2yRKNJHhNmr
yYBQKSlL+XvSHtpKVg+F783X4ioPYC3+le0ubnJK0FEThf2SRW191Lr/9HBKlqG+
z5GVgNi6zmgB+h4tiLzU
=bdIg
-----END PGP SIGNATURE-----

--qIJsvadShJQco67wOGKOOOMHAKMmHcJg4--
