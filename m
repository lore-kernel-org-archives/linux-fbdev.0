From: James Simmons <jsimmons@infradead.org>
Subject: Re: radeonfb compile errors in 2.5.32
Date: Tue, 27 Aug 2002 23:15:24 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <30316.2370379598$1030515908@news.gmane.org>
References: <20020827215710.GA6905@taniwha.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from swan.mail.pas.earthlink.net ([207.217.120.123])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17jwCs-0006dz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 27 Aug 2002 23:21:35 -0700
In-Reply-To: <20020827215710.GA6905@taniwha.org>
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
To: Bill Currie <bill@taniwha.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> This is with radeonfb compiled into the kernel. I'm not on the list, so please
> CC any replies to me.
>
> radeonfb.c:605: unknown field `fb_get_fix' specified in initializer
> radeonfb.c:605: warning: initialization from incompatible pointer type
> radeonfb.c:606: unknown field `fb_get_var' specified in initializer
> radeonfb.c:606: warning: initialization from incompatible pointer type
> radeonfb.c: In function `radeon_set_dispsw':
> radeonfb.c:1385: structure has no member named `type'
> radeonfb.c:1386: structure has no member named `type_aux'
> radeonfb.c:1387: structure has no member named `ypanstep'
> radeonfb.c:1388: structure has no member named `ywrapstep'
> radeonfb.c:1397: structure has no member named `visual'
> radeonfb.c:1398: structure has no member named `line_length'
> [snip repeats]
> radeonfb.c:2487: warning: `fbcon_radeon8' defined but not used
> radeonfb.c:598: warning: `radeon_read_OF' declared `static' but never defined
> radeonfb.c:1710: warning: `radeonfb_set_cmap' defined but not used
> make[2]: *** [radeonfb.o] Error 1
> make[1]: *** [video] Error 2
> make: *** [drivers] Error 2

This is normal. The framebuffer layer is moving to a new api. The next set
of changes will finish the port over to this new api. Unfortunely it will
break most drivers. It is up to the driver maintainters to update there
drivers.

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
