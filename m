From: =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>
Date: Thu, 30 Jul 2020 10:39:06 +0000
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
Message-Id: <dbcf2841-7718-2ba7-11e0-efa4b9de8de1@nsfocus.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------360FA215ABC3E00392C9DB2C"
List-Id: <linux-fbdev.vger.kernel.org>
References: <659f8dcf-7802-1ca1-1372-eb7fefd4d8f4@kernel.org>
In-Reply-To: <659f8dcf-7802-1ca1-1372-eb7fefd4d8f4@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>, Solar Designer <solar@openwall.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Kyungtae Kim <kt0755@gmail.com>, b.zolnierkie@samsung.com, Greg KH <greg@kroah.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, DRI devel <dri-devel@lists.freedesktop.org>, Anthony Liguori <aliguori@amazon.com>, Yang Yingliang <yangyingliang@huawei.com>, xiao.zhang@windriver.com, Linus Torvalds <torvalds@linux-foundation.org>, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>

This is a multi-part message in MIME format.
--------------360FA215ABC3E00392C9DB2C
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

Update the patch, add CC list, sample output, and Jiri's PoC.

On 2020/7/30 14:46, Jiri Slaby wrote:
> Hi, OTOH, you should have CCed all the (public) lists.


--------------360FA215ABC3E00392C9DB2C
Content-Type: text/plain; charset="utf-8"; name="0001-Fix-for-missing-check-in-vgacon-scrollback-handling.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-Fix-for-missing-check-in-vgacon-scrollback-handling.pat";
 filename*1="ch"

From ad143ede24ff4e61292cc9c96000100aacd97259 Mon Sep 17 00:00:00 2001
From: Yunhai Zhang <zhangyunhai@nsfocus.com>
Date: Tue, 28 Jul 2020 09:58:03 +0800
Subject: [PATCH] Fix for missing check in vgacon scrollback handling

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

Reported-and-debugged-by: 张云海 <zhangyunhai@nsfocus.com>
Reported-and-debugged-by: Yang Yingliang <yangyingliang@huawei.com>
Reported-by: Kyungtae Kim <kt0755@gmail.com>
Fixes: 15bdab959c9b ([PATCH] vgacon: Add support for soft scrollback)
Cc: stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <greg@kroah.com>
Cc: Solar Designer <solar@openwall.com>
Cc: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc: Anthony Liguori <aliguori@amazon.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Yunhai Zhang <zhangyunhai@nsfocus.com>
---
 drivers/video/console/vgacon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 998b0de1812f..37b5711cd958 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -251,6 +251,10 @@ static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
 	p = (void *) (c->vc_origin + t * c->vc_size_row);
 
 	while (count--) {
+		if ((vgacon_scrollback_cur->tail + c->vc_size_row) > 
+		    vgacon_scrollback_cur->size)
+			vgacon_scrollback_cur->tail = 0;
+
 		scr_memcpyw(vgacon_scrollback_cur->data +
 			    vgacon_scrollback_cur->tail,
 			    p, c->vc_size_row);
-- 
2.25.1

--------------360FA215ABC3E00392C9DB2C--
