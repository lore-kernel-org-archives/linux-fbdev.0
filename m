From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 03 Sep 2011 01:29:21 +0000
Subject: [PATCH 2/2] vt: dirty hack
Message-Id: <1315013361-3191-3-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1315013361-3191-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1315013361-3191-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Dave Airlie <airlied@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Bernie Thompson <bernie@plugable.com>, Martin Decky <martin@decky.cz>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

---
 drivers/tty/vt/vt.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index b3915b7..8332004 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3740,7 +3740,6 @@ void do_blank_screen(int entering_gfx)
 		hide_cursor(vc);
 		save_screen(vc);
 		vc->vc_sw->con_blank(vc, -1, 1);
-		console_blanked = fg_console + 1;
 		blank_state = blank_off;
 		set_origin(vc);
 		return;
@@ -3752,7 +3751,6 @@ void do_blank_screen(int entering_gfx)
 
 	/* don't blank graphics */
 	if (vc->vc_mode != KD_TEXT) {
-		console_blanked = fg_console + 1;
 		return;
 	}
 
@@ -3795,7 +3793,7 @@ void do_unblank_screen(int leaving_gfx)
 	WARN_CONSOLE_UNLOCKED();
 
 	ignore_poke = 0;
-	if (!console_blanked)
+	if (!console_blanked && !leaving_gfx)
 		return;
 	if (!vc_cons_allocated(fg_console)) {
 		/* impossible */
-- 
1.6.3.2

