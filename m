From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbcon has a empty unimap after boot
Date: Fri, 12 Sep 2003 19:09:18 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309121909100.5017-100000@phoenix.infradead.org>
References: <874qzip8nb.fsf@lexx.delysid.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xsMF-0004sS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 11:09:23 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xsME-0008Jl-PT
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 11:09:23 -0700
In-Reply-To: <874qzip8nb.fsf@lexx.delysid.org>
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
To: Mario Lang <mlang@delysid.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, geert@linux-m68k.org


Thanks. Applying.


On Fri, 12 Sep 2003, Mario Lang wrote:

> Hi.
> 
> I noticed that with 2.6.0 kernels, when using fbcon
> (with the sisfb driver in my case, using a Sis630 card), the
> ioctl GIO_UNIMAP returns a empty unimap.
> This results in problems for BRLTTY[1], which relies
> on a valid unimap to back-translate the font-positions of
> /dev/vcsa to the actual characters used.
> 
> Further digging showed that this problems has probably gone
> unnoticed because there is a special case in
> drivers/char/consolemap.c:conv_uni_to_pc which returns -3 when
> there is no unimap available.  This -3 return value
> is caught in drivers/char/vt.c:do_con_write like this:
> 
>                         tc = conv_uni_to_pc(vc_cons[currcons].d, tc);
>                         ...
>                         } else if ( tc == -3 ) {
>                                 /* Bad hash table -- hope for the best */
>                                 tc = c;
>                         }
> 
> This is why I think the uninitialized unimap did go
> unnoticed, since this code will make things work for
> standard iso-8859 type of charsets.
> 
> However, user space apps which rely on GIO_UNIMAP do not
> work correctly, and in general, I think I18N should be broken
> on fbcon currently.
> 
> I have a very crude patch which works for me here, but I
> am not sure if this is the right way to fix this.
> Anyway, it is attached.  Note that I am very new to
> kernel hacking, so my analysis of the problem might be
> bogus, but I do think I am on the right track...
> 
> --- linux-2.6.0-test4/drivers/video/console/fbcon.c.orig        2003-09-03 15:32:42.000000000 +0200
> +++ linux-2.6.0-test4/drivers/video/console/fbcon.c     2003-09-03 15:27:09.000000000 +0200
> @@ -695,6 +695,7 @@
>                 fb_display[unit].scrollmode = SCROLL_YNOMOVE;
>         else
>                 fb_display[unit].scrollmode = SCROLL_YREDRAW;
> +       con_set_default_unimap(unit);
>         fbcon_set_display(vc, init, !init);
>  }
> 
> 
> [1] http://mielke.cc/brltty/
> 
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
