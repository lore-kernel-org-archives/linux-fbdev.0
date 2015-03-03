From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 03 Mar 2015 10:52:26 +0000
Subject: [PATCH 2/2] MAINTAINERS: update for sm750fb driver
Message-Id: <1425379867-2176-3-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425379867-2176-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425379867-2176-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org

add myself and Teddy Wang as the Maintainer of the sm750
frame buffer driver.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ee5466..1a51043 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9340,6 +9340,14 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/sm7xxfb/
 
+STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER
+M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
+M:	Teddy Wang <teddy.wang@siliconmotion.com>
+M:	Sudip Mukherjee <sudip@vectorindia.org>
+L:	linux-fbdev@vger.kernel.org
+S:	Maintained
+F:	drivers/staging/sm750fb/
+
 STAGING - SLICOSS
 M:	Lior Dotan <liodot@gmail.com>
 M:	Christopher Harrer <charrer@alacritech.com>
-- 
1.8.1.2

