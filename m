From: James Simmons <jsimmons@infradead.org>
Subject: fb_pan_display
Date: Fri, 1 Nov 2002 09:11:08 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211010908390.6296-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from conure.mail.pas.earthlink.net ([207.217.120.54])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 187eUV-0005RF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 01 Nov 2002 08:17:47 -0800
Received: from pool0547.cvx24-bradley.dialup.earthlink.net ([209.179.212.37])
	by conure.mail.pas.earthlink.net with esmtp (Exim 3.33 #1)
	id 187eUS-00049S-00
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Nov 2002 08:17:45 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi!

  Looking at the last bits of the fbdev changes I have question. Currently
I have in fbgen.c:

int fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
{
        int xoffset = var->xoffset;
        int yoffset = var->yoffset;
        int err;

        if (xoffset < 0 || yoffset < 0 ||
            xoffset + info->var.xres > info->var.xres_virtual ||
            yoffset + info->var.yres > info->var.yres_virtual)
                return -EINVAL;
        if (info->fbops->fb_pan_display) {
                if ((err = info->fbops->fb_pan_display(var, info)))
                        return err;
                else
                        return -EINVAL;
        }
        info->var.xoffset = var->xoffset;
        info->var.yoffset = var->yoffset;
        if (var->vmode & FB_VMODE_YWRAP)
                info->var.vmode |= FB_VMODE_YWRAP;
        else
                info->var.vmode &= ~FB_VMODE_YWRAP;
        return 0;
}

Now what I was wondering are these test standard enough that we coudl call
this instead of info->fb_ops->fb_pan_display. Several drivers have this
test so it would me more code reduction.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
