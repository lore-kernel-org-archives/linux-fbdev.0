From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: problem with gen_update_var
Date: Mon, 17 Jun 2002 13:38:49 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0206171335050.31825-100000@www.transvirtual.com>
References: <1024343964.14222.0.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17K3H5-0006fv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Jun 2002 13:38:55 -0700
In-Reply-To: <1024343964.14222.0.camel@daplas>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


> In ywrap_up in fbcon.c, it has this code:
>
>     p->var.xoffset = 0;
>     p->var.yoffset = p->yscroll*fontheight(p);
>     p->var.vmode |= FB_VMODE_YWRAP;
>     p->fb_info->updatevar(unit, p->fb_info);
>
> (*p is struct display).  gen_update_var will call pan_display(info->var,
> con, info).

Only if con == currcon.

> But as can be seen, info->var is not updated by ywrap_up.

Your right. I will fix that.

> Unless, the low-level driver's implementation is to get the offsets
> from fb_display[con].var, that's the only time it will work.  But it
> will break userland apps that will call pan_display(var, con, info)
> expecting that the offsets contained in the passed var parameter will be
> updated.

Don't worry about userland apps. They can't pan non foreground consoles.
Only fbcon inside the kernel can.


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
