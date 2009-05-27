From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] carminefb: beyond ARRAY_SIZE of
	carmine_modedb
Date: Wed, 27 May 2009 00:15:46 -0700
Message-ID: <20090527001546.40a870d6.akpm@linux-foundation.org>
References: <4A1351AE.6010408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1M9DMt-0004ee-Pn
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 May 2009 07:16:07 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M9DMn-0006d0-K9
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 May 2009 07:16:07 +0000
In-Reply-To: <4A1351AE.6010408@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Siewior <bigeasy@linutronix.de>, Sebastian, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

On Wed, 20 May 2009 02:41:18 +0200 Roel Kluin <roel.kluin@gmail.com> wrote:

> CC: inux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>

You mistyped the list address.

> Subject: [PATCH] carminefb: beyond ARRAY_SIZE of carmine_modedb
> Date: Wed, 20 May 2009 02:41:18 +0200
> User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
> 
> Do not go beyond ARRAY_SIZE ofcarmine_modedb

Sort-of.  I changed the title and changelog:


Subject: carminefb: fix possible access beyond end of carmine_modedb[]
From: Roel Kluin <roel.kluin@gmail.com>

This check is off-by-one.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/video/carminefb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/video/carminefb.c~carminefb-beyond-array_size-of-carmine_modedb drivers/video/carminefb.c
--- a/drivers/video/carminefb.c~carminefb-beyond-array_size-of-carmine_modedb
+++ a/drivers/video/carminefb.c
@@ -562,7 +562,7 @@ static int __devinit alloc_carmine_fb(vo
 	if (ret < 0)
 		goto err_free_fb;
 
-	if (fb_mode > ARRAY_SIZE(carmine_modedb))
+	if (fb_mode >= ARRAY_SIZE(carmine_modedb))
 		fb_mode = CARMINEFB_DEFAULT_VIDEO_MODE;
 
 	par->cur_mode = par->new_mode = ~0;
_


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
