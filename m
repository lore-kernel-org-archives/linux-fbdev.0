From: "Alex Stewart" <alex@foogod.com>
Subject: Re: [PATCH] neofb patches
Date: Sat, 24 Apr 2004 10:29:20 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <60004.64.139.3.221.1082827760.squirrel@www.foogod.com>
References: <56202.64.139.3.221.1082702638.squirrel@www.foogod.com>
        <Pine.LNX.4.44.0404232241260.5826-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BHQy6-0002kt-EV
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 24 Apr 2004 10:29:34 -0700
Received: from adsl-209-182-168-213.value.net ([209.182.168.213] helo=firestar.foogod.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BHQy6-0002Hs-1m
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 24 Apr 2004 10:29:34 -0700
In-Reply-To: <Pine.LNX.4.44.0404232241260.5826-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: jsimmons@infradead.org
Cc: alex@foogod.com, linux-fbdev-devel@lists.sourceforge.net, geert@linux-m68k.org, linux-kernel@vger.kernel.org

> Got it. I merged your patches.

Umm, I would really appreciate it if you didn't silently leave out bits of
my patches and then just say "I merged your patches".  It took me a little
bit to figure out that the reason panning now isn't used for fbconsole
scrolls is because you just didn't bother to put that part of my patch in.

Is there some reason you left out the following piece of my modedb patch?

+       /* Turn on panning for console scroll by default */
+       info->var.yres_virtual = 30000;
+       info->var.accel_flags |= FB_ACCELF_TEXT;
+       if (neofb_check_var(&info->var, info))
+               goto err_map_video;

-alex




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
