From: Dave Airlie <airlied@gmail.com>
Date: Thu, 25 Feb 2010 04:44:26 +0000
Subject: [PATCH 1/2] fb: for framebuffer handover don't exit the loop early.
Message-Id: <1267073067-23117-2-git-send-email-airlied@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1267073067-23117-1-git-send-email-airlied@gmail.com>
In-Reply-To: <1267073067-23117-1-git-send-email-airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>

From: Dave Airlie <airlied@redhat.com>

An offb machine has been seen in the fields which adds two
offb nodes, so continue scanning the list after removing one.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/video/fbmem.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 99bbd28..a15b44e 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1513,7 +1513,6 @@ register_framebuffer(struct fb_info *fb_info)
 				       fb_info->fix.id,
 				       registered_fb[i]->fix.id);
 				unregister_framebuffer(registered_fb[i]);
-				break;
 			}
 		}
 	}
-- 
1.6.5.2

