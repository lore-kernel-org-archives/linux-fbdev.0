From: Sasha Levin <sashal@kernel.org>
Date: Sat, 01 Jun 2019 13:14:41 +0000
Subject: [PATCH AUTOSEL 5.1 065/186] fbcon: Don't reset logo_shown when logo is currently shown
Message-Id: <20190601131653.24205-65-sashal@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190601131653.24205-1-sashal@kernel.org>
In-Reply-To: <20190601131653.24205-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Andreas Schwab <schwab@linux-m68k.org>, Prarit Bhargava <prarit@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, Kees Cook <keescook@chromium.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Thierry Reding <treding@nvidia.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sasha Levin <sashal@kernel.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

From: Andreas Schwab <schwab@linux-m68k.org>

[ Upstream commit 3c5a1b111373e669c8220803464c3a508a87e254 ]

When the logo is currently drawn on a virtual console, and the console
loglevel is reduced to quiet, logo_shown must be left alone, so that it
the scrolling region on that virtual console is properly reset.

Fixes: 10993504d647 ("fbcon: Silence fbcon logo on 'quiet' boots")
Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Marko Myllynen <myllynen@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <treding@nvidia.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index cd059a801662e..786f9aab55df6 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1069,7 +1069,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 
 	cap = info->flags;
 
-	if (console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
+	if (logo_shown < 0 && console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
 		logo_shown = FBCON_LOGO_DONTSHOW;
 
 	if (vc != svc || logo_shown = FBCON_LOGO_DONTSHOW ||
-- 
2.20.1
