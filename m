From: Jiri Slaby <jslaby@suse.cz>
Date: Wed, 29 Jul 2020 07:02:49 +0000
Subject: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
Message-Id: <20200729070249.20892-1-jslaby@suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: b.zolnierkie@samsung.com
Cc: Security Officers <security@kernel.org>, Kyungtae Kim <kt0755@gmail.com>, Anthony Liguori <aliguori@amazon.com>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, linux-distros@vs.openwall.org, linux-fbdev@vger.kernel.org, Greg KH <greg@kroah.com>, Solar Designer <solar@openwall.com>, Yang Yingliang <yangyingliang@huawei.com>, Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?=E5=BC=A0=E4=BA=91=E6=B5=B7?= <zhangyunhai@nsfocus.com>

The current vgacon's scroll up implementation uses a circural buffer
in vgacon_scrollback_cur. It always advances tail to prepare it for the
next write and caps it to zero if the next ->vc_size_row bytes won't fit.

But when we change the VT size (e.g. by VT_RESIZE) in the meantime, the new
line might not fit to the end of the scrollback buffer in the next
attempt to scroll. This leads to various crashes as
vgacon_scrollback_update writes out of the buffer:
 BUG: unable to handle page fault for address: ffffc900001752a0
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 RIP: 0010:mutex_unlock+0x13/0x30
...
 Call Trace:
  n_tty_write+0x1a0/0x4d0
  tty_write+0x1a0/0x2e0

Or to KASAN reports:
BUG: KASAN: slab-out-of-bounds in vgacon_scroll+0x57a/0x8ed

So check whether the line fits in the buffer and wrap if needed. Do it
before the loop as console_sem is held and ->vc_size_row cannot change
during the execution of vgacon_scrollback_cur. If it does change, we
need to ensure it does not change elsewhere, not here.

Also, we do not split the write of a line into chunks as that would
break the consumers of the buffer. They expect ->cnt, ->tail and ->size
to be in harmony and advanced by ->vc_size_row.

I found few reports of this in the past, some with patches included,
some even 2 years old:
https://lore.kernel.org/lkml/CAEAjamsJnG-=TSOwgRbbb3B9Z-PA63oWmNPoKYWQ=Z=+X49akg@mail.gmail.com/
https://lore.kernel.org/lkml/1589336932-35508-1-git-send-email-yangyingliang@huawei.com/

This fixes CVE-2020-14331.

Big thanks to guys mentioned in the Reported-and-debugged-by lines below
who actually found the root cause.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reported-and-debugged-by: 张云海 <zhangyunhai@nsfocus.com>
Reported-and-debugged-by: Yang Yingliang <yangyingliang@huawei.com>
Reported-by: Kyungtae Kim <kt0755@gmail.com>
Fixes: 15bdab959c9b ([PATCH] vgacon: Add support for soft scrollback)
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <greg@kroah.com>
Cc: Solar Designer <solar@openwall.com>
Cc: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc: Anthony Liguori <aliguori@amazon.com>
Cc: Security Officers <security@kernel.org>
Cc: linux-distros@vs.openwall.org
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/console/vgacon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index f0f3d573f848..13194bb246f8 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -250,6 +250,11 @@ static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
 
 	p = (void *) (c->vc_origin + t * c->vc_size_row);
 
+	/* vc_size_row might have changed by VT_RESIZE in the meantime */
+	if ((vgacon_scrollback_cur->tail + c->vc_size_row) >+			vgacon_scrollback_cur->size)
+		vgacon_scrollback_cur->tail = 0;
+
 	while (count--) {
 		scr_memcpyw(vgacon_scrollback_cur->data +
 			    vgacon_scrollback_cur->tail,
-- 
2.28.0
