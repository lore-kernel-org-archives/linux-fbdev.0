From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 08 Mar 2003 08:58:41 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047084988.2388.4.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303061526500.4540-100000@phoenix.infradead.org>	<3E688BDA.80
	 80506@winischhofer.net> <1047045694.1310.6.camel@localhost.localdomain>
	<3E68B895.2080500@winischhofer.net>
	<1047067923.1226.26.camel@localhost.localdomain> 
	<3E69065D.3090706@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rSes-00087A-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Mar 2003 16:57:50 -0800
In-Reply-To: <3E69065D.3090706@winischhofer.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: James Simmons <jsimmons@infradead.org>, Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-03-08 at 04:51, Thomas Winischhofer wrote:
> I don't see why this is simpler, but I do see it wastes a lot of screen 
> space :)
> 

yep, it'a a typo.

Tony

diff -Naur linux-2.5.64-fbdev/drivers/video/console/fbcon.c linux-2.5.64/drivers/video/console/fbcon.c
--- linux-2.5.64-fbdev/drivers/video/console/fbcon.c	2003-03-07 15:03:06.000000000 +0000
+++ linux-2.5.64/drivers/video/console/fbcon.c	2003-03-08 00:49:09.000000000 +0000
@@ -1044,6 +1044,7 @@
 		vc->vc_rows = nr_rows;
 	}
 	p->vrows = info->var.yres_virtual / vc->vc_font.height;
+	p->vrows -= info->var.yres/h - vc->vc_rows;
 	if ((info->var.yres % vc->vc_font.height) &&
 	    (info->var.yres_virtual % vc->vc_font.height <
 	     info->var.yres % vc->vc_font.height))
@@ -1821,8 +1822,9 @@
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
 		var.activate = FB_ACTIVATE_NOW;
 		fb_set_var(&var, info);
-		p->vrows = info->var.yres_virtual/fh;
 	}
+	p->vrows = info->var.yres_virtual/fh;
+	p->vrows -= (info->var.yres + (fh - 1))/fh - vc->vc_rows;
 	return 0;
 }
 
@@ -2094,6 +2096,7 @@
 		/* reset wrap/pan */
 		info->var.xoffset = info->var.yoffset = p->yscroll = 0;
 		p->vrows = info->var.yres_virtual / h;
+		p->vrows -= info->var.yres/h - vc->vc_rows;
 		if ((info->var.yres % h)
 		    && (info->var.yres_virtual % h < info->var.yres % h))
 			p->vrows--;



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
