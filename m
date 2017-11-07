From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 07 Nov 2017 14:05:05 +0000
Subject: [PATCH] fbdev: controlfb: Add missing modes to fix out of bounds access
Message-Id: <1510063505-2063-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Dan's static analysis says:

    drivers/video/fbdev/controlfb.c:560 control_setup()
    error: buffer overflow 'control_mac_modes' 20 <= 21

Indeed, control_mac_modes[] has only 20 elements, while VMODE_MAX is 22,
which may lead to an out of bounds read when parsing vmode commandline
options.

The bug was introduced in v2.4.5.6, when 2 new modes were added to
macmodes.h, but control_mac_modes[] wasn't updated:

https://kernel.opensuse.org/cgit/kernel/diff/include/video/macmodes.h?h=v2.5.2&id)f279c764808560eaceb88fef36cbc35c529aad

Augment control_mac_modes[] with the two new video modes to fix this.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.

The 1152x768 mode should be OK.
Given the 1600x1024 mode has a lower dotclock (112 MHz) than the
supported 1280x960 mode, it's probably OK, too.
---
 drivers/video/fbdev/controlfb.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/controlfb.h b/drivers/video/fbdev/controlfb.h
index 6026c60fc1007e00..261522fabdac89ae 100644
--- a/drivers/video/fbdev/controlfb.h
+++ b/drivers/video/fbdev/controlfb.h
@@ -141,5 +141,7 @@ static struct max_cmodes control_mac_modes[] = {
 	{{ 1, 2}},	/* 1152x870, 75Hz */
 	{{ 0, 1}},	/* 1280x960, 75Hz */
 	{{ 0, 1}},	/* 1280x1024, 75Hz */
+	{{ 1, 2}},	/* 1152x768, 60Hz */
+	{{ 0, 1}},	/* 1600x1024, 60Hz */
 };
 
-- 
2.7.4

