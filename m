From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 28 Feb 2014 16:15:05 +0000
Subject: Re: [PATCH 4/9] Doc/DT: Add DT binding documentation for HDMI Connector
Message-Id: <5310B609.1010105@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wO22fJMtX5rTcijmJOjQ2EpDMNFt4x0GI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-5-git-send-email-tomi.valkeinen@ti.com>
 <20140228160612.GR21483@n2100.arm.linux.org.uk>
In-Reply-To: <20140228160612.GR21483@n2100.arm.linux.org.uk>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--wO22fJMtX5rTcijmJOjQ2EpDMNFt4x0GI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28/02/14 18:06, Russell King - ARM Linux wrote:

>> +hdmi0: connector@1 {
>> +	compatible =3D "hdmi-connector";
>> +	label =3D "hdmi";
>> +
>> +	hdmi_connector_in: endpoint {
>> +		remote-endpoint =3D <&tpd12s015_out>;
>> +	};
>> +};
>=20
> It seems rather weird to have DVI connectors having an optional I2C
> property, but HDMI (which augments DVI) not having that as at least an
> optional property.

I have added only the properties that I have used. I did think about the
i2c for HDMI also, but thought that I don't use it, and so can't test
it, and so I could well create a bad binding.

And, as I don't see any issue in adding it later, when someone uses it,
I decided to leave it out.

> I can quite well see the iMX HDMI support needing an i2c bus here.
>=20
> Also, HDMI has two connector standards - type A and type B, much like
> the single vs dual link of DVI.  Again, DRM exposes this to userspace.

True, but isn't that just a form factor? No functional differences? But
I agree, we can add the two types here also to the compatible string.

 Tomi




--wO22fJMtX5rTcijmJOjQ2EpDMNFt4x0GI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTELYJAAoJEPo9qoy8lh71YC4QAJqARdB7SNHo0V9hyiiW04Un
BZimno0VM9+E1oR4gs3B4C6I/XCuhf0iq4JUoygwWvqKNUAAn71BnbVZS95Bqo7T
oC0x3m2WIR+AVeHN6qmS3nURlB8/ajNcJfHYOHvukYJUIttVzet1hGG4Cf7so4NE
3Lxr22eWsr+tWiqPTzkrRd2nX3e6LCevh8vyTiKh5lcB01vgCF56pPPTVmWQlYnX
TnmZbzUm+R7WHYmyy70y6Favl/fNXrAgMhXdXd6zXiDomcxkslZwgGwaNkwO+bFo
zWMt7mVm/gN9DeIu+g9afLwd0i0hlQ08AOAUkqmtCXrmjGdJKBqHAPYrW3cq+tka
HdPttrVNRzNGdEwAIkrAi2zU9EizKc9cKmijT0txy4pn8YojQH8e73qvMMP9th1l
rJxZneEwP4CoX7nd/sS0Ip9s0UuOQv6JRYTMITQ7wiOGl8pkRqtyJ1wSUR7xSSX1
h4C/0/Fta1qVA0DCkiX5bEly4FcdFo/hSI4jEVVve8JTL7p7D8HG5H7WQHrCfgOm
NPQRfj1f22wsTpCyxs1lsZfs376A6G43Q1dvjwsKaA2cSklw3hLAtKEVOYX62nb/
ITp/WPlcjZqvcQDLAboLi4wjTW64wu/cVTGNgi/ykCmYoTxdXnSW0RJc2n20/2s2
r9UJi0TGP5jGNTBwCLYB
=n3+l
-----END PGP SIGNATURE-----

--wO22fJMtX5rTcijmJOjQ2EpDMNFt4x0GI--
