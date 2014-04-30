From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 30 Apr 2014 11:14:36 +0000
Subject: Re: [PATCH v2 1/3] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <5360DB1C.3020400@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="B8Crb3aL7uBrVe90bvQ2FTCkp1vhgPfWR"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--B8Crb3aL7uBrVe90bvQ2FTCkp1vhgPfWR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24/04/14 19:35, Alexander Shiyan wrote:

>> The right way to do it is, as I wrote above, by gradually changing the=

>> old driver with a patch series. And my question is, why not do it that=

>> way? Then it would be possible to review the patches one by one, seein=
g
>> what has changed.
>=20
> "gradually changing"...
> I repeat that this is not an old modified driver, but written new.

Yes, I understand that. Again, my question is, why didn't you modify the
old driver? That's how things should normally be done. Instead, you made
a totally new one, making proper review against the old driver impossible=
=2E

> if you imagine a new file as a diff to the old, this can be clearly see=
n.
>=20
> There is no reason to waste time on a series of changes since I
> can not even check these changes on real hardware, but only in the
> last stage when the driver will be the current version.

Hmm what? So is the old driver totally broken, and cannot be used at the
moment? Or why you can't test on real hardware?

Note that I don't know anything about the fb hardware in question, nor
the driver. Maybe there's a valid reason to write a new driver from
scratch. But there very rarely is.

And "because I already wrote a new driver, and it's a waste of time for
me to throw away my work and patch the old one", is not a very good reaso=
n.

 Tomi



--B8Crb3aL7uBrVe90bvQ2FTCkp1vhgPfWR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTYNscAAoJEPo9qoy8lh71CLsP/1kG2EgxGN+2XdNbY3gE1j7w
Ei1dMlMkvEokhbrBvo280/W4PXatT8rIlBgAc4rcWmdstWQD8fzFTjJD0Av1Yc2g
+rjq15+lT9JaFj0aPaj5cs+G7jhUwvwG8bBietia9TQHUPseYjlGV0c5fTGC05J4
9ZIo6j0ZB2O1oB/DCwXAxmMkpEnnCS+jMEQ4hGch/64GK7TGI+DzAvaYdLaKVv2B
9A+jFvesaAVweBtcefzCWOvcsqd94yfLQTGY2puHg6YgpdthrJBo5auwBp5Jm1PM
HmdZ31sOsyZBTLYITqLZruuAnly+ryQhg2fX6zbki03jAch86lFPZb23xsRIfjRq
Z0K62Mr9LFP4sOlLMidX8+HSABB3bulCfTtNYxe2qSteQm7Uu+jYX9HBRy38xg0H
OvJ0mkzNyemZ7LyjQt4QicA2CWXA4Z5nUlbdWTJWUWMp8bHSPKD4JOkjTLc15reK
BspZrI9lj54yDf453n5J03/nvf/82DpD3Puvk51k1flYugRpuOQSmx98tXQVUQQJ
Ld4thczMgDJXH7SMO5HHQpd7g4OeXWjRMtbnBFLniqufCG9MvK7gTQUobwrLG5OU
vFnMpgBa44TjPTK+TF8A1WWN+yACH9yBfziLOl6szdNMlDJJBEJuyv8ATCFmoarf
PSWUZH0ozukIwgRQSMyY
=QqJG
-----END PGP SIGNATURE-----

--B8Crb3aL7uBrVe90bvQ2FTCkp1vhgPfWR--
