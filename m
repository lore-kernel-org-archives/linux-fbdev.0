From: Ondrej Zajicek <santiago@mail.cz>
Subject: Re: Two bugs in fbcon?
Date: Tue, 23 May 2006 23:11:05 +0200
Message-ID: <20060523211105.GA2190@localhost.localdomain>
References: <20060515210310.GA1199@localhost.localdomain> <446E630E.9060500@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fie9v-00007u-6F
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 14:11:19 -0700
Received: from smtp1.kolej.mff.cuni.cz ([195.113.24.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Fie9t-0006OO-DE
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 14:11:19 -0700
Received: from localhost.localdomain (feanorr.kolej.mff.cuni.cz [195.113.26.209])
	by smtp1.kolej.mff.cuni.cz (8.13.1/8.13.1) with ESMTP id k4NLB8BP092797
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 May 2006 23:11:09 +0200 (CEST)
	(envelope-from zajio1am@artax.karlin.mff.cuni.cz)
Received: from santiago by localhost.localdomain with local (Exim 4.50)
	id 1Fie9h-0000eF-9q
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 23:11:05 +0200
Content-Disposition: inline
In-Reply-To: <446E630E.9060500@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 20, 2006 at 08:30:06AM +0800, Antonino A. Daplas wrote:
> Ondrej Zajicek wrote:
> > Now second strangeness - I am still on vt0 (immediately after modprobe =
fbcon),
> > but during calls to bitblit.c/bit_cursor display structure associated w=
ith
> > vt3 is used (in bitblit.c:244 - ops->p). Combined with previous strange=
ness
> > (bad vrows values in vt1-vt3) i get cursor visible on bad row.
>=20
> Might be fixed in Linus's latest git tree.  Try applying this changeset:
>=20
> http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommitdiff;h=3D1a37d5f51020b9967d4b4094f6d627d0873a6469
>=20
> Tony

Yes, this corrects it. Thank you.

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.ne=
tlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iEYEARECAAYFAkRzemgACgkQw1GB2RHercOs5gCfSB8HVAM2yp5zezsYqQKRIQxr
eZkAnjussUKiffiRBz6qHFL8h2YF6zAm
=jscn
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
