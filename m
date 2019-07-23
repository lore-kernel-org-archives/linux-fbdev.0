From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 23 Jul 2019 14:33:27 +0000
Subject: [PATCH] MAINTAINERS: handle fbdev changes through drm-misc tree
Message-Id: <d449f697-ed25-8a3f-16d5-b981f1a52217@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190723143329eucas1p211688de2902dbac72998fda9e694083d@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>

fbdev patches will now go to upstream through drm-misc tree (IOW
starting with v5.4 merge window fbdev changes will be included in
DRM pull request) for improved maintainership and better integration
testing. Update MAINTAINERS file accordingly.

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/MAINTAINERS
=================================--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6389,7 +6389,7 @@ FRAMEBUFFER LAYER
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	dri-devel@lists.freedesktop.org
 L:	linux-fbdev@vger.kernel.org
-T:	git git://github.com/bzolnier/linux.git
+T:	git git://anongit.freedesktop.org/drm/drm-misc
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
 S:	Maintained
 F:	Documentation/fb/
