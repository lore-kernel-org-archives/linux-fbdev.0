From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: Re: 2.5 offb breakage
Date: Wed, 31 Jul 2002 11:00:19 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207311049150.13905-100000@www.transvirtual.com>
References: <20020731174249.19410@192.168.4.1>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Zxlp-0003BJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 31 Jul 2002 11:00:25 -0700
In-Reply-To: <20020731174249.19410@192.168.4.1>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


> I have fixed that for a long time or it wouldn't link anyway...

I have teh fix to push to linus soon.

> So if I don't have CONFIG_FBCON_ACCEL, it dies in fbcon_setup because
> dispsw is not set,

Correct. I should have it set to fbcon_dummy instead. Added fix to BK
repository.

> if I have CONFIG_FBCON_ACCEL set, it dies in cfb_imageblt,
> I think it's display->fb_info that is null, but I have to dbl check.

I think it might be a memset issue. Try this patch.

--- /usr/src/linus-2.5/drivers/video/offb.c	Tue Jul 30 22:55:24 2002
+++ offb.c	Wed Jul 31 10:43:33 2002
@@ -82,17 +82,15 @@
 			 unsigned long address, struct device_node *dp);

 static struct fb_ops offb_ops = {
-	owner:		THIS_MODULE,
-	fb_get_fix:	gen_get_fix,
-	fb_get_var:	gen_get_var,
-	fb_set_var:	gen_set_var,
-	fb_get_cmap:	gen_get_cmap,
-	fb_set_cmap:	gen_set_cmap,
-	fb_setcolreg:	offb_setcolreg,
-	fb_blank:	offb_blank,
-	fb_fillrect:	cfb_fillrect,
-	fb_copyarea:	cfb_copyarea,
-	fb_imageblit:	cfb_imageblit,
+	.owner		= THIS_MODULE,
+	.fb_set_var	= gen_set_var,
+	.fb_get_cmap	= gen_get_cmap,
+	.fb_set_cmap	= gen_set_cmap,
+	.fb_setcolreg	= offb_setcolreg,
+	.fb_blank	= offb_blank,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
 };

     /*
@@ -399,7 +397,7 @@
 	struct fb_fix_screeninfo *fix;
 	struct fb_var_screeninfo *var;
 	struct fb_info *info;
-	int i;
+	int size, i;

 	if (!request_mem_region(res_start, res_size, "offb"))
 		return;
@@ -414,14 +412,15 @@
 		return;
 	}

-	info =
-	    kmalloc(sizeof(struct fb_info) + sizeof(struct display) +
-		    sizeof(u32) * 17, GFP_ATOMIC);
+	size = sizeof(struct fb_info) + sizeof(struct display) + sizeof(u32) * 17;
+
+	info = kmalloc(size, GFP_ATOMIC);
+
 	if (info == 0) {
 		release_mem_region(res_start, res_size);
 		return;
 	}
-	memset(info, 0, sizeof(*info));
+	memset(info, 0, size);

 	fix = &info->fix;
 	var = &info->var;

> Why would you kill the fbcon-cfg stuffs ? That would mean making
> CONFIG_FBCON_ACCEL not to be an option then. Or simple framebuffers like
> offb wouldn't work.

The goal is to eventually move fbcon_accel into the upper framebuffer
console layer. What we want to do is move all the console code out of
every fbdev driver into fbcon.c. This will allow fbdev to exist without
fbcon. This will be allow for smaller kernels which is needed by resource
constrant handheld devices.

The problem is that over the years the limitations of the console system
have been handled on the drivers side. Now I reworking the upper layers so
the low end drivers can be really really simple. You can see the
difference with the tdfx driver or example. It had  60% code size
reduction. 60% !!!!!




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
