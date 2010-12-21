From: Dave Airlie <airlied@gmail.com>
Date: Tue, 21 Dec 2010 01:41:16 +0000
Subject: [PATCH 2/3] vt: fix issue when fbcon wants to takeover a second time.
Message-Id: <1292895677-4242-3-git-send-email-airlied@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1292895677-4242-1-git-send-email-airlied@gmail.com>
In-Reply-To: <1292895677-4242-1-git-send-email-airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@suse.de>

From: Dave Airlie <airlied@redhat.com>

With framebuffer handover and multiple GPUs, we get into a
position where the fbcon unbinds the vesafb framebuffer for GPU 1,
but we still have a radeon framebuffer bound from GPU 0, so
we don't unregister the console driver. Then when we tried to bind
the new radeon framebuffer for GPU1 we never get to the bind
call as we fail due to the console being registered already.

This changes the return value to -EBUSY when the driver is
already registered and continues to bind for -EBUSY.

Signed-off-by: Dave Airlie <airlied@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@suse.de>
---
 drivers/tty/vt/vt.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index a8ec48e..d781496 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3524,7 +3524,7 @@ int register_con_driver(const struct consw *csw, int first, int last)
 
 		/* already registered */
 		if (con_driver->con = csw)
-			retval = -EINVAL;
+			retval = -EBUSY;
 	}
 
 	if (retval)
@@ -3635,7 +3635,12 @@ int take_over_console(const struct consw *csw, int first, int last, int deflt)
 	int err;
 
 	err = register_con_driver(csw, first, last);
-
+	/* if we get an busy error we still want to bind the console driver
+	 * and return success, as we may have unbound the console driver
+	 * but not unregistered it.
+	 */
+	if (err = -EBUSY)
+		err = 0;
 	if (!err)
 		bind_con_driver(csw, first, last, deflt);
 
-- 
1.7.1

