From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] move acornfb's probe function to .devinit.text
Date: Sat, 11 Jul 2009 22:52:29 +0200
Message-ID: <1247345591-22643-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090711170548.GC5205@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757262AbZGKU4P@vger.kernel.org>
In-Reply-To: <20090711170548.GC5205@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>

A pointer to acornfb_probe is passed to the core via
platform_driver_register and so the function must not disappear when th=
e
=2Einit sections are discarded.  Otherwise (if also having HOTPLUG=3Dy)
unbinding and binding a device to the driver via sysfs will result in a=
n
oops as does a device being registered late.

An alternative to this patch is using platform_driver_probe instead of
platform_driver_register plus removing the pointer to the probe functio=
n
from the struct platform_driver.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Antonino Daplas <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/video/acornfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/acornfb.c b/drivers/video/acornfb.c
index 0bcc59e..43d7d50 100644
--- a/drivers/video/acornfb.c
+++ b/drivers/video/acornfb.c
@@ -1221,7 +1221,7 @@ free_unused_pages(unsigned int virtual_start, uns=
igned int virtual_end)
 	printk("acornfb: freed %dK memory\n", mb_freed);
 }
=20
-static int __init acornfb_probe(struct platform_device *dev)
+static int __devinit acornfb_probe(struct platform_device *dev)
 {
 	unsigned long size;
 	u_int h_sync, v_sync;
--=20
1.6.3.1
