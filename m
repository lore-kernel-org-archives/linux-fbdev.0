From: Peter Rosin <peda@axentia.se>
Date: Mon, 26 Aug 2019 19:59:02 +0000
Subject: [PATCH v2 3/3] fbdev: fbmem: avoid exporting fb_center_logo
Message-Id: <20190826195740.29415-4-peda@axentia.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190826195740.29415-1-peda@axentia.se>
In-Reply-To: <20190826195740.29415-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jonathan Corbet <corbet@lwn.net>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>

The variable is only ever used from fbcon.c which is linked into the
same module. Therefore, the export is not needed.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/video/fbdev/core/fbmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index a7d8022db516..17e250a515b0 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -54,7 +54,6 @@ int num_registered_fb __read_mostly;
 EXPORT_SYMBOL(num_registered_fb);
 
 bool fb_center_logo __read_mostly;
-EXPORT_SYMBOL(fb_center_logo);
 
 unsigned int fb_logo_count __read_mostly;
 
-- 
2.11.0
