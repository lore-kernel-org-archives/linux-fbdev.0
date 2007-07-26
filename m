From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 08/33] connector: change connector's max
	message size
Date: Thu, 26 Jul 2007 19:56:08 +0800
Message-ID: <46A88BD8.7040204@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2t3-0000sd-N9 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:56:13 -0700
Received: from nz-out-0506.google.com ([64.233.162.238])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2t2-0007a2-G1
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:56:13 -0700
Received: by nz-out-0506.google.com with SMTP id f1so1350702nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 05:56:12 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Januszewski <spock@gentoo.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Michal Januszewski <spock@gentoo.org>

Change the maximum message size to 16k to allow transfers of VBE
data blocks from userspace.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 include/linux/connector.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/connector.h b/include/linux/connector.h
index 10eb56b..8d4cccb 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -43,7 +43,7 @@ #define CN_NETLINK_USERS		4
 /*
  * Maximum connector's message size.
  */
-#define CONNECTOR_MAX_MSG_SIZE 	1024
+#define CONNECTOR_MAX_MSG_SIZE		16384
 
 /*
  * idx and val are unique identifiers which 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
