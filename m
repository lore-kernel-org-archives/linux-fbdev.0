From: <jhf@rivenstone.net>
Subject: Re: [FBDEV UPDATE] Newer patch.
Date: Wed, 22 Oct 2003 16:50:43 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031022205043.GA725@rivenstone.net>
References: <Pine.LNX.4.44.0310221814290.25125-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACQ1F-0005qE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 22 Oct 2003 13:55:49 -0700
Received: from dhcp160178171.columbus.rr.com ([24.160.178.171] helo=nineveh.rivenstone.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1ACPzK-0000o7-1W
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Oct 2003 13:53:50 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310221814290.25125-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--aVD9QWMuhilNxW9f
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2003 at 06:31:22PM +0100, James Simmons wrote:
>=20
> Hi folks.=20
>=20
>   I have a new patch against 2.6.0-test8. This patch is a few fixes and I=
=20
> added back in functionality for switching the video mode for fbcon via=20
> fbset again. Give it a try and let me know the results.
>=20
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

    The attached patch is needed to make tdfxfb compile after
applying this patch and also in test8-mm1 (so presumably in your older
patch as well) (tdfxfb_imageblt calls cfb_imageblt).

    tdfx is still badly broken in -mm1 both before and after replacing
the older fbdev patch in -mm1 with your new one.  The behavior is much
the same as reported with other drivers -- out of range frequencies
and the same backtraces.  With fbset working I can set a new
resolution which gets me a barely usable console -- lots of
artifacts.

    I don't have time to test against vanilla -test8; maybe later.
Thanks!


--=20
Joseph Fannin
jhf@rivenstone.net

"That's all I have to say about that." -- Forrest Gump.

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=out
Content-Transfer-Encoding: quoted-printable

diff -aur linux-2.6.0-test8-mm1_orig/drivers/video/Makefile /usr/src/linux-=
2.6.0-test8-mm1_duo/drivers/video/Makefile
--- linux-2.6.0-test8-mm1_orig/drivers/video/Makefile	2003-10-22 15:30:33.0=
00000000 -0400
+++ /usr/src/linux-2.6.0-test8-mm1_duo/drivers/video/Makefile	2003-10-22 16=
:38:27.000000000 -0400
@@ -32,7 +32,7 @@
 obj-$(CONFIG_FB_CYBER)            +=3D cyberfb.o
 obj-$(CONFIG_FB_CYBER2000)        +=3D cyber2000fb.o cfbfillrect.o cfbcopy=
area.o cfbimgblt.o
 obj-$(CONFIG_FB_SGIVW)            +=3D sgivwfb.o cfbfillrect.o cfbcopyarea=
=2Eo cfbimgblt.o
-obj-$(CONFIG_FB_3DFX)             +=3D tdfxfb.o
+obj-$(CONFIG_FB_3DFX)             +=3D tdfxfb.o cfbimgblt.o
 obj-$(CONFIG_FB_MAC)              +=3D macfb.o macmodes.o cfbfillrect.o cf=
bcopyarea.o cfbimgblt.o=20
 obj-$(CONFIG_FB_HP300)            +=3D hpfb.o cfbfillrect.o cfbimgblt.o
 obj-$(CONFIG_FB_OF)               +=3D offb.o cfbfillrect.o cfbimgblt.o cf=
bcopyarea.o

--k1lZvvs/B4yU6o8G--

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lu2jWv4KsgKfSVgRAgHdAJ9YqjgD9PVwPIbKQbaQ1wuJc+RZyQCfRZrq
oBt1eXd/Oj94l9h/E4TZVvg=
=8Eu9
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
