From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Smart LCD Linux driver
Date: Sun, 4 Jul 2004 21:41:11 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040704194111.GT18841@lug-owl.de>
References: <DC91351678E31E4FB24B551221F507ECB771EA@blr-itp-msg.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LqInKle6vr1NBc7W"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BhDQq-0006cl-RI
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Jul 2004 13:17:48 -0700
Received: from dvmwest.gt.owl.de ([62.52.24.140])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BhDNw-0007Dn-Ru
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Jul 2004 13:17:47 -0700
Content-Disposition: inline
In-Reply-To: <DC91351678E31E4FB24B551221F507ECB771EA@blr-itp-msg.wipro.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: kiran.tigadi@wipro.com
Cc: linux-fbdev-devel@lists.sourceforge.net


--LqInKle6vr1NBc7W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-07-02 19:16:15 +0530, kiran.tigadi@wipro.com <kiran.tigadi@wip=
ro.com>
wrote in message <DC91351678E31E4FB24B551221F507ECB771EA@blr-itp-msg.wipro.=
com>:
> Hi,
>=20
> Overview Smart LCD panel
> ??262144 colors, 65536 colors, 4096 colors and 8 colors display is availa=
ble by PWM driving.
> ??Direct data display by video data RAM (normally-white LCD)
> ??Partial display function Power saving by pausing display process on par=
t of the screen.
> ??Built-in RAM capacity 6=D7540=D7288=3D933120 bit
> ??MPU interface Directly connectable to an 16-bit or 8-bit parallel MPU o=
f 80 series
> ??Plenty of command functions
> ??Built-in oscillating circuit

So you need a shadow/bounce framebuffer if you *really* want to provide
it as a framebuffer; registering as a console might be simpler, but
won't provide graphic capabilities.

MfG, JBG
PS: Please include correct Message-IDs and don't write text above
full-quote...

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--LqInKle6vr1NBc7W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA6F1WHb1edYOZ4bsRAkIpAJ4obnu5sp1Du4hvrfJ7y+e7zFxa3wCdE7gK
n2TKgjQ1xPOfhUXBKtC1sZQ=
=sRWO
-----END PGP SIGNATURE-----

--LqInKle6vr1NBc7W--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
