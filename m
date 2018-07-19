From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Thu, 19 Jul 2018 10:33:55 +0000
Subject: Re: [PATCH v2 1/1] fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set
Message-Id: <20180719103355.GC424@jagdpanzerIV>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718093002.4596-1-tzimmermann@suse.de>
 <20180718093002.4596-2-tzimmermann@suse.de>
 <20180719085303.mkxu7i7zl4suybcz@pathway.suse.cz>
 <20180719100526.GB424@jagdpanzerIV>
 <48b38f83-f3cf-943d-bd31-ab2e1bd29d0a@suse.de>
In-Reply-To: <48b38f83-f3cf-943d-bd31-ab2e1bd29d0a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, b.zolnierkie@samsung.com, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, hdegoede@redhat.com, dri-devel@lists.freedesktop.org, akpm@linux-foundation.org

Hi,

On (07/19/18 12:20), Thomas Zimmermann wrote:
> Am 19.07.2018 um 12:05 schrieb Sergey Senozhatsky:
> > On (07/19/18 10:53), Petr Mladek wrote:
> >> Hmm, this approach is racy if there are other users
> >> saving/setting/restoring ignore_console_lock_warning in parallel.
> >> I mean that this works only when the entire safe/set/restore
> >> operation is nested or sequential.
> > 
> > Good point!
> > 
> > However, I tend to think that we don't need to care about it
> > that much. Having a counter to permit nesting would probably be
> > better, but, like you said, it's unlikely that we will see any
> > problems with ignore_console_lock_warning anyway. So we can keep
> > it simple [IOW - the way it is].
> 
> I just sent a new patch set based on atomic_t

Ah, just saw the new version.

> and TBH it's easier to use that this version. I only had to introduce
> the save-state variable in the caller because I couldn't do inc/dec.

No objections, if it makes your life easier.
Thanks.

	-ss
