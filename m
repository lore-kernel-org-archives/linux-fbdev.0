From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2020 11:00:47 +0000
Subject: [PATCH 4.4 80/85] tty: vt, consw->con_scrolldelta cleanup
Message-Id: <20200929105932.191358795@linuxfoundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200929105928.198942536@linuxfoundation.org>
In-Reply-To: <20200929105928.198942536@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Winischhofer <thomas@winischhofer.net>, linux-usb@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org, Ajay Kaher <akaher@vmware.com>

From: Jiri Slaby <jslaby@suse.cz>

commit 97293de977365fe672daec2523e66ef457104921 upstream.

* allow NULL consw->con_scrolldelta (some consoles define an empty
  hook)
* => remove empty hooks now
* return value of consw->con_scrolldelta is never checked => make the
  function void
* document consw->con_scrolldelta a bit

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-usb@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: Ajay Kaher <akaher@vmware.com>
[ for 4.4.y backport, only do the first change above, to prevent
.con_scrolldelta from being called if not present - gregkh]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vt/vt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2484,7 +2484,7 @@ static void console_callback(struct work
 	if (scrollback_delta) {
 		struct vc_data *vc = vc_cons[fg_console].d;
 		clear_selection();
-		if (vc->vc_mode = KD_TEXT)
+		if (vc->vc_mode = KD_TEXT && vc->vc_sw->con_scrolldelta)
 			vc->vc_sw->con_scrolldelta(vc, scrollback_delta);
 		scrollback_delta = 0;
 	}
