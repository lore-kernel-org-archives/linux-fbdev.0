From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Need help !
Date: Tue, 15 Jun 2004 08:02:04 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040615060204.GU20632@lug-owl.de>
References: <40CDFABF.2020503@integrated-devices.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0WgWZzeKO51D09bo"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ba71M-0001Ll-La
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Jun 2004 23:02:08 -0700
Received: from dvmwest.gt.owl.de ([62.52.24.140])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Ba71M-0003Ue-66
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Jun 2004 23:02:08 -0700
Content-Disposition: inline
In-Reply-To: <40CDFABF.2020503@integrated-devices.com>
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


--0WgWZzeKO51D09bo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-06-14 12:21:35 -0700, Srinivasa Deevi <sdeevi%integrated-devic=
es.com@integrated-devices.com>
wrote in message <40CDFABF.2020503@integrated-devices.com>:
> do I need to add any fonts in fonts directory to see the any console=20
> output through fbcon ? Right now I am able to see the blinking cursor=20
> but any data from it .

No, you don't need to add fonts, but make sure you've choosen at least
one of them:)

> can somebody help me what should I do to see the cosole output on a=20
> frame buffer device ? The frame buffer driver is working in graphics=20
> mode . I have trouble in console mode .

I've seen that, too, when I wrote a FB driver. My bug was that I was
missing

#ifdef CONFIG_VT
#ifdef CONFIG_DUMMY_CONSOLE
	/*
	 * We need a dummy console up at cons_init time, otherwise there'll
	 * be no VTs allocated for the real fbdev console to later take over.
	 */
	conswitchp =3D &dummy_con;
#endif
#endif

in arch-dependand code (for me, adding it to ./arch/vax/kernel/setup.c
did the job).

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--0WgWZzeKO51D09bo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzpDbHb1edYOZ4bsRAuclAJ9LAVdH+fQ71GLmbsiTE0ycOchbegCeMu1F
h/unOmMfXyRqMbjYL1MwK60=
=K7yS
-----END PGP SIGNATURE-----

--0WgWZzeKO51D09bo--


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
