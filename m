From: David Herrmann <dh.herrmann@googlemail.com>
Date: Sun, 15 Jul 2012 19:04:46 +0000
Subject: [PATCH v3 11/11] MAINTAINERS: add fblog entry
Message-Id: <1342379086-7583-12-git-send-email-dh.herrmann@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1342379086-7583-1-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1342379086-7583-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, David Herrmann <dh.herrmann@googlemail.com>

Add myself as maintainer for the fblog driver to the MAINTAINERS file.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 719f57f..227d5ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2854,6 +2854,12 @@ F:	drivers/video/
 F:	include/video/
 F:	include/linux/fb.h
 
+FRAMEBUFFER LOG DRIVER
+M:	David Herrmann <dh.herrmann@googlemail.com>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	drivers/video/console/fblog.c
+
 FREESCALE DMA DRIVER
 M:	Li Yang <leoli@freescale.com>
 M:	Zhang Wei <zw@zh-kernel.org>
-- 
1.7.11.2

