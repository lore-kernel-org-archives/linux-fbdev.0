From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: + cirrusfb-add-accelerator-constant.patch
	compilation fix
Date: Thu, 19 Mar 2009 19:45:38 +0100
Message-ID: <20090319194538.ca634c68.krzysztof.h1@poczta.fm>
References: <200903182352.n2INqb5a031610@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LkNEw-0006wr-LJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Mar 2009 18:45:14 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LkNEu-0000SZ-Po for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Mar 2009 18:45:14 +0000
In-Reply-To: <200903182352.n2INqb5a031610@imap1.linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: akpm@linux-foundation.org
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Add a missing constant for the patch:
cirrusfb: add accelerator constant

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

I am sorry but the patch cirrusfb-add-accelerator-constant.patch 
was not posted in full scope.

I spotted it after reviewing the patches accepted to the -mm tree.

Krzysztof

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 31527e1..fe7d0d7 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -123,6 +123,7 @@ struct dentry;
 #define FB_ACCEL_TRIDENT_3DIMAGE 51	/* Trident 3DImage		*/
 #define FB_ACCEL_TRIDENT_BLADE3D 52	/* Trident Blade3D		*/
 #define FB_ACCEL_TRIDENT_BLADEXP 53	/* Trident BladeXP		*/
+#define FB_ACCEL_CIRRUS_ALPINE   53	/* Cirrus Logic 543x/544x/5480	*/
 #define FB_ACCEL_NEOMAGIC_NM2070 90	/* NeoMagic NM2070              */
 #define FB_ACCEL_NEOMAGIC_NM2090 91	/* NeoMagic NM2090              */
 #define FB_ACCEL_NEOMAGIC_NM2093 92	/* NeoMagic NM2093              */
-- 
1.5.2.2


------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
