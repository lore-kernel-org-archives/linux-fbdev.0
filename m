From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 04/20] vt: Fix warnings in selection.h
Date: Sun, 26 Aug 2007 21:57:45 +0800
Message-ID: <46D186D9.8060708@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPJ1E-0005AV-MU for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:23:12 -0700
Received: from nz-out-0506.google.com ([64.233.162.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPJ1E-00088d-93
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:23:12 -0700
Received: by nz-out-0506.google.com with SMTP id f1so2918589nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 26 Aug 2007 07:23:12 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ralf Baechle <ralf@linux-mips.org>

From: Ralf Baechle <ralf@linux-mips.org>

<linux/selection.h> assumes that struct tty_struct has previously been
included.  If not, this pile of warnings will result:

  CC [M]  drivers/video/console/newport_con.o
In file included from drivers/video/console/newport_con.c:18:
include/linux/selection.h:16: warning: 'struct tty_struct' declared inside param
eter list
include/linux/selection.h:16: warning: its scope is only this definition or decl
aration, which is probably not what you want
include/linux/selection.h:17: warning: 'struct tty_struct' declared inside param
eter list
include/linux/selection.h:20: warning: 'struct tty_struct' declared inside param
eter list

Fixed by adding a forward declaration of struct tty_struct.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 include/linux/selection.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/selection.h b/include/linux/selection.h
index f945786..8cdaa11 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -13,6 +13,7 @@ #include <linux/vt_buffer.h>
 struct tty_struct;
 
 extern struct vc_data *sel_cons;
+struct tty_struct;
 
 extern void clear_selection(void);
 extern int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *tty);


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
