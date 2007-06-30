From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH v2 3/5] uvesafb: change connector's max
	message size
Date: Sat, 30 Jun 2007 18:33:32 +0200
Message-ID: <20070630163332.GD3838@spock.one.pl>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I4ftB-0004KF-Gt for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 Jun 2007 09:33:37 -0700
Received: from ipn26-148.piekary.net ([83.238.26.148])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I4ftA-0001aw-4n
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 Jun 2007 09:33:37 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com

Change the maximum message size to 4k to allow transfers of VBE
data blocks from userspace.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
 include/linux/connector.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/connector.h b/include/linux/connector.h
index 14cecaf..12e3140 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -44,7 +44,7 @@
 /*
  * Maximum connector's message size.
  */
-#define CONNECTOR_MAX_MSG_SIZE 	1024
+#define CONNECTOR_MAX_MSG_SIZE		4096
 
 /*
  * idx and val are unique identifiers which 

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
