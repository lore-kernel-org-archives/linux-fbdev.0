From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] MAINTAINERS: add entry for uvesafb
Date: Sun, 21 Sep 2008 22:47:25 +0200
Message-ID: <20080921204725.GB21215@spock.one.pl>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michalj@gmail.com>) id 1KhVrL-0004wA-SX
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Sep 2008 20:48:47 +0000
Received: from fg-out-1718.google.com ([72.14.220.152])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KhVrG-0005s2-Pi for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Sep 2008 20:48:47 +0000
Received: by fg-out-1718.google.com with SMTP id d23so1328198fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 21 Sep 2008 13:48:41 -0700 (PDT)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Add a maintainer entry for the uvesafb driver.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/MAINTAINERS b/MAINTAINERS
index 0a613cb..26c8ddb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4431,6 +4431,13 @@ W:	http://kernel.org/~kzak/util-linux-ng/
 T:	git://git.kernel.org/pub/scm/utils/util-linux-ng/util-linux-ng.git
 S:	Maintained
 
+UVESAFB DRIVER
+P:	Michal Januszewski
+M:	spock@gentoo.org
+L:	linux-fbdev-devel@lists.sourceforge.net (moderated for non-subscribers)
+W:	http://dev.gentoo.org/~spock/projects/uvesafb/
+S:	Maintained
+
 VFAT/FAT/MSDOS FILESYSTEM:
 P:	OGAWA Hirofumi
 M:	hirofumi@mail.parknet.co.jp


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
