From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:09:00 +0000
Subject: [PATCH 1020/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120900.18098-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spock@gentoo.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/uvesafb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 178ae93..19b4416 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -2017,7 +2017,7 @@ MODULE_PARM_DESC(mode_option,
 module_param(vbemode, ushort, 0);
 MODULE_PARM_DESC(vbemode,
 	"VBE mode number to set, overrides the 'mode' option");
-module_param_string(v86d, v86d_path, PATH_MAX, 0660);
+module_param_string(v86d, v86d_path, PATH_MAX, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
 MODULE_PARM_DESC(v86d, "Path to the v86d userspace helper.");
 
 MODULE_LICENSE("GPL");
-- 
2.9.2

