From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [BK updates]
Date: 08 Mar 2003 09:46:39 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047087608.2389.31.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303080024130.20304-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rTPF-0002b7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Mar 2003 17:45:45 -0800
In-Reply-To: <Pine.LNX.4.44.0303080024130.20304-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, 2003-03-08 at 08:26, James Simmons wrote:
> 
> Hi folks!!!
> 
>   More updates. Lots of fixes in drivers and in the upper layers. Its 
> starting to really shape up. You can get the standard diff at
> 

James, 

The ff. code is not totally correct:

static int fbcon_resize(struct vc_data *vc, unsigned int width, 
			unsigned int height)
{
	struct display *p = &fb_display[vc->vc_num];
	struct fb_info *info = p->fb_info;
	struct fb_var_screeninfo var = info->var;
	int err; int x_diff, y_diff;
	int fw = vc->vc_font.width;
	int fh = vc->vc_font.height;

	var.xres = width * fw;
	var.yres = height * fh;
	x_diff = info->var.xres - var.xres;
	y_diff = info->var.yres - var.yres;
	if (x_diff < 0 || x_diff > fw ||
	   (y_diff < 0 || y_diff > fh)) {
		var.activate = FB_ACTIVATE_TEST;
		err = fb_set_var(&var, info);
		if (err || width > var.xres/fw ||
		    height > var.yres/fh)
			return -EINVAL;
		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
		var.activate = FB_ACTIVATE_NOW;
		fb_set_var(&var, info);
	}
	p->vrows = var.yres_virtual/fh;
	if(var.yres > (fh * (height + 1)))
		p->vrows -= (var.yres - (fh * height)) / fh;
	return 0;
}

I'm getting tired of explaining this repeatedly, so I'll give 2
hypothetical cases:

Case 1:

1. display is at 800x600, fonts are 8x16.
2. console requests width of 100, row of 37, which are computed as
800x592
3. the requested resolution is tested against the actual, and since the
difference between the actual yres (600) and requested yres (592) is
less than a character height, doing an fb_set_var() is skipped.
4. in the last 3 lines, p->vrows is adjusted, but it uses the requested
yres (592) instead of the actual (600).  This part is wrong.

Case 2:

1. again, display is at 800x600, fonts are 8x16
2. console requests width of 128, row of 48, which are computed as
1024x768. 
3. the requested resolution is tested against the actual, and determines
that it needs to do an fb_set_var() because the difference between the
requested and actual dimensions are greater than a character's
dimensions.
4. it first does a check if the resolution is acceptable
(FB_ACTIVATE_TEST).  The hardware supports it, so it passes the test.
5. it then proceeds changing the video mode (FB_ACTIVATE_NOW).  Look at
fb_set_var() in fbmem.c.  Note that the var returned from
xxfb_check_var() is placed in info->var before doing an
xxxfb_set_par().  So upon return, the requested var is the same as the
one in info->var
6. in the last two lines, it does not matter if it uses the requested
yres or the actual yres.  In this case, it will be the same.

So using info->var.yres, instead of var.yres is preferable because
info->var will always be right.  In this specific code, the effect is
probably insignificant, but I hate code that does not do what's
expected.  It might appear as a hard-to-catch bug later on.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
