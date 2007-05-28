From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 9/9] fbcon: Allow fbcon to use the
 primary display driver fix
Date: Mon, 28 May 2007 14:33:06 +0800
Message-ID: <465A77A2.1090805@gmail.com>
References: <4658D8E2.3020608@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HsYn5-0003gr-4e for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 23:33:15 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HsYn4-0008HJ-Aw
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 23:33:15 -0700
Received: by py-out-1112.google.com with SMTP id u77so2733314pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 27 May 2007 23:33:13 -0700 (PDT)
In-Reply-To: <4658D8E2.3020608@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

unbind_con_driver() should be EXPORT_SYBOL.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

Antonino A. Daplas wrote:
> Allow fbcon to select the primary display adapter using the
> fb_is_primary_device() arch-specific helper.  If a a primary adapter is
> detected, fbcon will unbind the old adapter from the VT layer, then rebind
> using the new adapter. This requires that bind_/unbind_con_driver() be made
> public.
> 
> Because this feature may produce unexpected behavior (from the user's POV),
> this must be explicitly enabled in Kconfig.
> 

link errors if compiled as a module.  Here's the fix.

Tony

 drivers/char/vt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index 45baf04..e5f36e7 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2962,6 +2962,7 @@ err:
 	module_put(owner);
 	return retval;
 };
+EXPORT_SYMBOL(bind_con_driver);
 
 #ifdef CONFIG_VT_HW_CONSOLE_BINDING
 static int con_is_graphics(const struct consw *csw, int first, int last)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
