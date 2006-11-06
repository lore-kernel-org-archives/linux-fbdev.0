From: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: radeonfb: Add ATOM BIOS parsing (rebased
	patch)
Date: Mon, 6 Nov 2006 09:17:19 -0500
Message-ID: <20061106141719.GA28143@shaftnet.org>
References: <20060905153713.GA22789@shaftnet.org>
	<20061101213346.2d3bb82f.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1894826363=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gh6zs-0006Bw-Df for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Nov 2006 08:06:52 -0800
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]
	helo=shaft.shaftnet.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gh6zm-0008Rd-UC
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Nov 2006 08:06:52 -0800
In-Reply-To: <20061101213346.2d3bb82f.akpm@osdl.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>


--===============1894826363==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2006 at 09:33:46PM -0800, Andrew Morton wrote:
> > From: Stuffed Crust <pizza@shaftnet.org>
> > ...
> > Signed-Off-By:  Solomon Peachy <pizza@shaftnet.org>
>=20
> Problem.  We've decided to not take contributions from
> anonymous/pseudonymous contributors, as it weakens the intent of the
> Developer's Certificate of Origin.  I don't think either of those are your
> real name ;)  Sorry.

The former is what I've used as a handle for um, eight years or so now,
but the latter is what it says on my passport.  Really. =20

The first hundred links (of over 30K) that googling my name link back to
me; I stopped counting after that.  These links go back as far as '98
and include contributions I've made to half a dozen FOSS projects, my
Advodato user page (with its trust metrics), DaveM telling me off a
couple of times on lkml, my employer (AbsoluteValue Systems of
linux-wlan[-ng] "fame"), and my alma matter (Georgia Tech).=20

If you finger me I even have full contact information published,
complete with the phone number of my employer (although Google will
provide that too).

I realize that none of this technically establishes *my* identity, but I
think the only mutual aquaintance I've met in person is Jean Torrilhes,=20
and he didn't check my ID either.  :)

So.  Probably the most expedient manner of establishing I am who google
and I say I am is by calling my employer at +1(321)259-0737, ask my boss
(Mark Mathews) about my credentials, then you can then put me on the
line to establish I know about this conversation.  Or I/we can call you.

I could fax you a copy of my ID or something, but that would only tell=20
you that I may have l33t photoshop skillz... :)  I'm also not in the=20
local phone book (I ditched the land line two years ago) so you can't go=20
that route.

(Gee, remote identity verification is a difficult problem, isn't it?  :)

> If you can sort that out then please ensure that future patches are
> prepared in `patch -p1' form, as per

I did it the way I did to avoid diffing two complete kernel trees (the=20
editor was running on a much slower machine than the test boxes.. the=20
extensive reboot-required nature of fbdev development is not condusive=20
to editor state)

The current version of the patch (v6a) is linked to kernel bugzilla
#6215, but it doesn't have the "correct" format either, but that's a=20
trivial thing to fix.

Is there anything else you'd like me to do to this patch before you
take it into -mm?  I can break it down a little bit, but unfortunately
the bulk of it is fairly atomic (no pun intended) and nearly all of the
changes would need to be applied at once, broken down or not.

I also don't know if this patch will apply to (or work on) 2.6.19-rc,=20
but that should be a straightforward merge.  I'm assuming you'd like me=20
to sort that out too.

Cheers,

 - Solomon (really)
--=20
Solomon Peachy        		       pizza at shaftnet dot org	=20
Melbourne, FL                          ^^ (mail/jabber/gtalk) ^^
Quidquid latine dictum sit, altum viditur.          ICQ: 1318344


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFFT0PvPuLgii2759ARAhZRAJwJkqEmwDcBFE+xcIkiPCivbcHYpACcCKXu
LeYKt8GUaq3bTbHdqyZP4c4=
=PVw3
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--


--===============1894826363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1894826363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1894826363==--
