From: Michal Simek <michal.simek@xilinx.com>
Date: Wed, 29 May 2013 16:12:58 +0000
Subject: [PATCH 3/3] video: xilinxfb: Use driver for Xilinx ARM Zynq
Message-Id: <d534cf63d4d5c5e4d8a7547198895f60cff8948b.1369843969.git.michal.simek@xilinx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_mimegpg-monstr-desktop-20207-1369843983-0001"
List-Id: <linux-fbdev.vger.kernel.org>
References: <502367ddf6d79b7b343b3165ad54cb9e2d4713db.1369843969.git.michal.simek@xilinx.com>
In-Reply-To: <502367ddf6d79b7b343b3165ad54cb9e2d4713db.1369843969.git.michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org
Cc: Michal Simek <monstr@monstr.eu>, Michal Simek <michal.simek@xilinx.com>, Pallav Joshi <pallav.joshi@xilinx.com>, git-dev@xilinx.com, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-20207-1369843983-0001

From: Michal Simek <monstr@monstr.eu>

Enable this driver for all Xilinx platforms.

Signed-off-by: Michal Simek <monstr@monstr.eu>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
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


--=_mimegpg-monstr-desktop-20207-1369843983-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGmKQ8ACgkQykllyylKDCHL9wCfYbhSoda01iLDi7O3HfJ2CJ2j
VSwAoI4k9SmNDYP0sVjU0U/MeBs1DPQH
=vkBw
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-20207-1369843983-0001--
