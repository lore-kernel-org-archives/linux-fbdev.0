From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] vt: Decrement ref count of the VT
	backend on deallocation
Date: Sun, 02 Jul 2006 11:41:06 +0800
Message-ID: <44A74052.1070506@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fwssj-0006Bp-I4 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 01 Jul 2006 20:44:25 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fwssi-0001vQ-40
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 01 Jul 2006 20:44:25 -0700
Received: by py-out-1112.google.com with SMTP id d42so1133150pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 01 Jul 2006 20:44:23 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

When a VT is newly allocated, the module reference count of the backend will
be incremented. This should be balanced by a module_put() when this VT is
deallocated.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/char/vt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index 3ef823d..da7e66a 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -886,6 +886,7 @@ void vc_disallocate(unsigned int currcon
 	if (vc_cons_allocated(currcons)) {
 		struct vc_data *vc = vc_cons[currcons].d;
 		vc->vc_sw->con_deinit(vc);
+		module_put(vc->vc_sw->owner);
 		if (vc->vc_kmalloced)
 			kfree(vc->vc_screenbuf);
 		if (currcons >= MIN_NR_CONSOLES)


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
