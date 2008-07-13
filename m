From: Mikhail Gusarov <dottedmag@dottedmag.net>
Subject: Re: [PATCH] eink_apollofb: new driver for
	Apollo eInk controller.
Date: Sun, 13 Jul 2008 19:20:23 +0700
Message-ID: <87iqvaasc8.fsf@frontier.dottedmag.net>
References: <1215787849-25580-1-git-send-email-jekhor@gmail.com>
	<1215788071-25764-1-git-send-email-jekhor@gmail.com>
	<1215788071-25764-2-git-send-email-jekhor@gmail.com>
	<20080712192013.1fb9519b.akpm@linux-foundation.org>
	<45a44e480807122002uaf7e452n563c42e186c944a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1699459122=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KI0Z4-0001bL-67 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 13 Jul 2008 05:20:30 -0700
Received: from burger.dottedmag.net ([212.75.37.82] helo=dottedmag.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KI0Z2-0005Ib-OW
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 13 Jul 2008 05:20:30 -0700
In-Reply-To: <45a44e480807122002uaf7e452n563c42e186c944a1@mail.gmail.com>
	(Jaya Kumar's message of "Sun, 13 Jul 2008 11:02:29 +0800")
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, linux-fbdev-devel@lists.sourceforge.net

--===============1699459122==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Transfer-Encoding: quoted-printable

Twas brillig at 11:02:29 13.07.2008 UTC+08 when jayakumar.lkml@gmail.com di=
d gyre and gimble:

 JK> However, I should point out that hecubafb is a driver for this same
 JK> apollo controller.

AFAICT from the diff, eink_apollofb already includes all the features of
hecubafb, so that would be just renaming. Is it worth it?

=2D-=20

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIefMHvse/O6JvVMgRAh09AJ4u2QUGhooCYN0QL1skWIsaPSP9qgCfasEo
T1wtPf54M/F94vZqlGFaPrw=
=AbAm
-----END PGP SIGNATURE-----
--=-=-=--


--===============1699459122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============1699459122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1699459122==--
