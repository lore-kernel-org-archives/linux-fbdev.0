From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/4] i810fb: Fix oops if CONFIG_FB_I810_I2C is set to no
Date: Mon, 12 Sep 2005 09:13:32 +0800
Message-ID: <4324D63C.9070407@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EEd0Q-00042v-8p
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Sep 2005 18:21:10 -0700
Received: from zproxy.gmail.com ([64.233.162.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EEd0O-0007Bn-PV
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Sep 2005 18:21:10 -0700
Received: by zproxy.gmail.com with SMTP id i11so168145nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 11 Sep 2005 18:21:01 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Reported by: Manuel Lauss <mano@roarinelk.homelinux.net>

compiled with CONFIG_FB_I810_I2C = n and CONFIG_FB_I810 = y
it oopses at boot in file drivers/video/i810/i810_main.c:1884

...
Unable to handle kernel NULL pointer dereference at virtual address 00000054
printing eip:
c02543c0
*pde = 00000000
Oops: 0000 [#1]
last sysfs file:
Modules linked in:
CPU:    0
EIP:    0060:[<c02543c0>]    Not tainted VLI
EFLAGS: 00010286   (2.6.13-mm2)
EIP is at i810fb_find_init_mode+0x53/0x93
eax: c113ddd4   ebx: c1194000   ecx: c04be2dd   edx: c1194000
esi: c1194008   edi: c113ddd4   ebp: c1194240   esp: c113ddcc
ds: 007b   es: 007b   ss: 0068

struct fb_monspecs *specs is initialized to NULL causing the oops.

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 i810_main.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -950,7 +950,7 @@ static int i810_check_params(struct fb_v
 			     struct fb_info *info)
 {
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
-	int line_length, vidmem, mode_valid = 0;
+	int line_length, vidmem, mode_valid = 0, retval = 0;
 	u32 vyres = var->yres_virtual, vxres = var->xres_virtual;
 	/*
 	 *  Memory limit
@@ -1026,10 +1026,11 @@ static int i810_check_params(struct fb_v
 			printk("i810fb: invalid video mode%s\n",
 			       default_sync ? "" : ". Specifying "
 			       "vsyncN/hsyncN parameters may help");
+			retval = -EINVAL;
 		}
 	}
 
-	return 0;
+	return retval;
 }	
 
 /**
@@ -1830,7 +1831,7 @@ static void __devinit i810fb_find_init_m
 {
 	struct fb_videomode mode;
 	struct fb_var_screeninfo var;
-	struct fb_monspecs *specs = NULL;
+	struct fb_monspecs *specs = &info->monspecs;
 	int found = 0;
 #ifdef CONFIG_FB_I810_I2C
 	int i;
@@ -1853,12 +1854,11 @@ static void __devinit i810fb_find_init_m
 	if (!err)
 		printk("i810fb_init_pci: DDC probe successful\n");
 
-	fb_edid_to_monspecs(par->edid, &info->monspecs);
+	fb_edid_to_monspecs(par->edid, specs);
 
-	if (info->monspecs.modedb == NULL)
+	if (specs->modedb == NULL)
 		printk("i810fb_init_pci: Unable to get Mode Database\n");
 
-	specs = &info->monspecs;
 	fb_videomode_to_modelist(specs->modedb, specs->modedb_len,
 				 &info->modelist);
 	if (specs->modedb != NULL) {



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
