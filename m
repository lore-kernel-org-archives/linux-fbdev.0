From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH,
	REPOST] fb: hide hardware cursor in graphics mode (Mach64)
Date: Sat, 21 Mar 2009 20:38:27 +0100
Message-ID: <20090321203827.8313b220.krzysztof.h1@poczta.fm>
References: <46e1c7760901230433i3045f273oa109ce97e790bca3@mail.gmail.com>
	<Pine.LNX.4.64.0901240951110.13803@anakin>
	<46e1c7760901240109m5a0f3a85p788aa3ce35b49fa9@mail.gmail.com>
	<Pine.LNX.4.64.0901241425310.13803@anakin>
	<46e1c7760901240649v1e45bbb1v8c9997f236a3ec4c@mail.gmail.com>
	<46e1c7760902101337qe239336n9ef2652a47f89aed@mail.gmail.com>
	<46e1c7760902101350r5a04d076j49cc611a843e6429@mail.gmail.com>
	<20090211142409.b88c577e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1Ll712-0006Uv-Vf
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 21 Mar 2009 19:37:56 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ll711-0004Q1-9M for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 21 Mar 2009 19:37:56 +0000
In-Reply-To: <20090211142409.b88c577e.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>, geert@linux-m68k.org, Risto Suominen <risto.suominen@gmail.com>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

A hardware cursor is left enabled in
the fb_set_par() which is called when
a new console is created. This is
inconsistent with software cursor's
behaviour.

Also, this makes a hardware cursor
always visible in the Xfbdev
(Xorg kdrive) server.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
CC: Risto Suominen 
---
Finally, I acquired a Mach64GZ card and was able to 
solve this puzzle. It solved the problem Risto described
on my computer.

Risto, please test the patch on your machine. 

 drivers/video/aty/mach64_accel.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/aty/mach64_accel.c b/drivers/video/aty/mach64_accel.c
index a8f60c3..0cc9724 100644
--- a/drivers/video/aty/mach64_accel.c
+++ b/drivers/video/aty/mach64_accel.c
@@ -39,7 +39,8 @@ void aty_reset_engine(const struct atyfb_par *par)
 {
 	/* reset engine */
 	aty_st_le32(GEN_TEST_CNTL,
-		aty_ld_le32(GEN_TEST_CNTL, par) & ~GUI_ENGINE_ENABLE, par);
+		aty_ld_le32(GEN_TEST_CNTL, par) &
+		~(GUI_ENGINE_ENABLE | HWCURSOR_ENABLE), par);
 	/* enable engine */
 	aty_st_le32(GEN_TEST_CNTL,
 		aty_ld_le32(GEN_TEST_CNTL, par) | GUI_ENGINE_ENABLE, par);
-- 
1.5.2.2


----------------------------------------------------------------------
Szukasz pieniedzy? Wez podwojny limit zadluzenia w koncie direct.
>> http://link.interia.pl/f20a3


------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
