From: Fabian Frederick <fabf@skynet.be>
Date: Wed, 17 Sep 2014 19:00:13 +0000
Subject: [PATCH 0/6] video: fbdev: use container_of where possible
Message-Id: <1410980419-5326-1-git-send-email-fabf@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Small patchset using container_of instead of casting on first structure member address.

Fabian Frederick (6):
  video: fbdev: stifb.c: use container_of to resolve stifb_info from fb_info
  video: fbdev: sa1100fb.c: use container_of to resolve sa1100fb_info from fb_info
  video: fbdev: controlfb.c: use container_of to resolve fb_info_control from fb_info
  video: fbdev: cyber2000fb.c: use container_of to resolve cfb_info from fb_info
  video: fbdev: pxafb.c: use container_of to resolve pxafb_info/layer from fb_info
  video: fbdev: valkyriefb.c: use container_of to resolve fb_info_valkyrie from fb_info

 drivers/video/fbdev/controlfb.c   | 15 ++++++++++-----
 drivers/video/fbdev/cyber2000fb.c | 16 ++++++++--------
 drivers/video/fbdev/pxafb.c       | 20 ++++++++++----------
 drivers/video/fbdev/sa1100fb.c    | 18 ++++++++++++------
 drivers/video/fbdev/stifb.c       |  4 ++--
 drivers/video/fbdev/valkyriefb.c  | 12 ++++++++----
 6 files changed, 50 insertions(+), 35 deletions(-)

-- 
2.1.0

