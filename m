From: Martin Jackson <mjackson220.list@gmail.com>
Date: Thu, 18 Dec 2014 13:55:54 +0000
Subject: msync on fbdev
Message-Id: <CABMKUD9mtus77hdfPA5mAtwc8MCpyJQ-kvvvyVmKQuw2Tuo9mA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Dear fbdev developers,

This relates to the core implementation of fbdev with the
CONFIG_FB_DEFERRED_IO option enabled.

I believe I have found a bug when doing msync(2) on a framebuffer
device. We are using an old (2.6.37) kernel on an embedded plaform,
but if I look at the current torvalds kernel (fbdev kernel looks
rather old!?), the bug seems to still be there.

When looking at the msync(2) man page, msync is meant to return 0 on
success and -1 on failure, however we are seeing it return 1, which is
undocumented and in my opinion wrong.

This is because the fb_deferred_io_fsync method returns the code from
'schedule_delayed_work', which is either 0 or 1 depending on whether
the work was already scheduled, leading to the possibility that msync
returns the value 1 to userland.

Best regards,

Martin Jackson
