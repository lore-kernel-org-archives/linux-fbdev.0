From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 21 Aug 2012 22:34:30 +0000
Subject: [PATCH 0/2] console_lock debug improvements
Message-Id: <1345588472-4055-1-git-send-email-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>

Hi all,

After Dave Airlie blew through a few days to track down a deadlock at boot-up
when handing over from the firmware fb to the kms/drm framebuffer driver (1), I've
figured that lockdep /should/ have caught this.

And indeed, by adding proper annotations to the console_lock it complains about
the potential deadlock when exercising the entire driver life-cycle of just one
fb driver (i.e. not even a handover required). While at it, I've replaced the
existing in_interrupt check with the more paranoid might_sleep.

Comments, flames and review highly welcome.

Yours, Daniel

[1]: https://lkml.org/lkml/2012/8/21/36

Daniel Vetter (2):
  console: use might_sleep in console_lock
  console: implement lockdep support for console_lock

 kernel/printk.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
1.7.10.4

