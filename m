From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 09 Mar 2003 06:03:02 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047160870.1212.73.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303061526500.4540-100000@phoenix.infradead.org>	<3E688BDA.80
	 80506@winischhofer.net>
	<1047045694.1310.6.camel@localhost.localdomain>	<3E68B895.2080500@winischhof
	 er.net>	<1047067923.1226.26.camel@localhost.localdomain>
	<3E69065D.3090706@winischhofer.net>
	<1047084988.2388.4.camel@localhost.localdomain>
	<1047101983.1231.2.camel@localhost.localdomain> 
	<3E69FC34.50703@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rmPx-0003kb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 08 Mar 2003 14:03:46 -0800
In-Reply-To: <3E69FC34.50703@winischhofer.net>
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

On Sat, 2003-03-08 at 22:20, Thomas Winischhofer wrote:
> 
> 
> Continued:  What happens with your solution of the virtual area is only 
> 1.5 times the size of the visible area? Did your check this?
> 
>  >> 	p->vrows = info->var.yres_virtual / vc->vc_font.height;
>  >>+	p->vrows -= info->var.yres/vc->vc_font.height - vc->vc_rows;
> 
> yres = 768
> yres_virtual = 1152
> fontheight= 16
> rows = 48
> 
> vrows = 1152 / 16 = 72
> 72 - (768 / 16) - 48 = -24
> 
> :) Any question?
> 
Why?

Your example - 1024x768, yres_virtual = 1152, font = 8x16

2 cases:  

1. full screeen console
vc->vc_rows = 48

p->vrows = 72 - (768/16 - 48)
p->vrows = 72 - 0
p->vrows = 72

2. half-height console:
vc->vc_rows = 24

p->vrows = 1152 - (768/16 - 24)
p->vrows = 72 - 24
p->vrows = 48

Second case, 24 rows are wasted, why? See accel_clear_margins:

ch = vc->vc_font_height
bh =  yres - (vc->vc_rows * ch)
bh = 768 - (24 * 16)
bh = 768 - 384
bh = 384

This means that a rectangle of height 384 scanlines (_always_) at the
bottom of the display will be cleared .  If you pan to the end of
graphics memory, attempting to clear from yres_virtual + 384 will cause
the chipset to crash.  But it won't because we reserved 24 rows (384
pixels) to accomodate this.

For the clincher, this is your code:

if(info->var.yres > (vc->vc_font.height * (vc->vc_rows + 1))) {
	p->vrows -= (info->var.yres - (vc->vc_font.height * 		    
vc->vc_rows)) / vc->vc_font.height;
}

Simplifying the second line....

p->vrows -= (info->var.yres/vc->vc_font.height) - (vc->vc_font.height *
vc->vc_rows)/vc->vc_font.height;
p->vrows -= info->var.yres/vc->vc_font.height - vc->vc_rows;

Do you recognize the last line?  Yep, it's mine. It's also simpler (1
division and 1 subtraction vs 1 division, 1 multiplication and 1
subtraction). 

Code correctness was never the issue.  The only thing I'm questioning is
using info->var.yres instead of var.yres, and I have explained this
enough times already. 

Granted, the patch I submitted was a quickwrite, never meant to be
applied but serves only to illustrate.  This is a more proper patch,
applied against James latest fbdev.diff.  It simplifies the equation,
remove the unnecessary 'if' conditional.  Apply it, don't apply it, I
don't care.

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
