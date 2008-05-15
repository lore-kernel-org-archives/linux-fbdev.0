From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tridentfb: acceleration code
	improvements
Date: Thu, 15 May 2008 15:56:14 -0700
Message-ID: <20080515155614.ca818e04.akpm@linux-foundation.org>
References: <20080514071200.4f2409b0.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JwmN6-0006FL-BN for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 May 2008 15:56:24 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JwmN5-0002AW-3K
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 May 2008 15:56:24 -0700
In-Reply-To: <20080514071200.4f2409b0.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 14 May 2008 07:12:00 +0200
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> This patch brings various acceleration improvements:
> - set  copyarea/fillrect for non-accelerated framebuffer (fix)
> - remove 15 bpp depth handling to simplify code as it hardly 
>   works (15 bpp handling was obviously missing in some switches)
> - add fb_sync call and move waiting before accelerated function
>   to make acceleration more asynchronous to cpu (few % of speed
>   improvement)
> - add cpu_relax() call in waiting loops
> - make longer register names and name more registers
> - move registers' definition to header
> - general code improvements (shortening, simplifying)

checkpatch whines:

ERROR: space required after that ',' (ctx:VxV)
#543: FILE: include/video/trident.h:7:
+#define debug(f,a...)  printk("%s:" f,  __FUNCTION__ , ## a);mdelay(100);
                ^

ERROR: space required after that ';' (ctx:VxV)
#543: FILE: include/video/trident.h:7:
+#define debug(f,a...)  printk("%s:" f,  __FUNCTION__ , ## a);mdelay(100);
                                                             ^

ERROR: Macros with multiple statements should be enclosed in a do - while loop
#543: FILE: include/video/trident.h:7:
+#define debug(f,a...)  printk("%s:" f,  __FUNCTION__ , ## a);mdelay(100);

WARNING: __func__ should be used instead of gcc specific __FUNCTION__
#543: FILE: include/video/trident.h:7:
+#define debug(f,a...)  printk("%s:" f,  __FUNCTION__ , ## a);mdelay(100);


perhaps that's all in your todo somewhere.


Also that macro is plain wrong:

	if (foo)
		debug(...);
	else
		something();

won't compile.  Using the do{...}while(0) thing or perhaps {(...)} will fix.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
