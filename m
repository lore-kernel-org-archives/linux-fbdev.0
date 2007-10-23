From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] radeonfb: Remove warning with CONFIG_PM=n
Date: Tue, 23 Oct 2007 00:29:12 -0500
Message-ID: <20071023052912.GA21870@lixom.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753297AbXJWFWT@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Remove warning from powerpc ppc64_defconfig builds:

drivers/video/aty/radeon_pm.c:30: warning: 'radeon_reinitialize_M10' declared 'static' but never defined

It's used only under CONFIG_PM, and only with CONFIG_X86 before it is
defined, so the forward declaration can be moved under the ifdef.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
index be1d57b..83ee3e7 100644
--- a/drivers/video/aty/radeon_pm.c
+++ b/drivers/video/aty/radeon_pm.c
@@ -27,8 +27,6 @@
 
 #include "ati_ids.h"
 
-static void radeon_reinitialize_M10(struct radeonfb_info *rinfo);
-
 /*
  * Workarounds for bugs in PC laptops:
  * - enable D2 sleep in some IBM Thinkpads
@@ -39,6 +37,8 @@ static void radeon_reinitialize_M10(struct radeonfb_info *rinfo);
  */
 
 #if defined(CONFIG_PM) && defined(CONFIG_X86)
+static void radeon_reinitialize_M10(struct radeonfb_info *rinfo);
+
 struct radeon_device_id {
         const char *ident;                     /* (arbitrary) Name */
         const unsigned short subsystem_vendor; /* Subsystem Vendor ID */
