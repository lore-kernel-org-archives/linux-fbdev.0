From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 6/7] drivers/video: Release mutex in
	error handling code
Date: Mon, 21 Jul 2008 09:58:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807210958320.24625@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKqIP-0006eJ-MZ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Jul 2008 00:59:01 -0700
Received: from mgw1.diku.dk ([130.225.96.91])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KKqIO-0004CJ-Gm
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Jul 2008 00:59:01 -0700
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
To: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

The mutex is released on a successful return, so it would seem that it
should be released on an error return as well.

The semantic patch finds this problem is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
expression l;
@@

mutex_lock(l);
... when != mutex_unlock(l)
    when any
    when strict
(
if (...) { ... when != mutex_unlock(l)
+   mutex_unlock(l);
    return ...;
}
|
mutex_unlock(l);
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/video/arkfb.c    |    9 +++------
 drivers/video/vt8623fb.c |    9 +++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff -u -p a/drivers/video/arkfb.c b/drivers/video/arkfb.c
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -1126,11 +1126,8 @@ static int ark_pci_resume (struct pci_de
 	acquire_console_sem();
 	mutex_lock(&(par->open_lock));
 
-	if (par->ref_count == 0) {
-		mutex_unlock(&(par->open_lock));
-		release_console_sem();
-		return 0;
-	}
+	if (par->ref_count == 0)
+		goto fail;
 
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
@@ -1143,8 +1140,8 @@ static int ark_pci_resume (struct pci_de
 	arkfb_set_par(info);
 	fb_set_suspend(info, 0);
 
-	mutex_unlock(&(par->open_lock));
 fail:
+	mutex_unlock(&(par->open_lock));
 	release_console_sem();
 	return 0;
 }
diff -u -p a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -853,11 +853,8 @@ static int vt8623_pci_resume(struct pci_
 	acquire_console_sem();
 	mutex_lock(&(par->open_lock));
 
-	if (par->ref_count == 0) {
-		mutex_unlock(&(par->open_lock));
-		release_console_sem();
-		return 0;
-	}
+	if (par->ref_count == 0)
+		goto fail;
 
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
@@ -870,8 +867,8 @@ static int vt8623_pci_resume(struct pci_
 	vt8623fb_set_par(info);
 	fb_set_suspend(info, 0);
 
-	mutex_unlock(&(par->open_lock));
 fail:
+	mutex_unlock(&(par->open_lock));
 	release_console_sem();
 
 	return 0;

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
