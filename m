From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] kyrofb support
Date: Tue, 13 Jan 2004 21:28:16 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040114022816.GA9990@linux-sh.org>
References: <20040114013306.GB9515@linux-sh.org> <20040113180926.5fdb0824.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Agalc-00011K-N0
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 18:28:24 -0800
Received: from smtp.golden.net ([199.166.210.31] helo=newsmtp.golden.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Agalc-0005AX-9w
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 18:28:24 -0800
Content-Disposition: inline
In-Reply-To: <20040113180926.5fdb0824.akpm@osdl.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2004 at 06:09:26PM -0800, Andrew Morton wrote:
> Why is kyro_modedb[] and the code which touches it under #ifdef MODULE?
>=20
No particular reason, really. I hadn't been following some of the recent fb=
dev
changes, so I wasn't sure if this was necessary or not (I was using tdfxfb =
as
a reference when tracking API changes, and noticed that it did the #ifdef
MODULE stuff which it never did earlier). I'll happily drop the #ifdef MODU=
LE
bits if this isn't necessary. James?

> kyrofb_pci_tbl[] cannot be marked __devinitdata - it is linked into
> system-wide PCI tables and will be walked at various times in the kernel.=
=20
> If it is in a discarded section the kernel oopses.
>=20
Okay, I'll remove that.

> Shouldn't the module_exit(kyrofb_exit); be inside #ifdef MODULE too?
>=20
Yes, I suppose.

>=20
> In general, what are the fbdev drivers doing here btw?  It's very strange
> that some core file (fbmem.c) has to "know" about individual card drivers=
.=20
> It should be sufficient for the driver to just register itself with the c=
ore
> at the drivers's module_init() time.
>=20
This is done for device ordering as far as I recall. Devices listed first on
the command line are numbered first, with the rest coming up in the order t=
hat
they're listed in fb_drivers[].

I had some patches against this awhile ago that redid some of this, getting
rid of fb_drivers[], putting ordered devices in a list and logically assign=
ing
IDs based off of that, etc. but still letting the drivers come up on their =
own
through module_init(). I was planning on working on this for 2.7, as I didn=
't
have enough time under 2.5.

> Sigh.  Too late to fix that now I guess.

I'll send you another patch for this as soon as I hear back from James or
someone else about the modedb / #ifdef MODULE stuff, I don't see any reason
why it would be required, though.


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFABKlA1K+teJFxZ9wRAgB+AJ9RaSHwjQ0gF7zuYBXUhgP09PQm1QCeLlHf
KE+kW+TLhedGXpXIj4TMkOU=
=hijw
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
