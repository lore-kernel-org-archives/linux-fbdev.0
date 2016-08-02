From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:07:31 +0000
Subject: [PATCH 1006/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120731.17151-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.vetter@ffwll.ch, khoroshilov@ispras.ru, chuansheng.liu@intel.com, baolex.ni@intel.com, mathias.nyman@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 76c1ad9..e597464 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1609,7 +1609,7 @@ static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
 }
 
 static bool lockless_register_fb;
-module_param_named_unsafe(lockless_register_fb, lockless_register_fb, bool, 0400);
+module_param_named_unsafe(lockless_register_fb, lockless_register_fb, bool, S_IRUSR);
 MODULE_PARM_DESC(lockless_register_fb,
 	"Lockless framebuffer registration for debugging [default=off]");
 
-- 
2.9.2

