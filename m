From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Smart LCD Linux driver
Date: Fri, 2 Jul 2004 13:43:24 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040702114323.GE18841@lug-owl.de>
References: <DC91351678E31E4FB24B551221F507ECB771E4@blr-itp-msg.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgMS1-0007vI-HB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 04:43:29 -0700
Received: from dvmwest.gt.owl.de ([62.52.24.140])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BgMS1-0006sc-0f
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 04:43:29 -0700
Content-Disposition: inline
In-Reply-To: <DC91351678E31E4FB24B551221F507ECB771E4@blr-itp-msg.wipro.com>
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


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-07-02 16:50:44 +0530, kiran.tigadi@wipro.com <kiran.tigadi@wip=
ro.com>
wrote in message <DC91351678E31E4FB24B551221F507ECB771E4@blr-itp-msg.wipro.=
com>:
> Hi,
> =20
> I am working on Smart LCD Linux driver interfaced Asynchronous Display
> controller. I want info in this regard.

Asynchronous display controller? Attached via a serial link (or by other
means), but no shared video RAM?

That's one of the more complicated drivers then... You'd need to prepare
some buffer you can provide to the FB API and poll it for changes, which
you then need to hammer down to your display controller.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA5UpbHb1edYOZ4bsRAjk1AKCFly4J1Yfmuwj3gWkqy3d2QSkHXACZAUJB
dj5jmk42Jsya4vzHEk9A+yc=
=9bYq
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
