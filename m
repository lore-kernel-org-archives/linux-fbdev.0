From: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Fri, 17 Nov 2006 00:27:55 -0500
Message-ID: <20061117052755.GA23831@shaftnet.org>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <200611151109.06956.rjw@sisk.pl> <200611162317.30880.chrmhoffmann@gmail.com> <200611162344.41622.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1424761AbWKQFZJ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200611162344.41622.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Christian Hoffmann <chrmhoffmann@gmail.com>, Andrew Morton <akpm@osdl.org>, Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2006 at 11:44:40PM +0100, Rafael J. Wysocki wrote:
> I think the call to radeon_restore_pci_cfg(rinfo) causes the problem to h=
appen.

radeonfb is still using its own code for saving and restoring PCI=20
registers; I'm in the process of fixing it up to use proper PCI
subsystem calls.  That will hopefully work better.  =20

It's possible there's a good reason (other than "nobody's ported it over=20
yet") that the radeonfb driver is doing it manually, but I don't know=20
why that would be the case. =20

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org	=20
Melbourne, FL                          ^^ (mail/jabber/gtalk) ^^
Quidquid latine dictum sit, altum viditur.          ICQ: 1318344


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFFXUhbPuLgii2759ARAoM7AJ92AH2t3kpROkjO2Pwtx7sWt5U1xQCgvUx1
T00pEpjZeRpDE3iOB7ZgqWQ=
=a402
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
