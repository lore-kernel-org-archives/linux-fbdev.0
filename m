From: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: [patch] [radeonfb] Radeon M26 and ATOM bios support (take 4)
Date: Tue, 28 Feb 2006 22:33:38 -0500
Message-ID: <20060301033338.GA20460@shaftnet.org>
References: <20060103204404.GA23313@shaftnet.org> <1139952530.7903.31.camel@localhost.localdomain> <20060222221916.GB17359@shaftnet.org> <20060223060939.GA27224@shaftnet.org> <1140677458.8264.24.camel@localhost.localdomain> <20060223223619.GA14458@shaftnet.org> <1140736521.8264.49.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FEIUn-00012h-FH
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 28 Feb 2006 19:59:25 -0800
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86] helo=shaft.shaftnet.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FEIUm-0007k2-BH
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 28 Feb 2006 19:59:25 -0800
Content-Disposition: inline
In-Reply-To: <1140736521.8264.49.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2006 at 10:15:21AM +1100, Benjamin Herrenschmidt wrote:
> > I'm unsure how to best to proceed from here, so this patch is it until=
=20
> > I get some more directed feedback. =20
>=20
> I'll review properly next week.

I've since completely gutted the radeon_probe_screens code, and now it=20
takes advantage of (and relies heavily on) the connector table stuffs. =20
It's far, far cleaner now, yay!  =20

I basically have two chunks of remaining code to write:

1) The OpenFirmware stuff, which basically requires some re-jiggering of=20
   arguments passed in and return codes. =20
2) User-specified layout code isn't smart enough to try the secondary=20
   connectors if the primary connectors don't have anything connected.
   (This could be lessened by extending the syntax to explicitly state=20
    CRT,CRT2,DFP,DFP2,etc..)

Then there's the big open question of how we should allow the user
to override the connector table, in case we mis-detect or don't have a
table to begin with.  If we have DDC enabled we can build a=20
connector table by probing all DDC ports, using the existing logic.=20

Thoughts?

(This work builds on the radeon-atom-4 patch, and is definately in the=20
 "heavily experimental" stage.  I'll post a patch once I have time to=20
 clean it up and fix the first two points)

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL
Quidquid latine dictum sit, altum viditur.

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFEBRYSPuLgii2759ARAmVWAJ0Zjj4GifFqgSsNGtdcfsc++ASeHQCcChgJ
IQ1pQTv0J8FOh6sg2cCHOEM=
=cwzf
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
