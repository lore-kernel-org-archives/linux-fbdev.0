From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 15 May 2014 10:58:24 +0000
Subject: [PATCH] matroxfb: perform a dummy read of M_STATUS
Message-Id: <alpine.LRH.2.02.1405150652270.19101@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

I had occasional screen corruption with the matrox framebuffer driver and
I found out that the reason for the corruption is that the hardware
blitter accesses the videoram while it is being written to.

The matrox driver has a macro WaitTillIdle() that should wait until the
blitter is idle, but it sometimes doesn't work. I added a dummy read
mga_inl(M_STATUS) to WaitTillIdle() to fix the problem. The dummy read
will flush the write buffer in the PCI chipset, and the next read of
M_STATUS will return the hardware status.

Since applying this patch, I had no screen corruption at all.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/video/matrox/matroxfb_base.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-3.14/drivers/video/matrox/matroxfb_base.h
=================================--- linux-3.14.orig/drivers/video/matrox/matroxfb_base.h	2014-04-08 00:35:19.460051657 +0200
+++ linux-3.14/drivers/video/matrox/matroxfb_base.h	2014-05-03 18:38:18.882396833 +0200
@@ -698,7 +698,7 @@ void matroxfb_unregister_driver(struct m
 
 #define mga_fifo(n)	do {} while ((mga_inl(M_FIFOSTATUS) & 0xFF) < (n))
 
-#define WaitTillIdle()	do {} while (mga_inl(M_STATUS) & 0x10000)
+#define WaitTillIdle()	do { mga_inl(M_STATUS); do {} while (mga_inl(M_STATUS) & 0x10000); } while (0)
 
 /* code speedup */
 #ifdef CONFIG_FB_MATROX_MILLENIUM
