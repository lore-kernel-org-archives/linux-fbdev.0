From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 09 Mar 2018 16:26:47 +0000
Subject: [GIT PULL] fbdev fix for v4.16-rc5
Message-Id: <5453854.qdYKEQ567K@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180309162650epcas1p117f2feb3b030f08733884288a17cf933@epcas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev fix for v4.16-rc5 (just a single fix to close
kernel data leak in FBIOGETCMAP_SPARC ioctl).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.16-rc5

for you to fetch changes up to 250c6c49e3b68756b14983c076183568636e2bde:

  fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbusfb_ioctl_helper(). (2018-03-07 14:00:34 +0100)

----------------------------------------------------------------
fbdev fix for v4.16-rc5:

- fix kernel data leak in FBIOGETCMAP_SPARC ioctl (Peter Malone)

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      Merge tag 'v4.16-rc4' of git://git.kernel.org/.../torvalds/linux into fbdev-for-next

Peter Malone (1):
      fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().

 drivers/video/fbdev/sbuslib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
index af6fc97..a436d44 100644
--- a/drivers/video/fbdev/sbuslib.c
+++ b/drivers/video/fbdev/sbuslib.c
@@ -122,7 +122,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 		unsigned char __user *ured;
 		unsigned char __user *ugreen;
 		unsigned char __user *ublue;
-		int index, count, i;
+		unsigned int index, count, i;
 
 		if (get_user(index, &c->index) ||
 		    __get_user(count, &c->count) ||
@@ -161,7 +161,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 		unsigned char __user *ugreen;
 		unsigned char __user *ublue;
 		struct fb_cmap *cmap = &info->cmap;
-		int index, count, i;
+		unsigned int index, count, i;
 		u8 red, green, blue;
 
 		if (get_user(index, &c->index) ||


