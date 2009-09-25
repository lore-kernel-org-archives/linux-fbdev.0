From: Dave Airlie <airlied@gmail.com>
Subject: [PATCH 1/2] fb: change rules for global rules
	match.
Date: Fri, 25 Sep 2009 12:58:32 +1000
Message-ID: <1253847512-22994-1-git-send-email-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <airlied@gmail.com>) id 1Mr11C-0004xC-OO
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 Sep 2009 02:58:46 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mr116-0008Fg-Bh for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 Sep 2009 02:58:46 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sf.net

From: Dave Airlie <airlied@linux.ie>

Having a : should be enough 'fb:' isn't really useful
if the fb wants to a kms output ID.

Changed to use strchr as per feedback from Geert.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/video/fbmem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index a85c818..750c71f 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1789,7 +1789,7 @@ static int __init video_setup(char *options)
  		global = 1;
  	}
 
- 	if (!global && !strstr(options, "fb:")) {
+ 	if (!global && !strchr(options, ':')) {
  		fb_mode_option = options;
  		global = 1;
  	}
-- 
1.6.4.2


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
