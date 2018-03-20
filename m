From: "Keith Packard" <keithp@keithp.com>
Date: Tue, 20 Mar 2018 15:07:27 +0000
Subject: Re: [PATCH] Allow non-desktop displays when not in strict mode
Message-Id: <871sgewztc.fsf@keithp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-fbdev.vger.kernel.org>
References: <5a4c3dab-69ed-6804-ac62-6163754c5786@cnlohr.com>
In-Reply-To: <5a4c3dab-69ed-6804-ac62-6163754c5786@cnlohr.com>
To: Charles Lohr <charles@cnlohr.com>
Cc: David Airlie <airlied@redhat.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Charles Lohr <lohr85@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Charles Lohr <charles@cnlohr.com> writes:

> Considering the lukewarm reception of my last past request and Keith's
> recommendation, I've created and tested a new patch, to bring the
> intended functionality back, only prohibiting non-desktop devices if a
> regular desktop screen is present.
>
> Signed-off-by: Charles Lohr <lohr85@gmail.com>

This seems like a reasonable idea to me.

Reviewed-by: Keith Packard <keithp@keithp.com>

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAlqxI68ACgkQ2yIaaQAA
ABFpXA//aisq1appqc16LCgxZWJwWNet88jOtDDHIJ7Z9vgd2CtgWWQ0LmFsRb3M
ntNhJFLmW9xKq6bzRWk8PSZHrZHt/XsKB/cXwK+rD8PPKEO9NaOOIqtenXxz7dKg
8Zi4zrrQf91+wJp6s/F7Rkll6II2a53mRExZNwqVpqI3VlmBgwMh1oOpuZ1RCKuQ
xfiS7mYMdRMtFvwyP0opRwO6aspKJn6EvxLGPNfrO8Iy3egWJAyuZYoLhMREIplz
gBMUSM8v0SZsDuUjmgNfsxV4OGV4Du9bYiqcJyl/BTB1o/gXC1xbt+xhndgxpzsu
AfQJ9RfKqLW+xHN543ZI36LrbysG9FiYOgS4S/kFsUhOk7uSduMjiqxeytSchk6P
WPAogwfeEMPPY3Lr6KaTCQ57DzbuTEvUXw/Cyv32Xlw6UIPv6Zgppmf0VDEjHBnZ
cADjmvTkHb+1tjzOk8J49jbIZDXes110cjQ6CYyJeVmuyWXZYR9aoqW1cWzxnRFZ
MzBTmh3VgDJVzgM20W2kyGZandvcllUdHRr83DKbpCJoPdY+V2SSaNywOXncGjPq
Xy4N/mmrcN7q8IizBEvIm9x4iBaY8+1sUgAr24xfvnGwfGtc1wRaILX1B9r7aVoD
s46vIAccV9gTIdX9PO+nZ6Brul8M8MzsrFwfPIYtt7mYDurjEL4=
=8QSw
-----END PGP SIGNATURE-----
--=-=-=--
