From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 18 Jul 2018 09:30:01 +0000
Subject: [PATCH v2 0/1] fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set
Message-Id: <20180718093002.4596-1-tzimmermann@suse.de>
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

v2:
	- restore ignore_console_lock_warning if lock_fb_info() fails

Thomas Zimmermann (1):
  fbdev/core: Disable console-lock warnings when fb.lockless_register_fb
    is set

 drivers/video/fbdev/core/fbmem.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--
2.18.0

