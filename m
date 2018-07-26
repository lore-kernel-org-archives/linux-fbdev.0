From: bai <baijiaju1990@gmail.com>
Date: Thu, 26 Jul 2018 14:17:44 +0000
Subject: [BUG] video: fbdev: broadsheetfb: Possible null function pointers
Message-Id: <cb43741a-83af-0b55-f53b-489bf7cb8b61@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: b.zolnierkie@samsung.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

In Linux-4.16, drivers/video/fbdev/broadsheetfb.c,

158. static void broadsheet_mmio_send_cmdargs(...) {
             ......
163.     par->board->mmio_write(...);
             ......
166.     par->board->mmio_write(...);
167. }

For x86 kernel configuration, I find that there is no assignment of the 
function pointer ".mmio_write" in the kernel code.
So calling the function pointer in lines 163 and 166 may cause a null 
pointer dereference.

In this file, there are many calls to this function pointer...


Best wishes,
Jia-Ju Bai
