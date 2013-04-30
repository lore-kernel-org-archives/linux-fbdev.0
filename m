From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Apr 2013 07:28:35 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <517F72A3.6010009@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2UHKKHCHSTVEIUVTHVASA"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <20130408171637.98b5ad1f867bcbda883af68b@linux-foundation.org>
 <2569832.XQDrhUGNaI@avalon> <2863648.BDvrAG5uPk@flatron>
In-Reply-To: <2863648.BDvrAG5uPk@flatron>
To: linux-arm-kernel@lists.infradead.org

------enig2UHKKHCHSTVEIUVTHVASA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/30/2013 12:15 AM, Tomasz Figa wrote:

> Well, there is also at least one legitimate use case for this driver.
>=20
> I believe there exist embedded devices on which there is no need to=20
> dynamically control the framebuffer. It needs one time initialization, =

> usually in bootloader, and then it is used as is, using constant=20
> parameters as long as the system is running.
>=20
> I doubt there is a need for any KMS (or any other control) driver for s=
uch=20
> devices - dumb framebuffer driver would be everything needed in such ca=
se.

Isn't there usually the need to power off the hardware when
blanking/suspending?

 Tomi



------enig2UHKKHCHSTVEIUVTHVASA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRf3KjAAoJEPo9qoy8lh71W4AP+wfd4jG+Gmk3CFBu+XdV9xpV
hmmbNpN+PLeKVU/+tPZYq/eswVlnwvuEOuOpftstcGqlURP9MUxRKyrnKGvWJjQ+
zoAvM7oIOHzQmKNW39OJQbJdmCXb0si44lJXSvD/4qa311E107eHCOKGTgG0DU5v
r7pVkTaiZ7aft8ZReGyFWvE5W4LV2OXVroXVSM5kdfjDOvPT7VBk72cpb0PI3zH7
FA05XmEzNSDcOBrzTfIpwY/2zuQ2fd6KXU6NX64wSkEjasBLIAuooW/8wrqmDM+O
p/wuL8uFf8M/hgV9H8JOpyLyMHc0n8j8vLyupO2cpSm23mdtqT0F8zjVAKx1MOsG
3RKp6rXwI7Yapfe79tPny9n9n1N6t4hkp6aLWowpLxOSDcEQHmIgqJKMd93IuchF
Hy29nwG5HZlus7AoNeqlGjtDj002Ii14wE5ihJKoodHcxq9lcckrNW/0L6N8OgCa
aTSD69HUtoeKIw4yJqrfPyi5qgmg/QhOEM+JGSn6GfDmWPJa9LeyBaUgnb3kWtDn
vsb4ZTNUNXl3O4vUJM+xRllP6w3rbjcMDhn4f4wtuxkALrSAy1mNR1G2LorXo3Mb
ATku6/uBykIcegF9QhFo4GZ+JzV5EAHeAd0lk98o5nRmEmum/wmVVRCyUOTTwFAa
3MKmm20xNQeKNYLNkI+m
=n47N
-----END PGP SIGNATURE-----

------enig2UHKKHCHSTVEIUVTHVASA--
