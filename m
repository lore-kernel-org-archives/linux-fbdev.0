From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:02:34 +0000
Subject: [PATCH 03/33] vt: might_sleep() annotation for do_blank_screen
Message-Id: <20190528090304.9388-4-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Adam Borowski <kilobyte@angband.pl>, Martin Hostettler <textshell@uchuujin.de>, Mikulas Patocka <mpatocka@redhat.com>

For symmetry reasons with do_unblank_screen, except without the
oops_in_progress special case.

Just a drive-by annotation while I'm trying to untangle the fbcon vs.
fbdev screen blank/unblank maze.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Adam Borowski <kilobyte@angband.pl>
Cc: Martin Hostettler <textshell@uchuujin.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/tty/vt/vt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index fdd12f8c3deb..bc9813b14c58 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4159,6 +4159,8 @@ void do_blank_screen(int entering_gfx)
 	struct vc_data *vc = vc_cons[fg_console].d;
 	int i;
 
+	might_sleep();
+
 	WARN_CONSOLE_UNLOCKED();
 
 	if (console_blanked) {
-- 
2.20.1
