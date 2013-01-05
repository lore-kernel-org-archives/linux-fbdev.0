From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Sat, 05 Jan 2013 12:13:27 +0000
Subject: Re: 3.8-rc2 lockdep complains about console_lock vs. fb_notifier_list.rwsem
Message-Id: <CA+icZUUxgRsGkYAmZ=JxTwPvdhTzpGLcxm6+VSq9jnfYPVXj4Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk, Andrew Morton <akpm@linux-foundation.org>

Hi Jiri,

...known issue (see thread in [1]), please feel free to test patches
from Alan and Andrew (see [1], [2] and [3]) and report.

Regards,
- Sedat -

[1] http://marc.info/?t5309396400003&r=1&w=2
[2] http://ozlabs.org/~akpm/mmots/broken-out/fb-rework-locking-to-fix-lock-ordering-on-takeover.patch
[3] http://ozlabs.org/~akpm/mmots/broken-out/fb-rework-locking-to-fix-lock-ordering-on-takeover-fix.patch
[4] http://ozlabs.org/~akpm/mmots/broken-out/fb-rework-locking-to-fix-lock-ordering-on-takeover-fix-2.patch
