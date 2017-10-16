From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 16 Oct 2017 19:04:46 +0000
Subject: [PATCH 0/8] video: fbdev: au1200fb: Fix error handling path of 'au1200fb_drv_probe()'
Message-Id: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

This patch serie tries to fix several issues found in the error handling
code of 'au1200fb_drv_probe()'.
The 5 first patches fixes various issues (double free, missing error code,
un-released resources on error, incorrect IRQ releasing and incomplete
error handling path)

The 3 last patches are just cleanups.


I've spilt the serie in 8 steps that look logical to me. They could
also be merged together if preferred.


These patches are provided as-is and ARE NOT even compile-tested (sorry in
advance if a patch is broken) because I don't have a cross compiler for MIPS
and won't install one.


This serie already goes further that the fixes I usually provide, so
please excuse me if I missed something or if it is somehow broken and/or
incomplete.

---
V1 previously posted is patch 3/8 of this serie

Christophe JAILLET (8):
  video: fbdev: au1200fb: Fix a potential double free
  video: fbdev: au1200fb: Return an error code if a memory allocation
    fails
  video: fbdev: au1200fb: Release some resources if a memory allocation
    fails
  video: fbdev: au1200fb: Fix error handling path
  video: fbdev: au1200fb: Fix error handling path
  video: fbdev: au1200fb: Remove some dead code
  video: fbdev: au1200fb: Propagate an error code
  video: fbdev: au1200fb: Style clean up

 drivers/video/fbdev/au1200fb.c | 43 ++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

-- 
2.11.0

