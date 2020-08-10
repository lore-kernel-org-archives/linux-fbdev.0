From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 10 Aug 2020 15:21:35 +0000
Subject: [PATCH 4.19 13/48] vgacon: Fix for missing check in scrollback handling
Message-Id: <20200810151804.862471898@linuxfoundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200810151804.199494191@linuxfoundation.org>
In-Reply-To: <20200810151804.199494191@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, =?UTF-8?q?=E5=BC=A0=E4=BA=91=E6=B5=B7?= <zhangyunhai@nsfocus.com>, Yang Yingliang <yangyingliang@huawei.com>, Kyungtae Kim <kt0755@gmail.com>, linux-fbdev@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Solar Designer <solar@openwall.com>, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, Anthony Liguori <aliguori@amazon.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jiri Slaby <jirislaby@kernel.org>

From: Yunhai Zhang <zhangyunhai@nsfocus.com>

commit ebfdfeeae8c01fcb2b3b74ffaf03876e20835d2d upstream.

vgacon_scrollback_update() always leaves enbough room in the scrollback
buffer for the next call, but if the console size changed that room
might not actually be enough, and so we need to re-check.

The check should be in the loop since vgacon_scrollback_cur->tail is
updated in the loop and count may be more than 1 when triggered by CSI M,
as Jiri's PoC:
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <fcntl.h>

int main(int argc, char** argv)
{
        int fd = open("/dev/tty1", O_RDWR);
        unsigned short size[3] = {25, 200, 0};
        ioctl(fd, 0x5609, size); // VT_RESIZE

        write(fd, "\e[1;1H", 6);
        for (int i = 0; i < 30; i++)
                write(fd, "\e[10M", 5);
}

It leads to various crashes as vgacon_scrollback_update writes out of
the buffer:
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

This fixes CVE-2020-14331.

Reported-by: 张云海 <zhangyunhai@nsfocus.com>
Reported-by: Yang Yingliang <yangyingliang@huawei.com>
Reported-by: Kyungtae Kim <kt0755@gmail.com>
Fixes: 15bdab959c9b ([PATCH] vgacon: Add support for soft scrollback)
Cc: stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Solar Designer <solar@openwall.com>
Cc: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc: Anthony Liguori <aliguori@amazon.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Yunhai Zhang <zhangyunhai@nsfocus.com>
Link: https://lore.kernel.org/r/9fb43895-ca91-9b07-ebfd-808cf854ca95@nsfocus.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/console/vgacon.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -251,6 +251,10 @@ static void vgacon_scrollback_update(str
 	p = (void *) (c->vc_origin + t * c->vc_size_row);
 
 	while (count--) {
+		if ((vgacon_scrollback_cur->tail + c->vc_size_row) >
+		    vgacon_scrollback_cur->size)
+			vgacon_scrollback_cur->tail = 0;
+
 		scr_memcpyw(vgacon_scrollback_cur->data +
 			    vgacon_scrollback_cur->tail,
 			    p, c->vc_size_row);
