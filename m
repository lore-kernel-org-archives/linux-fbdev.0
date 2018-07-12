From: Petr Mladek <pmladek@suse.com>
Date: Thu, 12 Jul 2018 13:43:12 +0000
Subject: Re: [PATCH v2] console: Replace #if 1 with a bool to ignore
Message-Id: <20180712134312.yxbg7pollgpxkrfy@pathway.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180712092938.22e33641@gandalf.local.home>
 <20180712093049.692ad3bd@gandalf.local.home>
In-Reply-To: <20180712093049.692ad3bd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Thu 2018-07-12 09:30:49, Steven Rostedt wrote:
> On Thu, 12 Jul 2018 09:29:38 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
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
> Petr,
> 
> If you want this to go by way of fbdev tree, then can you Ack it?

Sure.

Acked-by: Petr Mladek <pmladek@suse.com>

I assume that it will go via fbdev tree with the other changes
unless I hear otherwise.

Best Regards,
Petr
