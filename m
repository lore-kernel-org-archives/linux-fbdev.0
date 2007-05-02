From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 4/8] ps3fb: kill superfluous zero initializations
Date: Wed, 02 May 2007 14:48:34 +0200
Message-ID: <20070502124840.447618000@pademelon.sonytel.be>
References: <20070502124830.911142000@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
Content-Disposition: inline; filename=ps3-stable/ps3fb-zero-init.diff
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: James Simmons <jsimmons@infradead.org>, Antonino Daplas <adaplas@gmail.com>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net

ps3fb: kill superfluous zero initializations

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- ps3-linux-2.6.21.orig/drivers/video/ps3fb.c
+++ ps3-linux-2.6.21/drivers/video/ps3fb.c
@@ -297,10 +297,10 @@ static const struct fb_videomode ps3fb_m
 #define VP_OFF(i)	(WIDTH(i) * Y_OFF(i) * BPP + X_OFF(i) * BPP)
 #define FB_OFF(i)	(GPU_OFFSET - VP_OFF(i) % GPU_OFFSET)
 
-static int ps3fb_mode = 0;
+static int ps3fb_mode;
 module_param(ps3fb_mode, bool, 0);
 
-static char *mode_option __initdata = NULL;
+static char *mode_option __initdata;
 
 
 static int ps3fb_get_res_table(u32 xres, u32 yres)

--
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
