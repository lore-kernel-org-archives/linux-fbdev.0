From: Michal Simek <michal.simek@xilinx.com>
Date: Thu, 03 Oct 2013 09:46:31 +0000
Subject: [PATCH 9/9] video: amba-clcd: Remove unnecessary amba_set_drvdata()
Message-Id: <2f12a1d7caba382efe8d361b373da60c08e70622.1380793579.git.michal.simek@xilinx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_mimegpg-monstr-desktop-4165-1380793626-0001"
List-Id: <linux-fbdev.vger.kernel.org>
References: <27e289763bbcb7d10f84081543cfc3a4dc770398.1380793579.git.michal.simek@xilinx.com>
In-Reply-To: <27e289763bbcb7d10f84081543cfc3a4dc770398.1380793579.git.michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-4165-1380793626-0001

Driver core clears the driver data to NULL after device_release
or on probe failure, so just remove it from here.

Driver core change:
"device-core: Ensure drvdata = NULL when no driver is bound"
(sha1: 0998d0631001288a5974afc0b2a5f568bcdecb4d)

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/video/amba-clcd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 0a2cce7..0bab6ab 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -594,8 +594,6 @@ static int clcdfb_remove(struct amba_device *dev)
 {
 	struct clcd_fb *fb = amba_get_drvdata(dev);

-	amba_set_drvdata(dev, NULL);
-
 	clcdfb_disable(fb);
 	unregister_framebuffer(&fb->fb);
 	if (fb->fb.cmap.len)
--
1.8.2.3


--=_mimegpg-monstr-desktop-4165-1380793626-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlJNPRoACgkQykllyylKDCHcwwCdHLkeyMWDxFyiuUFRn6V6Njg+
Im4AnRxhoiYE30MftYnQafGuXa4PQ332
=XSu4
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-4165-1380793626-0001--
