From: David Lazar <david@panzer.utcluj.ro>
Subject: 6x11 font patch
Date: Sun, 31 Oct 2004 17:53:52 +0200
Message-ID: <20041031155352.GA3551@panzer.utcluj.ro>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1COI1W-00031y-LR
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 31 Oct 2004 07:53:42 -0800
Received: from panzer.utcluj.ro ([193.226.5.49])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.41)
	id 1COI1V-0008UN-L9
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 31 Oct 2004 07:53:42 -0800
Received: from david by panzer.utcluj.ro with local (Exim 4.34)
	id 1COI1g-0000vU-GD
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 31 Oct 2004 17:53:52 +0200
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've tried to use the 6x11 (mac console) font on the framebuffer console
(on the x86 architecture), and I've noticed that the font didn't have
the correct box drawing glyphs. As a result I've used as a model the
8x16 font and edited the glyphs for all 256 US ASCII characters, so that
they display correctly.

Is anyone interested in including this patch in the stock kernel?

I'm not attaching the patch since it's rather long (3200+ lines), so
instead I've put it online on my website:

http://www.c7obs.net/~david/stuff/font_6x11.patch

Also, at the address http://www.c7obs.net/~david/stuff/ you can see 2
screenshots illustrating my changes.

I should mention that I haven't tested the new font on the mac console
since I do not own a mac.

Thank you for your time, and please let me know if you want anything
changed in the patch.

Cheers!
-=[david]=-

P.S. The patch was created against the 2.6.9 kernel.

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBhQqQr9TZoXJfltoRAtghAJ9+NHkFTKKmrCcjKFJ1h3yw7tYPRACgllws
Fwwa3UTZgHxbp6t4cKK6Qnc=
=m+BJ
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
