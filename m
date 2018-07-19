From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 19 Jul 2018 10:15:59 +0000
Subject: [PATCH v3 0/2] fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set
Message-Id: <20180719101601.25076-1-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rostedt@goodmis.org, pmladek@suse.com, linux-fbdev@vger.kernel.org, sergey.senozhatsky@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, hdegoede@redhat.com, akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com
Cc: Thomas Zimmermann <tzimmermann@suse.de>

Hi,

this is version 3 of the WARN_CONSOLE_UNLOCKED patch set. The
macro prints a warning if the console's critical sections are
entered without holding the console lock. This patch set allows
to disable the warnings while debugging the console.

In the original approach, WARN_CONSOLE_UNLOCKED was disabled by
setting ignore_console_lock_warning of type bool. As suggested by
Petr Mladek, the new implementation is based on atomic_t and allows
multiple threads to manipulate the warning state concurrently.

With version 3, the patch set now includes the patch for introducing
ignore_console_lock_warning. This patch superseds all previous patches
of the same purpose.

Best regards
Thomas

v3:
	- implement ignore_console_lock_warning with atomic_t
v2:
	- restore ignore_console_lock_warning if lock_fb_info() fails

Thomas Zimmermann (2):
  console: Replace #if 0 with atomic var 'ignore_console_lock_warning'
  fbdev/core: Disable console-lock warnings when fb.lockless_register_fb
    is set

 drivers/video/fbdev/core/fbmem.c | 13 +++++++++----
 include/linux/console.h          | 14 +++++++++-----
 kernel/printk/printk.c           |  3 +++
 3 files changed, 21 insertions(+), 9 deletions(-)

--
2.18.0

