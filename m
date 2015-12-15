From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 15 Dec 2015 12:53:24 +0000
Subject: Re: [PATCH 1/2] video:omap2:dss: fix timings for VENC to match what omapdrm expects
Message-Id: <56700D44.9090100@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="rDqGeTDugsOv0hFqEdQcn49XIh3vInNfK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1447410543.git.hns@goldelico.com>
 <20ebf7491377ccba18c734c22ae9f361d7fdc165.1447410544.git.hns@goldelico.com>
 <5667E3D0.8010600@ti.com>
 <5BB301DB-5429-422E-B672-E7A508441C45@goldelico.com>
In-Reply-To: <5BB301DB-5429-422E-B672-E7A508441C45@goldelico.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, gta04-owner@goldelico.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

--rDqGeTDugsOv0hFqEdQcn49XIh3vInNfK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 13/12/15 20:41, H. Nikolaus Schaller wrote:

> Great that you did find the real reason of the problem.
>=20
> I have tested it on the GTA04 and it also works.
>=20
> Will the patches arrive in 4.5?

4.4, I hope.

 Tomi


--rDqGeTDugsOv0hFqEdQcn49XIh3vInNfK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcA1EAAoJEPo9qoy8lh71KKIP/0RfkcDhQKcpS0iv4ScZA7Aq
w82/MlC3d+Tu76Yv3uFAcE1zIZVgDs1+5oyVgi9cWnNdn++FHJi+iOgG80dymVE0
3ZqYbd1V5085UIuyxwoeZvziVxCctduXVQMPsHPA2XIULFOu065vECx/lT/BAJaf
323Au7fLuyPRWJT9GjjwfhpCI0XmptKp8SkXixRKVKUYOfhohLaK6GqT3aVMpmLc
pEH9Gcf0zYplglIgHsM10JEHmxny/YbNN7JC6R/QoB9Lb3MsNQ6qXDk0CbOTIRsd
+jAY5aycXAxoUFfcjSLCDyavA7uboKakH7Q9BdOs849aHZ/oa7MbJf11fbeuN07B
PFlFiQMiLC2zl4P/GXd0aYBrhGyR/x22+O5JHQP4eGD/2noVbRP6s5t9jAfHJ+jh
KNe8zYxZJdT0WoHdZMCVdXsvGMictMbuTV4z/BzG4FXIFZGjQEHJWYz5A20yaMDS
5gix0MPtS9kDfhDrEuxxZxx0tYDYOmA/OYC5VoMQbjKoOjG9QPi8BFXdZuce0W+x
ImpuAfI4oMokg3xmzKcTSsGGhOF2PPafeLmFMhSH9AyO8BBG+uy+ytxJMXi/9PWE
TEE73ikCGe+egZp/ECsAXPm9iI7IwB5y3gnnO7LHEMamZBp0AYTVSa6vsC/vM5CQ
z37yEwAXH2ylaVU6sR/L
=l3Ap
-----END PGP SIGNATURE-----

--rDqGeTDugsOv0hFqEdQcn49XIh3vInNfK--
