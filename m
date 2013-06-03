From: Michal Simek <michal.simek@xilinx.com>
Date: Mon, 03 Jun 2013 10:13:22 +0000
Subject: [PATCH v4 7/7] video: xilinxfb: Use driver for Xilinx ARM Zynq
Message-Id: <282ff667cd78aa58ebe93d856142e8446eb837c5.1370254386.git.michal.simek@xilinx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_mimegpg-monstr-desktop-9811-1370254423-0001"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1370254386.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1370254386.git.michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org
Cc: Michal Simek <monstr@monstr.eu>, Michal Simek <michal.simek@xilinx.com>, Arnd Bergmann <arnd@arndb.de>, Timur Tabi <timur@tabi.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-9811-1370254423-0001

From: Michal Simek <monstr@monstr.eu>

Enable this driver for all Xilinx platforms.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in v4:
- Remove "video: xilinxfb: Fix sparse warnings"
  patch because it is trying to fix incorrect API
  usage and sparse should warn about it.

Changes in v3: None
Changes in v2: None

 drivers/video/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 2e937bd..2c301f8 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2188,7 +2188,7 @@ config FB_PS3_DEFAULT_SIZE_M

 config FB_XILINX
 	tristate "Xilinx frame buffer support"
-	depends on FB && (XILINX_VIRTEX || MICROBLAZE)
+	depends on FB && (XILINX_VIRTEX || MICROBLAZE || ARCH_ZYNQ)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
--
1.8.2.3


--=_mimegpg-monstr-desktop-9811-1370254423-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGsbFcACgkQykllyylKDCFOkQCeMoft8MLrm+CaaEMwdXyORHyn
aXkAn0FfyrZ+YDaOELLYcf7loWBdJmX4
=wL2W
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-9811-1370254423-0001--
