From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: fb_pan_display
Date: Sun, 3 Nov 2002 03:25:07 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021103022507.GE10610@ppc.vc.cvut.cz>
References: <Pine.LNX.4.33.0211010908390.6296-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from p0050.as-l042.contactel.cz ([194.108.237.50] helo=ppc.vc.cvut.cz)
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 188AS8-0004FY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 02 Nov 2002 18:25:29 -0800
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Nov 01, 2002 at 09:11:08AM -0800, James Simmons wrote:
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

Hm, do not YWRAP devices need this

          if (xoffset < 0 || yoffset < 0 ||
              xoffset >= info->var.xres_virtual ||
              yoffset >= info->var.yres_virtual) {

instead?

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

Somebody has to check whether FB_VMODE_YWRAP is supported
by this hardware at all (i.e. var.vmode should already
contain FB_VMODE_YWRAP bit set from previous set_var, should
not it?).
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
