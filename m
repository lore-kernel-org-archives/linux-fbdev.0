From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Ekiga-video conferencing-Gtk warning
Date: Wed, 25 Apr 2007 12:18:51 +0200
Message-ID: <20070425101851.GQ25077@lug-owl.de>
References: <20070425153734.CJC76756@mail.tataelxsi.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2101855409=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgeaW-0000uH-Dz for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 03:19:06 -0700
Received: from lug-owl.de ([195.71.106.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HgeaV-0000kS-Oa
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 03:19:04 -0700
In-Reply-To: <20070425153734.CJC76756@mail.tataelxsi.co.in>
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
To: "Dheepan A.P" <dheepan@tataelxsi.co.in>
Cc: linux-fbdev-devel@lists.sourceforge.net


--===============2101855409==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i13qRg9tmWEwo36p"
Content-Disposition: inline


--i13qRg9tmWEwo36p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-04-25 15:37:34 +0530, Dheepan A.P <dheepan@tataelxsi.co.in> wr=
ote:
>   I am involving in a video conferencing project where
>   i m in need to port an open source application(PC
>   based application) to TI-davinci board.
>   I cross compiled the source code to arm platform.Its
>   done well.
>=20
>   But after porting it to the board it shows an error
>   "GTK warning:cannot open display".
>=20
>   I suspects that when we are trying to get the
>   display on PAL tv instead of pc monitor(the
>   application is meant for Pc based), it get struck
>   with  to the  configuation settings related to the
>   frame buffer.

This message usually means that GTK cannot open the X11 display. (It's
probably irrelevant whether this is on a VGA or TV output.)

You'd check that your application is started with the DISPLAY variable
being properly set. I guess it gets lost somewhere. An alternative
error would be that the security cookies cannot be accessed by the X11
client libraries (used by GTK) so that the application is actually
denied to access the X11 display.

Try starting with strace. That should show you where the error
actually is.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:  The course of history shows that as a government grows, libe=
rty
the second  : decreases."  (Thomas Jefferson)

--i13qRg9tmWEwo36p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGLysLHb1edYOZ4bsRAhX2AJ9K9TAMxZUvYbFUJqhtv4CeiUMj3ACeKMrJ
91WnSrPqufENkaIQXfiTs7w=
=wzSx
-----END PGP SIGNATURE-----

--i13qRg9tmWEwo36p--


--===============2101855409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2101855409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============2101855409==--
