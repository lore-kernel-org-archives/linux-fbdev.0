From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Screen Refresh
Date: Wed, 5 May 2004 16:02:57 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040505140257.GI29503@lug-owl.de>
References: <200405051047.00127.lucasvr@gobolinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIW0mBdZQbss59/X"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLMzG-0002Bc-FH
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 May 2004 07:03:02 -0700
Received: from dvmwest.gt.owl.de ([62.52.24.140])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BLMzF-0000jb-Oc
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 May 2004 07:03:01 -0700
Content-Disposition: inline
In-Reply-To: <200405051047.00127.lucasvr@gobolinux.org>
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


--WIW0mBdZQbss59/X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-05-05 10:47:00 -0300, Lucas Correia Villa Real <lucasvr@goboli=
nux.org>
wrote in message <200405051047.00127.lucasvr@gobolinux.org>:
> I'm writing a device driver for a monochrome LCD display managed by a=20
> controller that will be plugged into the CPU through a SPI, that is, I ca=
nnot=20
> directly memory-map it's address, since the communication will be done vi=
a=20
> a serial interface.

So I see two ways.

	If you only want to be able to output text, then you'd register
as a console device. You'll then get write accesses, which you can then
promote to real hardware.

	If you really want to provide a graphical display, you'll need
something like two buffers (one the kernel writes to, probably a 2nd one
to store the "current" image to only send down the changed pixels).
That'll come along with some timed function - not nice, but may work.

In theory, you'd try to not actually provide a framebuffer (memory), but
to simply give pointers to all those accelerated functions. If you've
got enough luck, you'll only see these functions called, so that you can
do graphics with merely no overhead of polling the whole memory...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--WIW0mBdZQbss59/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAmPQRHb1edYOZ4bsRAqtnAJ97LEMTmcM572FlXViJYw6GpDNipQCcCsEP
EbUYsmYATNtiwRsqvpRejAs=
=vFxA
-----END PGP SIGNATURE-----

--WIW0mBdZQbss59/X--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
