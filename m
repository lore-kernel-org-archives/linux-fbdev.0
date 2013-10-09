From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Oct 2013 10:28:02 +0000
Subject: Re: [PATCH 3/3] video: xilinxfb: Simplify error path
Message-Id: <52552FB2.80903@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LdPAXweNwjqsNWetTeTOQIq9nTQOPr573"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7016a90750626ba866dddc6f85cfdd71943f6891.1378965270.git.michal.simek@xilinx.com> <940bbdfc5c67282ab461b9c82b55f18fc34c959d.1378965270.git.michal.simek@xilinx.com> <5236D4BD.9050707@ti.com> <5236DE60.3020901@monstr.eu> <5236DEBF.7070003@ti.com> <52496921.9080603@monstr.eu> <52551BAB.40805@ti.com> <52552F2E.7080007@monstr.eu>
In-Reply-To: <52552F2E.7080007@monstr.eu>
To: monstr@monstr.eu
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org

--LdPAXweNwjqsNWetTeTOQIq9nTQOPr573
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/10/13 13:25, Michal Simek wrote:

>> This series does not apply. Can you rebase on top of linux-next, and r=
esend?
>=20
> Do you mean Stephen Rothwell linux-next or any your linux-next branch?
> No problem to do so if you send me link to the repo.

Either one, my for-next is in Stephen's tree:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git for-next

 Tomi



--LdPAXweNwjqsNWetTeTOQIq9nTQOPr573
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSVS+yAAoJEPo9qoy8lh71R8YP/A17Lh4jepb+/dW52RkJEDWx
FxN9fxzFar+a25nFTwwd97kqnWSyFGfWF0FI+IFUiu7eQQU9rflX4XM8sibE89RG
OG7kGUCO3bNObh2W8xJQYwmvOzjGV7q8R2MmRqQhILLO5UD1AQYEXYaHuxn4yxCH
mq30EGAxS01kIiGpxpxsTiFI87E7qI8KAUJs5qI+hBwodESM7PAXoJ7T99uSJU3F
z45qNsaDx+Mx4DKNoziwLyO9MoQ//BphzAZuDSLK6azP6Zkb4U+bcr0ZW/RWhDDB
5Pq3T/i6mpUlVPYe9WRi1bwDyFb7Rw80BkCbnLr0/YhdiFAja4FHlUs0QoMl+NkM
vsI8pakVLC5zeFZvnh9DXzUQWEbUHDeVoRgYhsbthBPalQIAmBVU8AOOdrljfEXv
KBoD/8S8T+KU22vB5eaUdK9fIhTeie9fyhv8F5nXp46w6QX3E9Dcf8idSIjT2Ul1
QtOd5EqcnNqwGpClPH4aXliTUcDWzXs2DTZ/T3Kj2EKVO8vcF3/oqbpFJ6EY5TE+
Is0sFfq0CH3WHRZ51/yhj0nOXj/dGnN0jiVe39+8gmmP4EO1CDwg3qZhEuARjWiK
X3bWk6hwg61rQLtx18FOqluGSrlTx/3HT/zh8QBgjiPZTooS2eCONtNSBc9s6j9g
8jWr/aUhXXsSCc0uXNWl
=Q1jq
-----END PGP SIGNATURE-----

--LdPAXweNwjqsNWetTeTOQIq9nTQOPr573--
