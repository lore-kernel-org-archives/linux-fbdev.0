From: Mikhail Gusarov <dottedmag@dottedmag.net>
Subject: Re: [RFC 2.6.28 1/2] fbdev: add ability to set
	damage
Date: Tue, 20 Jan 2009 10:21:22 +0600
Message-ID: <8763ka4ngd.fsf@frontier.dottedmag.net>
References: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
	<45a44e480901150153ta1fbe5fk5480dc5630cf1d6b@mail.gmail.com>
	<aec7e5c30901150229g3e262adeje1776fc22cac1d64@mail.gmail.com>
	<45a44e480901150308l63b4ea97rd2fbfe4fa9e2cbb4@mail.gmail.com>
	<aec7e5c30901151909k1374ae65rf52c031e5b25387f@mail.gmail.com>
	<45a44e480901160124g54547437pf5eca85c8ee52be6@mail.gmail.com>
	<aec7e5c30901160308l3f3830c7gc53717ab8cce649e@mail.gmail.com>
	<45a44e480901161414r7f0d0bc4x582c1597d439d116@mail.gmail.com>
	<aec7e5c30901182044x2fbd49f2ve0aa1b433bb4ce14@mail.gmail.com>
	<45a44e480901190715x8de194bwd3c8383207488696@mail.gmail.com>
	<aec7e5c30901192017p44204224w70032c2f367cd5fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4182679358974822822=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dottedmag@dottedmag.net>) id 1LP87M-0004MQ-J0
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 04:21:36 +0000
Received: from burger.dottedmag.net ([212.75.37.82] helo=dottedmag.net)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LP87E-00051T-FO for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 04:21:36 +0000
In-Reply-To: <aec7e5c30901192017p44204224w70032c2f367cd5fc@mail.gmail.com>
	(Magnus Damm's message of "Tue, 20 Jan 2009 13:17:53 +0900")
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

--===============4182679358974822822==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Transfer-Encoding: quoted-printable


Twas brillig at 13:17:53 20.01.2009 UTC+09 when magnus.damm@gmail.com did g=
yre and gimble:

 MD> but I think it's good enough to keep your array of rectangles as
 MD> interface. It's clean and simple.

It also matches some hardware's interfaces -- there are e-ink
controllers which can update specified rectangles on screen, so damage
bitmap is not needed for such controllers at all.

=2D-=20

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl1UUMACgkQvse/O6JvVMhIsgCfUnCvFsdDqK42CeA+ClCmM+Y3
EMkAmQEqwkAKGWPwIKJmi1PXZsVUkcvP
=Xxnv
-----END PGP SIGNATURE-----
--=-=-=--


--===============4182679358974822822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
--===============4182679358974822822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============4182679358974822822==--
