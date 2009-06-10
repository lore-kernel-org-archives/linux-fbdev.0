From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 14/33] ps3fb: Tear down FB setup during
	cleanup
Date: Wed, 10 Jun 2009 16:38:49 +0200
Message-ID: <1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@sonycom.com>) id 1MEOxi-0000Ny-Cb
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 10 Jun 2009 14:39:34 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 3b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MEOxV-000522-9l
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 10 Jun 2009 14:39:34 +0000
In-Reply-To: <1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org

During cleanup, use L1GPU_CONTEXT_ATTRIBUTE_FB_CLOSE to tear down the setup
done by L1GPU_CONTEXT_ATTRIBUTE_FB_SETUP.

This allows unloading and reloading of ps3fb while the sound driver keeps the
GPU open.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linux-fbdev-devel@lists.sourceforge.net
---
 arch/powerpc/include/asm/ps3gpu.h |    8 ++++++++
 drivers/video/ps3fb.c             |    5 ++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3gpu.h b/arch/powerpc/include/asm/ps3gpu.h
index 1037efa..b2b8959 100644
--- a/arch/powerpc/include/asm/ps3gpu.h
+++ b/arch/powerpc/include/asm/ps3gpu.h
@@ -31,6 +31,7 @@
 #define L1GPU_CONTEXT_ATTRIBUTE_FB_SETUP	0x600
 #define L1GPU_CONTEXT_ATTRIBUTE_FB_BLIT		0x601
 #define L1GPU_CONTEXT_ATTRIBUTE_FB_BLIT_SYNC	0x602
+#define L1GPU_CONTEXT_ATTRIBUTE_FB_CLOSE	0x603
 
 #define L1GPU_FB_BLIT_WAIT_FOR_COMPLETION	(1ULL << 32)
 
@@ -75,4 +76,11 @@ static inline int lv1_gpu_fb_blit(u64 context_handle, u64 ddr_offset,
 					 pitch);
 }
 
+static inline int lv1_gpu_fb_close(u64 context_handle)
+{
+	return lv1_gpu_context_attribute(context_handle,
+					 L1GPU_CONTEXT_ATTRIBUTE_FB_CLOSE, 0,
+					 0, 0, 0);
+}
+
 #endif /* _ASM_POWERPC_PS3GPU_H */
diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 13c876c..1baa1c9 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -1123,7 +1123,7 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 
 	info = framebuffer_alloc(sizeof(struct ps3fb_par), &dev->core);
 	if (!info)
-		goto err_context_unmap;
+		goto err_context_fb_close;
 
 	par = info->par;
 	par->mode_id = ~ps3fb_mode;	/* != ps3fb_mode, to trigger change */
@@ -1188,6 +1188,8 @@ err_fb_dealloc:
 	fb_dealloc_cmap(&info->cmap);
 err_framebuffer_release:
 	framebuffer_release(info);
+err_context_fb_close:
+	lv1_gpu_fb_close(ps3fb.context_handle);
 err_context_unmap:
 	lv1_gpu_context_iomap(ps3fb.context_handle, GPU_IOIF, xdr_lpar,
 			      ps3fb_videomemory.size, CBE_IOPTE_M);
@@ -1233,6 +1235,7 @@ static int ps3fb_shutdown(struct ps3_system_bus_device *dev)
 		info = dev->core.driver_data = NULL;
 	}
 	iounmap((u8 __force __iomem *)ps3fb.dinfo);
+	lv1_gpu_fb_close(ps3fb.context_handle);
 	lv1_gpu_context_iomap(ps3fb.context_handle, GPU_IOIF, xdr_lpar,
 			      ps3fb_videomemory.size, CBE_IOPTE_M);
 	lv1_gpu_context_free(ps3fb.context_handle);
-- 
1.6.2.4


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
