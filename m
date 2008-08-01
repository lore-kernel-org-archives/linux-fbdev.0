From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH 13/13] viafb: via_utility.c,
	via_utility.h, vt1636.c, vt1636.h
Date: Fri, 1 Aug 2008 15:23:16 +0200
Message-ID: <20080801132316.GA2784@prithivi.gnumonks.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E78BE@exchtp03.taipei.via.com.tw>
	<20080630104407.6adf59ab@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0457656379=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KP3pv-0007uX-SO for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 16:15:04 -0700
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KP3pt-0005fm-62
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 16:15:02 -0700
In-Reply-To: <20080630104407.6adf59ab@lxorguk.ukuu.org.uk>
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
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: JosephChan@via.com.tw, linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org


--===============0457656379==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2008 at 10:44:07AM +0100, Alan Cox wrote:

> I think at this point however the code is in a state where it would be
> more productive to merge it and then fix up the remaining smaller details
> than keep going round back to VIA to change it internally and return.

Well, I'm obviously not having any unbiased opinion on this anymore...
=2E.. but have a vital interest in getting this driver merged ;)

Joseph: Can you please give me an update about what the current state
of this driver merge is?  This message is the last one that I can find
ont this subject on linux-fbdev-devel, and it's already one month old.

Joseph: If there was any further work on this since your last
13-patch-posting in June, can you please provide me with the latest
driver patchset?  I'd be happy to help in cleaning this further up and
finally getting it mainline.

Thanks to everyone involved,
--=20
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFIkw5EXaXGVTD0i/8RAvZ+AKCkUzm1m+dsYSy2bVd0Eu+Lvi5rEgCfVmID
q8P8sHevDkvHFqf86PAUn+4=
=JwZW
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--


--===============0457656379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0457656379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0457656379==--
