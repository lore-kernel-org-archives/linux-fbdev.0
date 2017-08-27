From: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
Date: Sun, 27 Aug 2017 13:56:46 +0000
Subject: [PATCH] vgacon, x86/boot: Prevent faulty bootparams.screeninfo from causing harm
Message-Id: <1503842206-30039-1-git-send-email-jschoenh@amazon.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

If a zero for the number of colums or rows manages to slip through,
gotoxy() will underflow vc->vc_pos, causing the next action on the
referenced memory to end with a page fault.

Make the check in vgacon more pessimistic to prevent that. Also change
a similar check in the x86 boot code with a similar problem.

Signed-off-by: Jan H. Sch=C3=B6nherr <jschoenh@amazon.de>
---
Let me know, if I should split this into two patches.

 arch/x86/boot/compressed/misc.c | 3 +--
 drivers/video/console/vgacon.c  | 5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/mis=
c.c
index a0838ab..c14217c 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -116,8 +116,7 @@ void __putstr(const char *s)
 		}
 	}
=20
-	if (boot_params->screen_info.orig_video_mode =3D 0 &&
-	    lines =3D 0 && cols =3D 0)
+	if (lines =3D 0 || cols =3D 0)
 		return;
=20
 	x =3D boot_params->screen_info.orig_x;
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index dc06cb6..445b1dc 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -398,9 +398,8 @@ static const char *vgacon_startup(void)
 #endif
 	}
=20
-	/* boot_params.screen_info initialized? */
-	if ((screen_info.orig_video_mode  =3D 0) &&
-	    (screen_info.orig_video_lines =3D 0) &&
+	/* boot_params.screen_info reasonably initialized? */
+	if ((screen_info.orig_video_lines =3D 0) ||
 	    (screen_info.orig_video_cols  =3D 0))
 		goto no_vga;
=20
--=20
2.3.1.dirty

