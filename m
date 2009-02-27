From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH v2] n411: add missing Makefile entry
Date: Fri, 27 Feb 2009 16:46:04 -0300
Message-ID: <200902271646.05170.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758609AbZB0TqN@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

There is no entry for n411.c to be built, include one in Makefile.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 drivers/video/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

v2: resend, proper patch without mailer line breaks

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 2a998ca..4bd8050 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_FB_ATARI)            += atafb.o c2p_iplan2.o atafb_mfb.o \
                                      atafb_iplan2p2.o atafb_iplan2p4.o atafb_iplan2p8.o
 obj-$(CONFIG_FB_MAC)              += macfb.o
 obj-$(CONFIG_FB_HECUBA)           += hecubafb.o
+obj-$(CONFIG_FB_N411)             += n411.o
 obj-$(CONFIG_FB_HGA)              += hgafb.o
 obj-$(CONFIG_FB_XVR500)           += sunxvr500.o
 obj-$(CONFIG_FB_XVR2500)          += sunxvr2500.o
-- 
1.6.1.3
