From: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005 with radeonfb enabled
Date: Fri, 17 Nov 2006 10:41:19 -0500
Message-ID: <20061117154119.GC5158@shaftnet.org>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	<1163555308.5940.177.camel@localhost.localdomain>
	<200611151109.06956.rjw@sisk.pl>
	<200611162317.30880.chrmhoffmann@gmail.com>
	<20061117060758.GB25413@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0196268889=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gl5n2-0004CW-9Y for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 07:38:04 -0800
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]
	helo=shaft.shaftnet.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gl5n0-0002Jg-N5
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 07:38:04 -0800
In-Reply-To: <20061117060758.GB25413@shaftnet.org>
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
To: Christian Hoffmann <chrmhoffmann@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net, Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>


--===============0196268889==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2006 at 01:07:58AM -0500, Stuffed Crust wrote:
>   http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.19-v7-WIP1.diff

 http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.19-v7-WIP2.diff

This incorporates the latest round of BenH's fixes and changes, but=20
backs out the PCI suspend changes, which need independent review and testin=
g. =20

(BenH has promised a little more work before he's ready to sign off,=20
 hence the -WIP2 designation)

The following patch contains a rewrite of radeonfb's suspend/resume code=20
to use standard PCI subsystem calls.  It applies to 2.6.19-rc6 and also=20
on top of the v7-WIP2 patch.

 http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.19-suspend.diff

Christian, if you could see if the latter patch (on top of the -v6b or=20
-WIP2 patches) makes a difference for your suspend/resume problems..

And with these patches, I'm going to drop offline for a camping trip=20
over the weekend.  I'll pick this stuff back up on Monday.

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org	=20
Melbourne, FL                          ^^ (mail/jabber/gtalk) ^^
Quidquid latine dictum sit, altum viditur.          ICQ: 1318344


--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFFXdgfPuLgii2759ARAtSnAKDLVuyrsoNUwJGrqXJypsG3QUQqvwCfc+z1
Bhp57NngZh0EmG9N/RPmf2U=
=VpPC
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--


--===============0196268889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0196268889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0196268889==--
