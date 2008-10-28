From: Mikulas Patocka <mpatocka@redhat.com>
Subject: framebuffer compat_ioctl deadlock
Date: Tue, 28 Oct 2008 11:02:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0810281059350.17438@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpatocka@redhat.com>) id 1Kuq6D-0003fG-6A
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 28 Oct 2008 15:03:13 +0000
Received: from mx1.redhat.com ([66.187.233.31])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kuq5y-0002BV-NK for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 28 Oct 2008 15:03:13 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi

lock_kernel was converted to mutexes in framebuffer driver, but it 
deadlocks because fb_compat_ioctl takes the lock and calls fb_ioctl that 
takes that lock too.

Mikulas

---

Fix deadlock in fb_compat_ioctl. fb_compat_ioctl acquires a mutex and 
calls fb_ioctl that tries to acquire that mutex too.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/video/fbmem.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.28-rc2-devel/drivers/video/fbmem.c
===================================================================
--- linux-2.6.28-rc2-devel.orig/drivers/video/fbmem.c	2008-10-28 15:48:18.000000000 +0100
+++ linux-2.6.28-rc2-devel/drivers/video/fbmem.c	2008-10-28 15:42:53.000000000 +0100
@@ -1262,8 +1262,8 @@ fb_compat_ioctl(struct file *file, unsig
 	case FBIOPUT_CON2FBMAP:
 		arg = (unsigned long) compat_ptr(arg);
 	case FBIOBLANK:
-		ret = fb_ioctl(file, cmd, arg);
-		break;
+		mutex_unlock(&info->lock);
+		return fb_ioctl(file, cmd, arg);
 
 	case FBIOGET_FSCREENINFO:
 		ret = fb_get_fscreeninfo(inode, file, cmd, arg);

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
