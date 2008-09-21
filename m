From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] uvesafb: don't treat mode info
	retrieval failures as errors
Date: Sun, 21 Sep 2008 22:45:42 +0200
Message-ID: <20080921204542.GA21215@spock.one.pl>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michalj@gmail.com>) id 1KhVpf-0004Sn-Bq
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Sep 2008 20:47:03 +0000
Received: from fg-out-1718.google.com ([72.14.220.157])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KhVpb-0001bJ-7T for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Sep 2008 20:47:03 +0000
Received: by fg-out-1718.google.com with SMTP id d23so1327768fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 21 Sep 2008 13:46:57 -0700 (PDT)
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

From: Michal Januszewski <spock@gentoo.org>

Some BIOSes return error codes when queried for information about
modes from their own modelist.  uvesafb treats this as an error
case and bails out.

Change this behavior so that broken modes do not prevent the driver
from working.  Only the failure to retrieve information about any
usable video mode is considered to be an error case.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index 5074422..6c2d37f 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -516,10 +516,12 @@ static int __devinit uvesafb_vbe_getmodes(struct uvesafb_ktask *task,
 
 		err = uvesafb_exec(task);
 		if (err || (task->t.regs.eax & 0xffff) != 0x004f) {
-			printk(KERN_ERR "uvesafb: Getting mode info block "
+			printk(KERN_WARNING "uvesafb: Getting mode info block "
 				"for mode 0x%x failed (eax=0x%x, err=%d)\n",
 				*mode, (u32)task->t.regs.eax, err);
-			return -EINVAL;
+			mode++;
+			par->vbe_modes_cnt--;
+			continue;
 		}
 
 		mib = task->buf;
@@ -548,7 +550,10 @@ static int __devinit uvesafb_vbe_getmodes(struct uvesafb_ktask *task,
 			mib->depth = mib->bits_per_pixel;
 	}
 
-	return 0;
+	if (par->vbe_modes_cnt > 0)
+		return 0;
+	else
+		return -EINVAL;
 }
 
 /*


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
