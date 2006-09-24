From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Fw: [Bugme-new] [Bug 7189] New:
 Inconsistent /proc/fb behavior
Date: Sun, 24 Sep 2006 12:31:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0609241221410.24615@anakin>
References: <20060922194700.c581fa72.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRRGr-0003Ic-Ka for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Sep 2006 03:31:37 -0700
Received: from hoboe2bl1.telenet-ops.be ([195.130.137.73])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GRRGq-0005f8-VZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Sep 2006 03:31:37 -0700
In-Reply-To: <20060922194700.c581fa72.akpm@osdl.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: jurij@wooyd.org
Cc: Andrew Morton <akpm@osdl.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 22 Sep 2006, Andrew Morton wrote:
> Begin forwarded message:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=7189
> 
>            Summary: Inconsistent /proc/fb behavior
>     Kernel Version: 2.6.17.13
>             Status: NEW
>           Severity: normal
>              Owner: jsimmons@infradead.org
>          Submitter: jurij@wooyd.org
> 
> 
> Distribution: Debian unstable
> Hardware environment: Sparc Ultra60 workstation
> 
> Problem Description:
> It appears that the function fbmem_read_proc, which serves as a backend for the
> /proc/fb file, has a problem. When constructing the list of available frame
> buffers to return to the user, it uses the following for-cycle;
> 
> for (fi = registered_fb; fi < &registered_fb[FB_MAX] && len < 4000; fi++)
> 
> Here len is the parameter passed to the function, that it the amount of data the
> user is requesting from the file. So if the user requests a chunk larger than
> 4000 bytes, nothing is returned, leading to the peculiar behaviour described below.
> 
> Steps to reproduce:
> 
> $ cat /proc/fb
> 0 Creator 3D
> 
> This works fine, because strace shows that cat is reading data in 1024-byte chunks:
> [..]
> read(3, "0 Creator 3D\n", 1024)         = 13
> 
> OTOH, grep is reading data in 32kB chunks:
> [..]
> read(3, "", 32768)                      = 0
> 
> so the command 'grep Creator /proc/fb' returns nothing (quite unexpectingly). I
> suspect that for-loop should have 'clen' rather than 'len', the local variable
> which tracks the size of the buffer (even though I am not sure why one would
> want to impose a 4000 byte limit here).

I guess it should check `clen', not `len'. Can you please try this
patch? It should apply to 2.4.34-pre3, too.

[PATCH] Correct buffer size limit in fbmem_read_proc()

Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.18/drivers/video/fbmem.c.orig	2006-09-04 11:02:45.000000000 +0200
+++ linux-2.6.18/drivers/video/fbmem.c	2006-09-24 12:17:07.000000000 +0200
@@ -554,7 +554,8 @@ static int fbmem_read_proc(char *buf, ch
 	int clen;
 
 	clen = 0;
-	for (fi = registered_fb; fi < &registered_fb[FB_MAX] && len < 4000; fi++)
+	for (fi = registered_fb; fi < &registered_fb[FB_MAX] && clen < 4000;
+	     fi++)
 		if (*fi)
 			clen += sprintf(buf + clen, "%d %s\n",
 				        (*fi)->node,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
