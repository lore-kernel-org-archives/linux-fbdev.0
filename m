From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: Re: [forum] Re: Announcement: Modification to the base XFree86(TM) license.
Date: Sun, 1 Feb 2004 16:33:35 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040201223335.GB16019@dbz.icequake.net>
References: <20040131113753.GA19133@iliana> <Pine.LNX.4.44.0401311258330.4585-100000@ard.bishopscourt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AnQ9p-0003Ja-SR
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 Feb 2004 14:33:37 -0800
Received: from 216-229-91-229-empty.fidnet.com
	([216.229.91.229] helo=mail.icequake.net ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AnQ9p-0004eX-DH
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 Feb 2004 14:33:37 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401311258330.4585-100000@ard.bishopscourt>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: devel@xfree86.org
Cc: linux-fbdev-devel@lists.sourceforge.net, forum@xfree86.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Sat, Jan 31, 2004 at 01:06:23PM +0000, Andrew C Aitchison wrote:
> > And, have you asked the mgafb driver author about this ?
> >=20
> > You can hardly complain about lack of back traffic if you didn't ask him
> > about it, and if you did, it would be interesting to this discussion to
> > know what the problems where.
>=20
> "The Author" ?
> This is open source code; there may be 27 authors of the relevant file.
> In XFree86 code I wouldn't know how to find the author of a file without
> looking at that file. My {limited ,mis}understanding of clean room coding=
=20
> makes me wary of reading any source unless I know that its licence will=
=20
> allow me to do what I wish.

The only authors that legally matter are the ones listed in the
copyright notices.  There are three copyright notices in the matroxfb
stuff: one is Petr, another is Gerd Knorr and the other is Matrox.  I'm
sure Petr has a pretty clear idea what he wrote, and I doubt Gerd would
get an attitude with you either over anything he did.  Since you haven't
even inquired about it, you don't have much to complain about as I see
it.

> OK. So I've probably been paranoid and lazy, but if the fbdev licence=20
> had been compatible with the XFree86 one, I would have done the work.
> As it is the bar was raised high enough to stop me.

Or maybe the license incompatibility was simply a convenient way to cop
out of doing some work?

> > > So, for one developer at least, the reason there has been no traffic
> > > from fbdev to XFree86 is *directly* because of the licence issue.

You can't copy and paste code.  You _can_ rewrite code.  Hardware
interfaces, trivial routines, and problems for which there exist only one
or a few obvious ways of solving them are all examples of where
copyright does not apply.  Porting any code from fbdev to a XFree86
driver *will* involve substantial rewriting.  I know this because I'm
currently doing it for the mga driver.

> > Yeah, but again, was it so because of a definite will on the fbdev
> > authors part, or because you didn't ask him ?
>=20
> Isn't the aim of open source licences is to allow people to use the code
> without tracking down the author and obtaining permission ?

No.  The aim of open source licenses is to allow people to use the code
_under the terms the author chose_ without tracking down the author and
obtaining extra permissions.

> I can do that with closed source.

I don't see how you have greater freedom with closed source licenses,
but feel free to elaborate.

--=20
Ryan Underwood, <nemesis@icequake.net>

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAHX6/IonHnh+67jkRAtv+AJ9hKM4vdrzfdDuPmq0hsvGtDo8BhACgiw7X
CDeOACy/9wv4sDdne0jkXaQ=
=hXZF
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
