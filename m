From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 16:18:02 +0000
Subject: Re: [PATCH v2] console: Replace #if 1 with a bool to ignore
Message-Id: <2838511.fdTZ0RgijS@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180712132944epcas4p3091e1c7a7aa1bd4da95750908012e616@epcas4p3.samsung.com>
        <20180712092938.22e33641@gandalf.local.home> <1582481.BL9yPUoula@amdc3058>
In-Reply-To: <1582481.BL9yPUoula@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Tuesday, July 24, 2018 06:13:19 PM Bartlomiej Zolnierkiewicz wrote:
> On Thursday, July 12, 2018 09:29:38 AM Steven Rostedt wrote:
> > 
> > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > There's been discussion on the fb list about the addition of
> > WARN_CONSOLE_UNLOCKED() inside the fb code. The complaint is that when
> > the fb module is loaded with lockless_register_fb the console lock is
> > not taken for debugging reasons. With the addition of
> > WARN_CONSOLE_UNLOCK() within the fb code, this causes the console to
> > fill up with warnings when trying to debug the fb driver.
> > 
> > There's also a #if 1 that enables the warning which was added before
> > git history, and we look down on constant #if's in the kernel nowadays
> > anyway.
> > 
> > Remove the #if 1 and add a ignore_console_lock_warning boolean that can
> > be set by drivers to ignore the warning in order to do debugging.
> > 
> > Link: http://lkml.kernel.org/r/717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Patch queued for 4.19, thanks.

Dequeued, I've just noticed a newer patch from Thomas for this issue
(I plan to apply it later this week).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

