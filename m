From: Jesper Juhl <juhl-lkml@dif.dk>
Subject: [PATCH] copy_to_user return value checking in
 radeon_state.c::radeon_cp_dispatch_texture() ...
Date: Sun, 28 Nov 2004 19:34:02 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0411281926570.3389@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261558AbUK1SZ2@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Gareth Hughes <gareth@valinux.com>, "Kevin E. Martin" <martin@valinux.com>, linux-kernel <linux-kernel@vger.kernel.org>


Here's a patch adding return value checking to 
drivers/char/drm/radeon_state.c::radeon_cp_dispatch_texture()
thus getting rid of the warning 
drivers/char/drm/radeon_state.c: In function `radeon_cp_dispatch_texture':
drivers/char/drm/radeon_state.c:1443: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result
and hopefully behaving more correctly in the case of errors.

<disclaimer>
I have no hardware to test this, so cmpile tested only.
</disclaimer>


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk11-orig/drivers/char/drm/radeon_state.c linux-2.6.10-rc2-bk11/drivers/char/drm/radeon_state.c
--- linux-2.6.10-rc2-bk11-orig/drivers/char/drm/radeon_state.c	2004-10-18 23:54:55.000000000 +0200
+++ linux-2.6.10-rc2-bk11/drivers/char/drm/radeon_state.c	2004-11-28 19:25:16.000000000 +0100
@@ -1440,7 +1440,10 @@ static int radeon_cp_dispatch_texture( D
 		}
 		if ( !buf ) {
 			DRM_DEBUG("radeon_cp_dispatch_texture: EAGAIN\n");
-			DRM_COPY_TO_USER( tex->image, image, sizeof(*image) );
+			if (DRM_COPY_TO_USER( tex->image, image, sizeof(*image) )) {
+                        	DRM_ERROR( "copy_to_user\n" );
+				return DRM_ERR(EFAULT);
+			}
 			return DRM_ERR(EAGAIN);
 		}
 


PS. Please CC me on replies from other lists than linux-kernel.

-- 
Jesper Juhl <juhl-lkml@dif.dk>
