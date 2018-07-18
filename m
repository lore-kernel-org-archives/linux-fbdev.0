From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 18 Jul 2018 08:36:32 +0000
Subject: [PATCH 0/1] fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set
Message-Id: <20180718083633.24182-1-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rostedt@goodmis.org, pmladek@suse.com, linux-fbdev@vger.kernel.org, sergey.senozhatsky@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, hdegoede@redhat.com, akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com
Cc: Thomas Zimmermann <tzimmermann@suse.de>

Hi,

this is a follow-up patch for the recent addition of
'ignore_console_lock_warning' to the console module [1] and should probably
go through the same tree. When debugging fbdev console registration, the
console-lock warnings will now be disabled temporarily.

Best regards
Thomas

[1] https://marc.info/?l=dri-devel&m3140585411176&w=2

Thomas Zimmermann (1):
  fbdev/core: Disable console-lock warnings when fb.lockless_register_fb
    is set

 drivers/video/fbdev/core/fbmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

--
2.18.0

