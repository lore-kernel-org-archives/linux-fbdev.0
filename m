From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fb_pan_display
Date: 03 Nov 2002 02:43:49 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1036262577.583.3.camel@daplas>
References: <Pine.LNX.4.33.0211010908390.6296-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1883ID-0007Lv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 02 Nov 2002 10:46:45 -0800
In-Reply-To: <Pine.LNX.4.33.0211010908390.6296-100000@maxwell.earthlink.net>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2002-11-02 at 01:11, James Simmons wrote:
> 
> Hi!
> 
>   Looking at the last bits of the fbdev changes I have question. Currently
> I have in fbgen.c:
> 
> int fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
> {
>         int xoffset = var->xoffset;
>         int yoffset = var->yoffset;
>         int err;
> 
>         if (xoffset < 0 || yoffset < 0 ||
>             xoffset + info->var.xres > info->var.xres_virtual ||
>             yoffset + info->var.yres > info->var.yres_virtual)
>                 return -EINVAL;
>         if (info->fbops->fb_pan_display) {
>                 if ((err = info->fbops->fb_pan_display(var, info)))
>                         return err;
>                 else
>                         return -EINVAL;
>         }
>         info->var.xoffset = var->xoffset;
>         info->var.yoffset = var->yoffset;
>         if (var->vmode & FB_VMODE_YWRAP)
>                 info->var.vmode |= FB_VMODE_YWRAP;
>         else
>                 info->var.vmode &= ~FB_VMODE_YWRAP;
>         return 0;
> }
> 
> Now what I was wondering are these test standard enough that we coudl call
> this instead of info->fb_ops->fb_pan_display. Several drivers have this
> test so it would me more code reduction.

Looks generic enough for me.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
