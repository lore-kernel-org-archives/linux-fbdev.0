From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [BK updates]
Date: 09 Mar 2003 06:02:57 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047160856.1211.72.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303080024130.20304-100000@phoenix.infradead.org> 
	<1047087608.2389.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rmPs-0003kC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 08 Mar 2003 14:03:41 -0800
In-Reply-To: <1047087608.2389.31.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, 2003-03-08 at 09:46, Antonino Daplas wrote:
> On Sat, 2003-03-08 at 08:26, James Simmons wrote:
> > 
> > Hi folks!!!
> > 
> >   More updates. Lots of fixes in drivers and in the upper layers. Its 
> > starting to really shape up. You can get the standard diff at
> > 
> 
> James, 
> 
> The ff. code is not totally correct:
> 

James, can you apply this?  Code logic is retained, it just simplifies
the calculations, removed unnecessary conditionals, and used
info->var.yres instead of var.yres.

Tony

diff -Naur linux-2.5.64-fbdev/drivers/video/console/fbcon.c linux-2.5.64/drivers/video/console/fbcon.c
--- linux-2.5.64-fbdev/drivers/video/console/fbcon.c	2003-03-08 21:33:25.000000000 +0000
+++ linux-2.5.64/drivers/video/console/fbcon.c	2003-03-08 21:47:26.000000000 +0000
@@ -1044,9 +1044,7 @@
 		vc->vc_rows = nr_rows;
 	}
 	p->vrows = info->var.yres_virtual / vc->vc_font.height;
-	if(info->var.yres > (vc->vc_font.height * (vc->vc_rows + 1))) {
-		p->vrows -= (info->var.yres - (vc->vc_font.height * vc->vc_rows)) / vc->vc_font.height;
-	}
+	p->vrows -= info->var.yres/vc->vc_font.height - vc->vc_rows;
 	if ((info->var.yres % vc->vc_font.height) &&
 	    (info->var.yres_virtual % vc->vc_font.height <
 	     info->var.yres % vc->vc_font.height))
@@ -1825,9 +1823,8 @@
 		var.activate = FB_ACTIVATE_NOW;
 		fb_set_var(&var, info);
 	}
-	p->vrows = var.yres_virtual/fh;
-	if(var.yres > (fh * (height + 1)))
-		p->vrows -= (var.yres - (fh * height)) / fh;
+	p->vrows = info->var.yres_virtual/fh;
+	p->vrows -= (info->var.yres + (fh - 1))/fh - height;
 	return 0;
 }
 
@@ -2099,11 +2096,7 @@
 		/* reset wrap/pan */
 		info->var.xoffset = info->var.yoffset = p->yscroll = 0;
 		p->vrows = info->var.yres_virtual / h;
-
-#if 0          /* INCOMPLETE - let the console gurus handle this */
-		if(info->var.yres > (h * (vc->vc_rows + 1))
-			p->vrows -= (info->var.yres - (h * vc->vc_rows)) / h;
-#endif
+		p->vrows -= info->var.yres/h  - vc->vc_rows;
 		if ((info->var.yres % h)
 		    && (info->var.yres_virtual % h < info->var.yres % h))
 			p->vrows--;



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
