From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 2.6 2/2] Fix documentation build failure
Date: Mon, 14 Feb 2005 23:10:10 +0300
Message-ID: <20050214201009.GB29201@sirius.home>
References: <20050214200017.GA29201@sirius.home>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0mY5-00076I-GC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 12:10:25 -0800
Received: from mail.murom.net ([213.177.124.17] helo=ns1.murom.ru)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D0mY3-0003gU-SQ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 12:10:25 -0800
Content-Disposition: inline
In-Reply-To: <20050214200017.GA29201@sirius.home>
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
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

In linux-2.6.11-rc4-bk2 building of the documentation (make htmldocs)
fails on "DOCPROC Documentation/DocBook/kernel-api.sgml" because of
these errors:

Error(/home/vsu/src/linux-2.6.11-rc4-bk2/include/linux/skbuff.h:936): canno=
t understand prototype: '#ifndef CONFIG_HAVE_ARCH_DEV_ALLOC_SKB '
Error(/home/vsu/src/linux-2.6.11-rc4-bk2/drivers/video/fbmem.c:1265): canno=
t understand prototype: 'const char *global_mode_option; '

This patch fixes htmldocs build failure on drivers/video/fbmem.c.
I think this patch (or an equivalent one) should be merged before the
2.6.11 release.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


--- linux-2.6.11-rc4-bk2/drivers/video/fbmem.c.doc-build	2005-02-14 20:12:3=
3 +0300
+++ linux-2.6.11-rc4-bk2/drivers/video/fbmem.c	2005-02-14 23:02:45 +0300
@@ -1261,9 +1261,6 @@ int fb_get_options(char *name, char **op
  *	Returns zero.
  *
  */
-
-extern const char *global_mode_option;
-
 int __init video_setup(char *options)
 {
 	int i, global =3D 0;
@@ -1277,6 +1274,8 @@ int __init video_setup(char *options)
  	}
=20
  	if (!global && !strstr(options, "fb:")) {
+		extern const char *global_mode_option;
+
  		global_mode_option =3D options;
  		global =3D 1;
  	}


--=20
Sergey Vlasov

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCEQWgW82GfkQfsqIRAmlqAJ0ahaEYp3aK96NpqV2ZvVjrXaTgHwCfewCo
uvD76GxbGvoyAZNFjX4a7Vo=
=vqEa
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
