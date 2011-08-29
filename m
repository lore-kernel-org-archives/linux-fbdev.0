From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 29 Aug 2011 23:43:56 +0000
Subject: Re: linux-next tree addition request (fbdev)
Message-Id: <20110830094356.25718bea5e25f0d2c48e0af7@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Tue__30_Aug_2011_09_43_56_+1000_tvXr.ONz2jMyupUY"
List-Id: <linux-fbdev.vger.kernel.org>
References: <4E54FF5E.5050308@gmx.de>
In-Reply-To: <4E54FF5E.5050308@gmx.de>
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-next@vger.kernel.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>

--Signature=_Tue__30_Aug_2011_09_43_56_+1000_tvXr.ONz2jMyupUY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Wed, 24 Aug 2011 13:40:46 +0000 Florian Tobias Schandinat <FlorianSchand=
inat@gmx.de> wrote:
>
> can you please add
>=20
>     git://github.com/schandinat/linux-2.6.git fbdev-next
>=20
> to linux-next. It collects patches for the frame buffer subsystem.
> Can you please add the linux-fbdev@vger.kernel.org mailing list as additi=
onal
> contact for warnings/errors/problems?
>=20
> You probably want to drop Paul's fbdev branches as they contain some outd=
ated
> patches that will conflict with the newer versions.

I have replced Paul;s fbdev tree with yours and dropped his fbdev-current t=
ree.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.

--Signature=_Tue__30_Aug_2011_09_43_56_+1000_tvXr.ONz2jMyupUY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOXCQ8AAoJEDMEi1NhKgbsikMH/jTEffmyeGKDcLzpB8+NVqq4
L3LCzLQzTa35ZPqjqeUjryGVecEaxKOSahbgM4UWO2rwTJTTeGC4nGnlq5HS2rDn
IBHp/BH70RG4FIkOqvgeUSXjZ9OuPCZwgubvhc9Q0p1+w/sH9vAx3mtTmcEEab92
qmmCU/O56dGDIA4a8AKvX3N5qmg+zLRr2P1c8SHUH9pUf+THSKfyhcoSIClVs8vy
TXjdTtcdeMEJyqzIwbrt9E3UanPGEPHTU3tFFQuAaWI6V93yhjMcatiNuzQRhz0W
zjw3/pJpI/IMYe5UjKAcXN1eNjF/7ZCNjPFfrsMIFArjX9Ntz6pKfIWIiXBRBys=
=ktAk
-----END PGP SIGNATURE-----

--Signature=_Tue__30_Aug_2011_09_43_56_+1000_tvXr.ONz2jMyupUY--
