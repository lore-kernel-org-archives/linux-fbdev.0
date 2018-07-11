From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Wed, 11 Jul 2018 23:59:56 +0000
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
Message-Id: <20180711235956.GA4829@jagdpanzerIV>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
In-Reply-To: <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Hi,

On (07/11/18 16:46), Thomas Zimmermann wrote:
> Am 28.06.2018 um 11:03 schrieb Hans de Goede:
> > Replace comments about places where the console lock should be held with
> > calls to WARN_CONSOLE_UNLOCKED() to assert that it is actually held.
> 
> Debugging fbcon sometimes requires to not take the console lock. This
> patch breaks the debugging workaround provided by
> 'fb.lockless_register_fb'. The dmesg is now filled with warnings about
> the missing lock.

Hmm. I once dealt with WARN_CONSOLE_UNLOCKED(), and back then, IIRC,
I really wanted to turn it into WARN_ONCE_CONSOLE_UNLOCKED(), which
would WARN_ON_ONCE() instead of WARN_ON(). It's just a bit too noisy
and verbose and a single backtrace was already enough.

	-ss
