From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] fbdev: Blackfin has __raw I/O accessors,
	so use them in fb.h
Date: Fri,  5 Jun 2009 04:10:32 -0400
Message-ID: <1244189432-19907-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MCUVe-0000cN-3M
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Jun 2009 08:10:42 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MCUVd-00021e-6N
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Jun 2009 08:10:42 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: adaplas@gmail.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-fbdev-devel@lists.sourceforge.net

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 include/linux/fb.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 330c4b1..3292a11 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -893,7 +893,7 @@ struct fb_info {
 #define fb_writeq sbus_writeq
 #define fb_memset sbus_memset_io
 
-#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || defined(__hppa__) || defined(__sh__) || defined(__powerpc__) || defined(__avr32__)
+#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || defined(__hppa__) || defined(__sh__) || defined(__powerpc__) || defined(__avr32__) || defined(__bfin__)
 
 #define fb_readb __raw_readb
 #define fb_readw __raw_readw
-- 
1.6.3.1


------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
