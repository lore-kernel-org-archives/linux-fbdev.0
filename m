From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 24 Sep 2020 11:25:30 +0000
Subject: [PATCH] MAINTAINERS: mark FRAMEBUFFER LAYER as Orphan
Message-Id: <7b709254-9412-8473-250c-0c4e006259b3@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200924112530eucas1p13af17d649767ed51c619d303392fa1e1@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

It has been a fun ride since 2017 but unfortunately I don't have
enough time to look after it properly anymore.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 MAINTAINERS |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: b/MAINTAINERS
=================================--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6894,10 +6894,9 @@ F:	drivers/net/wan/dlci.c
 F:	drivers/net/wan/sdla.c
 
 FRAMEBUFFER LAYER
-M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	dri-devel@lists.freedesktop.org
 L:	linux-fbdev@vger.kernel.org
-S:	Maintained
+S:	Orphan
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/fb/
