From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/5] fbdev: Update maintainers list
Date: Wed, 11 Jan 2006 20:00:19 +0800
Message-ID: <43C4F353.3060706@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ewf5k-0005ps-Gj
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Jan 2006 04:28:40 -0800
Received: from zproxy.gmail.com ([64.233.162.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ewf5h-0006t5-9F
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Jan 2006 04:28:40 -0800
Received: by zproxy.gmail.com with SMTP id r28so137883nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Jan 2006 04:28:37 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Update maintainer's list.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 MAINTAINERS |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 725606d..caf7a6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1323,6 +1323,12 @@ M:	ttb@tentacle.dhs.org and rml@novell.c
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+INTEL FRAMEBUFFER DRIVER (excluding 810 and 815)
+P:      Sylvain Meyer
+M:      sylvain.meyer@worldonline.fr
+L:      linux-fbdev-devel@lists.sourceforge.net
+S:      Maintained
+
 INTEL 810/815 FRAMEBUFFER DRIVER
 P:      Antonino Daplas
 M:      adaplas@pol.net
@@ -1924,11 +1930,11 @@ W:	http://linux-ntfs.sf.net/
 T:	git kernel.org:/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git
 S:	Maintained
 
-NVIDIA (RIVA) FRAMEBUFFER DRIVER
-P:	Ani Joshi
-M:	ajoshi@shell.unixbox.com
-L:	linux-nvidia@lists.surfsouth.com
-S:	Maintained
+NVIDIA (rivafb and nvidiafb) FRAMEBUFFER DRIVER
+P:      Antonino Daplas
+M:      adaplas@pol.net
+L:      linux-fbdev-devel@lists.sourceforge.net
+S:      Maintained
 
 ORACLE CLUSTER FILESYSTEM 2 (OCFS2)
 P:	Mark Fasheh
@@ -2223,6 +2229,12 @@ L:	rtl@rtlinux.org
 W:	www.rtlinux.org
 S:	Maintained
 
+S3 SAVAGE FRAMEBUFFER DRIVER
+P:      Antonino Daplas
+M:      adaplas@pol.net
+L:      linux-fbdev-devel@lists.sourceforge.net
+S:      Maintained
+
 S390
 P:	Martin Schwidefsky
 M:	schwidefsky@de.ibm.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
