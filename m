From: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Fri, 17 Nov 2006 01:07:58 -0500
Message-ID: <20061117060758.GB25413@shaftnet.org>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <1163555308.5940.177.camel@localhost.localdomain> <200611151109.06956.rjw@sisk.pl> <200611162317.30880.chrmhoffmann@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754939AbWKQGFU@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200611162317.30880.chrmhoffmann@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
To: Christian Hoffmann <chrmhoffmann@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net, Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2006 at 11:17:26PM +0100, Christian Hoffmann wrote:
> Ok, I did that and the machine resumes OK. Now I have the impression that=
=20
> accessing the rinfo struct here:

Can you try this updated patch? =20

  http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.19-v7-WIP1.diff

Changes from v6b (which you were using)

  * A few PPC-related fixes and other cleanups from BenH
  * Rewrote the suspend/resume code to use standard=20
    pci_save_state/pci_restore_state/pci_set_power_state calls instead=20
    of the manual saving and twiddling of PCI registers.

This power management code change is very much of an experiment -- it's=20
certianly possible there's a good reason to do it manually, but I=20
suspect it's just because that code is old.

Let me know if this is an improvement.
=20
 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org	=20
Melbourne, FL                          ^^ (mail/jabber/gtalk) ^^
Quidquid latine dictum sit, altum viditur.          ICQ: 1318344


--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFFXVG+PuLgii2759ARArE4AJ4n5jAzh42VnditrD/nGyYRp04DOQCfTc7x
4Zh8WCCBNc9DUvNexWGxA8M=
=MHp/
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
