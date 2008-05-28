From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] modedb: fix incorrect sync and
 vmode flags for CVT modes
Date: Wed, 28 May 2008 23:48:25 +0200
Message-ID: <20080528234825.cf241d09.krzysztof.h1@poczta.fm>
References: <20080528224921.da1f0f15.krzysztof.h1@poczta.fm>
	<20080528135620.5a1ba19d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1TTZ-0000zB-QE for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 14:46:29 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K1TTX-0002LX-GM
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 14:46:29 -0700
In-Reply-To: <20080528135620.5a1ba19d.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 28 May 2008 13:56:20 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 28 May 2008 22:49:21 +0200
> Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> 
> > Testing of the tridentfb seems like a good exercise
> > for the fbdev layer.
> 
> heh.
> 
> > +	    memset(&cvt_mode, 0, sizeof(struct fb_videomode));
> 
> I think using sizeof(cvt_mode) is better here.  Then the reader doesn't
> have to go and hunt down the definition of cvt_mode.  
> 

Here it is. Or just modify my previous patch.

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The temporary structure for calculated CVT mode
is not initialized. Few fields have only bits or-ed
or and-ed so they may be left in incorrect (random) state.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-2.6.25/drivers/video/modedb.c linux-new/drivers/video/modedb.c
--- linux-2.6.25/drivers/video/modedb.c	2008-05-27 21:57:38.644359809 +0200
+++ linux-new/drivers/video/modedb.c	2008-05-28 23:38:51.045496496 +0200
@@ -590,6 +590,7 @@ done:
 		    "", (margins) ? " with margins" : "", (interlace) ?
 		    " interlaced" : "");
 
+	    memset(&cvt_mode, 0, sizeof(cvt_mode));
 	    cvt_mode.xres = xres;
 	    cvt_mode.yres = yres;
 	    cvt_mode.refresh = (refresh) ? refresh : 60;



----------------------------------------------------------------------
Podbij Dziki Zachod!Gra strategiczna online
Sprawdz >>> http://link.interia.pl/f1dff


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
