From: James Simmons <jsimmons@infradead.org>
Subject: Re: gen_set_var() fix?
Date: Wed, 28 Aug 2002 11:14:03 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208281111210.1459-100000@maxwell.earthlink.net>
References: <20020828100048.2dde942e.jani@iv.ro>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17k7QE-0006Ol-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Aug 2002 11:20:06 -0700
In-Reply-To: <20020828100048.2dde942e.jani@iv.ro>
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
To: Jani Monoses <jani@iv.ro>
Cc: linux-fbdev-devel@lists.sourceforge.net


> James
> Should't gen_set_var set the var in info here as well? (when no check_var present)

No. The first test is to see if the passed in var is equal to the current
var in info. Note info->var is always set before we call gen_set_var. The
next set is check if xxfb_check_var is there. If this function is lacking
then we know the hardware supports a static mode. Then it just returns the
defualt var which is set before we call gen_set_var.

> BTW is gen_set_var going to stay in the new API or go away ?

It is to stay. It will be intergrated into fbmem.c once we are done.

> --- fbgen.c.orig       Wed Aug 28 09:49:45 2002
> +++ fbgen.c     Wed Aug 28 09:57:32 2002
> @@ -36,7 +36,7 @@
>
>         if (con < 0 || (memcmp(&info->var, var, sizeof(struct fb_var_screeninfo)))) {
>                 if (!info->fbops->fb_check_var) {
> -                       *var = info->var;
> +                       info->var = *var;
>                         return 0;
>                 }



MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
