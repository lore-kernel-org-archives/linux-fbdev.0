From: Antonino Daplas <adaplas@pol.net>
Subject: Re: problem with gen_update_var
Date: 18 Jun 2002 03:58:41 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1024343964.14222.0.camel@daplas>
References: <Pine.LNX.4.44.0206171224150.31825-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17K2bL-0000or-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Jun 2002 12:55:47 -0700
In-Reply-To: <Pine.LNX.4.44.0206171224150.31825-100000@www.transvirtual.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@transvirtual.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2002-06-18 at 03:27, James Simmons wrote:
> 
> > Hi,
> >
> > gen_update_var will break panning/wrapping since it passes info->var to
> > fb_pan_display.  However, fbcon updates display->var.
> 
> It works. The var info struct fb_info is always the foreground console.
> Notice gen_update_var is only called when it is the foreground console.
> 
> 
In ywrap_up in fbcon.c, it has this code:

    p->var.xoffset = 0;
    p->var.yoffset = p->yscroll*fontheight(p);
    p->var.vmode |= FB_VMODE_YWRAP;
    p->fb_info->updatevar(unit, p->fb_info);

(*p is struct display).  gen_update_var will call pan_display(info->var,
con, info).  But as can be seen, info->var is not updated by ywrap_up.  

Unless, the low-level driver's implementation is to get the offsets 
from fb_display[con].var, that's the only time it will work.  But it
will break userland apps that will call pan_display(var, con, info)
expecting that the offsets contained in the passed var parameter will be
updated.

Tony


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
