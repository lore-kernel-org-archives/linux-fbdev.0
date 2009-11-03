From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH v2 2/3] drm: set the type of the drm_framebuffer::fbdev field
Date: Tue, 03 Nov 2009 13:19:33 +0100
Message-ID: <4AF01FD5.7040205@ladisch.de>
References: <4AEE8CDD.10600@ladisch.de> <4AEE8D6F.60209@ladisch.de> <alpine.LFD.2.00.0911021431360.30135@casper.infradead.org> <4AF01F72.2030605@ladisch.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753875AbZKCMTa@vger.kernel.org>
In-Reply-To: <4AF01F72.2030605@ladisch.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

The fbdev field of the drm_framebuffer structure is always used to store
a pointer to a fb_info, so there is no reason for it to be void*.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
Needed for the next patch.

 include/drm/drm_crtc.h          |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6/include/drm/drm_crtc.h
+++ linux-2.6/include/drm/drm_crtc.h
@@ -256,7 +256,7 @@ struct drm_framebuffer {
 	unsigned int depth;
 	int bits_per_pixel;
 	int flags;
-	void *fbdev;
+	struct fb_info *fbdev;
 	u32 pseudo_palette[17];
 	struct list_head filp_head;
 	/* if you are using the helper */
