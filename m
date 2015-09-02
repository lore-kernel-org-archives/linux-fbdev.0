From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 02 Sep 2015 21:23:25 +0000
Subject: [PATCH] uvesafb: make scaling configurable on Nvidia cards
Message-Id: <alpine.LRH.2.02.1509021719170.12073@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1505161334150.19574@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1505161334150.19574@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Januszewski <spock@gentoo.org>
Cc: linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org

[ I sent this some times ago, but didn't get any response ]


Nvidia cards have a BIOS function 0x4f14 that allows to set flat panel
scaling. This patch adds a module parameter "scaling" that uses this
function to set the scaling. By default, the parameter is -1, so that the
driver doesn't attempt to call the scaling function.

This patch is useful when using the binary Nvidia graphics driver - in
that case, the console may be only in text mode or VESA mode. By default,
the video card does scaling that degrades font quality and changes aspect
ratio. This patch makes it possible to turn off the scaling and improve
font quality on the console.

The allowed values depend on VESA BIOS. On my card, the following values
are allowed:
-1	- do not change the scaling
0	- scale to full screen
1, 2	- don't scale
3	- scale and preserve aspect ratio
4	- scale with black border around

Example use:
echo 1 >/sys/module/uvesafb/parameters/scaling; fbset 1280x1024-60 -depth 32 -a
- this sets unscaled 1280x1024 video mode that has much sharper font than
  the scaled modes.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Index: linux-4.0.9/drivers/video/fbdev/uvesafb.c
=================================--- linux-4.0.9.orig/drivers/video/fbdev/uvesafb.c
+++ linux-4.0.9/drivers/video/fbdev/uvesafb.c
@@ -52,6 +52,7 @@ static u16 maxclk;		/* maximum pixel clo
 static u16 maxvf;		/* maximum vertical frequency */
 static u16 maxhf;		/* maximum horizontal frequency */
 static u16 vbemode;		/* force use of a specific VBE mode */
+static short scaling = -1;
 static char *mode_option;
 static u8  dac_width	= 6;
 
@@ -1245,7 +1246,22 @@ static int uvesafb_set_par(struct fb_inf
 	task = uvesafb_prep();
 	if (!task)
 		return -ENOMEM;
+
+	if (scaling > 0) {
+		/*
+		 * We must first reset scaling state with 0. This is workaround
+		 * for some supposed BIOS bug - without this, scaling mode 4
+		 * could not be set.
+		 */
+		uvesafb_reset(task);
+		task->t.regs.eax = 0x4f14;
+		task->t.regs.ebx = 0x0102;
+		task->t.regs.ecx = 0;
+		uvesafb_exec(task);
+	}
+
 setmode:
+	uvesafb_reset(task);
 	task->t.regs.eax = 0x4f02;
 	task->t.regs.ebx = mode->mode_id | 0x4000;	/* use LFB */
 
@@ -1296,7 +1312,6 @@ setmode:
 			printk(KERN_WARNING "uvesafb: mode switch failed "
 				"(eax=0x%x, err=%d). Trying again with "
 				"default timings.\n", task->t.regs.eax, err);
-			uvesafb_reset(task);
 			kfree(crtc);
 			crtc = NULL;
 			info->var.pixclock = 0;
@@ -1330,6 +1345,14 @@ setmode:
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 	info->fix.line_length = mode->bytes_per_scan_line;
 
+	if (scaling >= 0) {
+		uvesafb_reset(task);
+		task->t.regs.eax = 0x4f14;
+		task->t.regs.ebx = 0x0102;
+		task->t.regs.ecx = scaling;
+		uvesafb_exec(task);
+	}
+
 out:
 	kfree(crtc);
 	uvesafb_free(task);
@@ -2019,6 +2042,9 @@ MODULE_PARM_DESC(vbemode,
 	"VBE mode number to set, overrides the 'mode' option");
 module_param_string(v86d, v86d_path, PATH_MAX, 0660);
 MODULE_PARM_DESC(v86d, "Path to the v86d userspace helper.");
+module_param(scaling, short, 0660);
+MODULE_PARM_DESC(scaling,
+	"Scaling option for nvidia (0 - scaled, 1 - unscaled centered, 2 - unscaled in left corner");
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Michal Januszewski <spock@gentoo.org>");
Index: linux-4.0.9/Documentation/fb/uvesafb.txt
=================================--- linux-4.0.9.orig/Documentation/fb/uvesafb.txt
+++ linux-4.0.9/Documentation/fb/uvesafb.txt
@@ -128,6 +128,14 @@ v86d:path
         need to use it and have uvesafb built into the kernel, use
         uvesafb.v86d="path".
 
+scaling:n
+	Set scaling on Nvidia cards. Possible values depend on card's BIOS.
+		-1	- do not change the scaling
+		0	- scale to full screen
+		1, 2	- don't scale
+		3	- scale and preserve aspect ratio
+		4	- scale with black border around
+
 Additionally, the following parameters may be provided.  They all override the
 EDID-provided values and BIOS defaults.  Refer to your monitor's specs to get
 the correct values for maxhf, maxvf and maxclk for your hardware.
