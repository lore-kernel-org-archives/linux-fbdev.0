From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] modedb: fix incorrect sync and
 vmode flags for CVT modes
Date: Wed, 28 May 2008 13:56:20 -0700
Message-ID: <20080528135620.5a1ba19d.akpm@linux-foundation.org>
References: <20080528224921.da1f0f15.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1She-0004X9-Re for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 13:57:03 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K1Shd-0005da-Ks
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 13:56:58 -0700
In-Reply-To: <20080528224921.da1f0f15.krzysztof.h1@poczta.fm>
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

On Wed, 28 May 2008 22:49:21 +0200
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> Testing of the tridentfb seems like a good exercise
> for the fbdev layer.

heh.

> +	    memset(&cvt_mode, 0, sizeof(struct fb_videomode));

I think using sizeof(cvt_mode) is better here.  Then the reader doesn't
have to go and hunt down the definition of cvt_mode.  

Or even

--- a/drivers/video/modedb.c~a
+++ a/drivers/video/modedb.c
@@ -582,7 +582,7 @@ int fb_find_mode(struct fb_var_screeninf
 	}
 done:
 	if (cvt) {
-	    struct fb_videomode cvt_mode;
+	    struct fb_videomode cvt_mode = { };
 	    int ret;
 
 	    DPRINTK("CVT mode %dx%d@%dHz%s%s%s\n", xres, yres,
_

however gcc might generate sucky code for that.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
