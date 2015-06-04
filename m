From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 04 Jun 2015 16:44:45 +0000
Subject: [PATCH v4 0/3] vesafb: remove theoretical MTRR uses
Message-Id: <1433436288-16792-1-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: plagnioj@jcrosoft.com, bp@suse.de, hpa@zytor.com, linux-fbdev@vger.kernel.org, luto@amacapital.net, toshi.kani@hp.com, sbsiddha@gmail.com, mingo@elte.hu, tglx@linutronix.de, jgross@suse.com, daniel.vetter@ffwll.ch, airlied@redhat.com, adaplas@gmail.com, robdclark@gmail.com, jg1.han@samsung.com, wsa@the-dreams.de, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Tomi,

This v4 fixes the issue of the use of the old use of
info->par for the pseudo_palette and our need to extend
it for the MTRR cookie by extending our proposed new
struct vesafb_par with the pseudo_palette and later
pointing info->pseudo_palette to it. This also means
we can simplify the allocation of the info when calling
framebuffer_alloc() by now just passing the size of our
struct vesafb_par.

Patch 1 is unmodified from v3 series, patch 2 does the
fixes mentioned above, and patch 3 might have small
changes to account for contextual changes.

Luis R. Rodriguez (3):
  video: fbdev: vesafb: only support MTRR_TYPE_WRCOMB
  video: fbdev: vesafb: add missing mtrr_del() for added MTRR
  video: fbdev: vesafb: use arch_phys_wc_add()

 drivers/video/fbdev/vesafb.c | 80 ++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 52 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty

