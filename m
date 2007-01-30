From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 6/10] ps3: Preallocate bootmem memory
	for ps3fb
Date: Tue, 30 Jan 2007 18:02:02 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701301801350.29487@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBwN0-0007qU-Sk for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 09:02:11 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBwMz-0002CS-Ak
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 09:02:10 -0800
In-Reply-To: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Preallocate bootmem memory for the PS3 frame buffer device, which needs a
large block of physically-contiguous memory. The size of this memory block is
configurable:
  - The config option CONFIG_FB_PS3_DEFAULT_SIZE_M allows to specify the
    default amount of memory (in MiB) allocated to the virtual frame buffer.
  - The early boot parameter `ps3fb=xxx' allows to override the default value.
    It will be rounded up to a multiple of 1 MiB, if needed.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/setup.c |   42 +++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/ps3.h          |    9 +++++++
 2 files changed, 51 insertions(+)

--- ps3-linux-2.6.20-rc6.orig/arch/powerpc/platforms/ps3/setup.c
+++ ps3-linux-2.6.20-rc6/arch/powerpc/platforms/ps3/setup.c
@@ -24,6 +24,7 @@
 #include <linux/root_dev.h>
 #include <linux/console.h>
 #include <linux/kexec.h>
+#include <linux/bootmem.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -80,6 +81,46 @@ static void ps3_panic(char *str)
 	for (;;) ;
 }
 
+
+static void prealloc(struct ps3_prealloc *p)
+{
+	if (!p->size)
+		return;
+
+	p->address = __alloc_bootmem(p->size, p->align, __pa(MAX_DMA_ADDRESS));
+	if (!p->address) {
+		printk(KERN_ERR "%s: Cannot allocate %s\n", __FUNCTION__,
+		       p->name);
+		return;
+	}
+
+	printk(KERN_INFO "%s: %lu bytes at %p\n", p->name, p->size,
+	       p->address);
+}
+
+#ifdef CONFIG_FB_PS3
+struct ps3_prealloc ps3fb_videomemory = {
+    .name = "ps3fb videomemory",
+    .size = CONFIG_FB_PS3_DEFAULT_SIZE_M*1024*1024,
+    .align = 1024*1024			/* the GPU requires 1 MiB alignment */
+};
+#define prealloc_ps3fb_videomemory()	prealloc(&ps3fb_videomemory)
+
+static int __init early_parse_ps3fb(char *p)
+{
+	if (!p)
+		return 1;
+
+	ps3fb_videomemory.size = _ALIGN_UP(memparse(p, &p),
+					   ps3fb_videomemory.align);
+	return 0;
+}
+early_param("ps3fb", early_parse_ps3fb);
+#else
+#define prealloc_ps3fb_videomemory()	do { } while (0)
+#endif
+
+
 static void __init ps3_setup_arch(void)
 {
 	union ps3_firmware_version v;
@@ -101,6 +142,7 @@ static void __init ps3_setup_arch(void)
 	conswitchp = &dummy_con;
 #endif
 
+	prealloc_ps3fb_videomemory();
 	ppc_md.power_save = ps3_power_save;
 
 	DBG(" <- %s:%d\n", __func__, __LINE__);
--- ps3-linux-2.6.20-rc6.orig/include/asm-powerpc/ps3.h
+++ ps3-linux-2.6.20-rc6/include/asm-powerpc/ps3.h
@@ -426,4 +426,13 @@ int ps3_vuart_write(struct ps3_vuart_por
 int ps3_vuart_read(struct ps3_vuart_port_device *dev, void* buf,
 	unsigned int bytes);
 
+struct ps3_prealloc {
+    const char *name;
+    void *address;
+    unsigned long size;
+    unsigned long align;
+};
+
+extern struct ps3_prealloc ps3fb_videomemory;
+
 #endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
