From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: atafb: fix regression with uninitalized fb_info->mm_lock mutex
Date: Tue, 7 Jul 2009 19:15:16 +0200
Message-ID: <20090707191516.6451f936.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757403AbZGGRFq@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, a.p.zijlstra@chello.nl, rjw@sisk.pl, stable@kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove redundant locking of the fb_info->mm_lock mutex before the frambuffe=
r=20
is registered.

This fixes a problem with uninitialized the fb_info->mm_lock mutex introduc=
ed=20
by the commit 537a1bf059f " fbdev: add mutex for fb_mmap locking"

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff --git a/drivers/video/atafb.c b/drivers/video/atafb.c
index 497ff8a..8cd279b 100644
--- a/drivers/video/atafb.c
+++ b/drivers/video/atafb.c
@@ -2405,6 +2405,9 @@ static int do_fb_set_var(struct fb_var_screeninfo *va=
r, int isactive)
 	return 0;
 }
=20
+/* fbhw->encode_fix() must be called with fb_info->mm_lock held
+ * if it is called after the register_framebuffer() - not a case here
+ */
 static int atafb_get_fix(struct fb_fix_screeninfo *fix, struct fb_info *in=
fo)
 {
 	struct atafb_par par;
@@ -2414,9 +2417,7 @@ static int atafb_get_fix(struct fb_fix_screeninfo *fi=
x, struct fb_info *info)
 	if (err)
 		return err;
 	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	mutex_lock(&info->mm_lock);
 	err =3D fbhw->encode_fix(fix, &par);
-	mutex_unlock(&info->mm_lock);
 	return err;
 }
=20

----------------------------------------------------------------------
Ubezpieczenie komunikacyjne wraz z ubezpieczeniem=20
kosztow leczenia za granic=B1. http://link.interia.pl/f222b
