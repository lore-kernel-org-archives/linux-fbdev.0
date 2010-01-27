From: Maik Broemme <mbroemme@plusserver.de>
Date: Wed, 27 Jan 2010 02:11:14 +0000
Subject: [PATCH] New Maintainer for intelfb driver.
Message-Id: <20100127021114.GD3802@bart.intergenia.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

it seems that Sylvain no longer maintain the intelfb driver. Two weeks
ago I had a short mail conversation with Jean who can replace him. Well
I will do it, because I know the driver and use it very often. I wasn't
able to create the diff earlier, because the weekend after the conversation
I moved to Freiburg.

Attached is a patch which update the maintainer file to make bug reporting
easier.

Signed-off-by: Maik Broemme <mbroemme@plusserver.de>

--Maik

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6-intelfb.patch"

diff -Nur linux-2.6/MAINTAINERS linux-2.6-intelfb/MAINTAINERS
--- linux-2.6/MAINTAINERS	2010-01-27 02:55:41.171319055 +0100
+++ linux-2.6-intelfb/MAINTAINERS	2010-01-27 02:52:41.963318562 +0100
@@ -2758,7 +2758,7 @@
 F:	drivers/input/
 
 INTEL FRAMEBUFFER DRIVER (excluding 810 and 815)
-M:	Sylvain Meyer <sylvain.meyer@worldonline.fr>
+M:	Maik Broemme <mbroemme@plusserver.de>
 L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/fb/intelfb.txt

--AhhlLboLdkugWU4S--
