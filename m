From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Sun, 25 Apr 2004 01:55:15 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404250138120.15965-100000@phoenix.infradead.org>
References: <60004.64.139.3.221.1082827760.squirrel@www.foogod.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BHXvX-0004LV-A7
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 24 Apr 2004 17:55:23 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BHXvW-0003T1-NV
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 24 Apr 2004 17:55:23 -0700
In-Reply-To: <60004.64.139.3.221.1082827760.squirrel@www.foogod.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Stewart <alex@foogod.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, geert@linux-m68k.org, linux-kernel@vger.kernel.org


> Umm, I would really appreciate it if you didn't silently leave out bits of
> my patches and then just say "I merged your patches".  It took me a little
> bit to figure out that the reason panning now isn't used for fbconsole
> scrolls is because you just didn't bother to put that part of my patch in.
> 
> Is there some reason you left out the following piece of my modedb patch?
> 
> +       /* Turn on panning for console scroll by default */
> +       info->var.yres_virtual = 30000;
> +       info->var.accel_flags |= FB_ACCELF_TEXT;
> +       if (neofb_check_var(&info->var, info))
> +               goto err_map_video;

   The reason is because fb_find_mode calls check_var for us. No reason to 
call it twice. The large yres_virtual being 30000 that is not needed any 
longer. The accel flag is set in neofb_check_var. The current test is

if (var->bits_per_pixel >= 24 || !par->neo2200)
	var->accel_flags &= ~FB_ACCEL_TEXT;

Should we drop the bpp >= 24 test? Do you observe this problem at all 
depths.








-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
