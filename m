Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B092D8DC2
	for <linux-fbdev@vger.kernel.org>; Wed, 21 Jan 2026 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003032; cv=none; b=fYRZ/mTq/ZCsSI7TTVYC88qNA0r3ETa964XDhMdh1cHdTtgsqshkdivjmlQXNQYBwdk9kFkv4Lz+bbap2q5HwMyVtM1DV/8wFApT1bUzjeLQ4voLaBDyxKsmvNlaPM7TqxMkeqTtNggQf1WN+Y0yCOH1sKYjKwlr5GfyRT31/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003032; c=relaxed/simple;
	bh=QQQGLGrxyDqpRAehqpqA84gQPh/l4+7pkVsxG1/x4Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ccvt8xnfR6+Ar2XD89JnvUp2JpLmmM+SBoaB+F15Zn34DC52445G78W2EDr0U9EeperxnXU6QGxThigQ0X+K6xOSnxweZ0MJP54JIUdX8Lrhkv1yhJyI2xqovwSrsOf1ttag1jemSXhJ8SBfYS/RGnGN1Kaz+f82UeE/Ad2fOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c49a5F8m; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c49a5F8m"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so46122675e9.3
        for <linux-fbdev@vger.kernel.org>; Wed, 21 Jan 2026 05:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769003028; x=1769607828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQGrvXlS/vZO/X2X6A7hHoxfwGZEgD9ArCjj7iH+/tM=;
        b=c49a5F8m7xozCSMvl/RWYuhRIGp8YXG+J3MsB5DPdKyelZl/m+oD0cE/Lnw63QMs5u
         YIOsFZZOEUDaMjRX+N1ZonKLJqIjVvFG9+XJuGzwFLEcRj2grBX8YtgUt9Ul+3KiDZTZ
         KJJiU5w9RPb5kj7jPFSFoCHDbzhxs5P9rn+ojNHdsDEIKXxfYHFCaLfEbL4UquCBeedS
         zrRnjH4PI9OUY2p5lgBnubDDHeqf/EfdDwTjNSnxolYCxwT5EmVuh+ha0mLhoXmGasTn
         jAN3ywg/mD1WpLR0tw9yimb2lEdyzRf+LA40UdKOPXNs5FsOG3TUSD+3S6XsDcy8mF46
         6rHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003028; x=1769607828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQGrvXlS/vZO/X2X6A7hHoxfwGZEgD9ArCjj7iH+/tM=;
        b=a0+u8dagYsmlFdDO5o447wdwsL99w1RvU0DJmK3L8wN8L258pYvZL9XWG8MHnacWxK
         u+p0Di9kk6BdV2wlByxsuuWQ3bzGt+9kg/Vn8pQCQyLtBoFkvyUCCZYTHFubrbWAZCli
         ofe8eEWWff3BLFdiiamdJkzqkNC03RI9v29EyH7voIGJSw2IKLhQG3Z5/gjnOY1RKpzp
         NemRCSS/4YoZvVjglKrXtYXqIuQNYfsjHx2M2MJKJzrTVEDxJoH0Mu3z1z1oJJqhYGxj
         hYCxMLKAxdj9Wu79E/DtVKBzIck6DHMCLAwsW+0wR5XjXVK0CjrB/xrUfSN5ayzMGCKe
         PPtw==
X-Forwarded-Encrypted: i=1; AJvYcCWkhvZa1vjLkOVjCYoBuRWCgwJ0rtTFF6Ka8YF486u8lPWnU13OBVdxkCKJdK1QRjWYF0x2yBqKUOQB7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/FfffO2asrrmulWuhBrUhIfuGsKVoFRcKrYkkVxQVyAccgUE
	w+TnAcJ2JRr+yz4ILw87K/aB5YYAjzEMfYK9lHKoqfaoTS0JaQYWJnoBWwcHKPVYJ0I=
X-Gm-Gg: AZuq6aI3OloXtVZjsoaLtJ+EaLJDnv3wme5iuyFbc0k45nIdPfh0w9nDtWSRM1WUGQx
	q4pzTqwxdF9cBUXFVE+fDt7negDdpU+d7vPUTMWHdy9Mz4ruLGMhwIO59dEmeVyPHEx7LzgAm8o
	7wNIZroHC5qzaIgYmukrkqEXGLilUmFj3lGLQtb4j5HufXR7VuCcr+DPvN0eYt2tx3lSl963FG8
	5/Zn1CBy9JpxX5jfokMzmYhs08KjmmhwRuDoP1cq6qvK+liK/Fp9RYb85Fm8Cqc1K7yRn8JijYW
	7yNXWApoKfeJHKIvNf1/Uc6RU3S/gyi9lMvT0MdXAbMyCV0y+c50icKxBzZFMGjfuC/CUkI3jjX
	jykNDbQx3qcTsqNoHOeVd3vyK3TD+J8lm/O0XbmsE/NqYqcCpOB3uJWO/co+1zwvpwWR/XS7nve
	UvKzGI2EDz2aowmQ==
X-Received: by 2002:a05:600c:6990:b0:47e:c562:a41f with SMTP id 5b1f17b1804b1-4801e334361mr235226105e9.18.1769003028140;
        Wed, 21 Jan 2026 05:43:48 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042495f8fsm24360645e9.1.2026.01.21.05.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:43:47 -0800 (PST)
Date: Wed, 21 Jan 2026 14:43:45 +0100
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Subject: Re: printk's threaded legacy console + fbcon => schedule where it
 should not
Message-ID: <aXDYEVlkFgxdSVSG@pathway.suse.cz>
References: <20260114145955.d924Z-zu@linutronix.de>
 <20260120110845.2922a91a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120110845.2922a91a@gandalf.local.home>

On Tue 2026-01-20 11:08:45, Steven Rostedt wrote:
> On Wed, 14 Jan 2026 15:59:55 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > @@ -3362,22 +3362,6 @@ void console_unlock(void)
> >  }
> >  EXPORT_SYMBOL(console_unlock);
> >  
> > -/**
> > - * console_conditional_schedule - yield the CPU if required
> 
> Egad! That goes all the way back to 2002:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=a880f45a48be2956d2c78a839c472287d54435c1
>
> > - *
> > - * If the console code is currently allowed to sleep, and
> > - * if this CPU should yield the CPU to another task, do
> > - * so here.
> > - *
> > - * Must be called within console_lock();.
> > - */
> > -void __sched console_conditional_schedule(void)
> > -{
> > -	if (console_may_schedule)
> > -		cond_resched();
> > -}
> > -EXPORT_SYMBOL(console_conditional_schedule);
> 
> I'm assuming this likely isn't needed anymore. I don't know of any reason
> it needs to stay.

I know that there was a plan to get rid of cond_resched().
But what is the status now, please?

I still see more that 1k cond_resched() calls in the code:

  $> git grep cond_resched\(\) | grep "\.c:" | wc -l
  1263

And config PREEMPT_VOLUNTARY still talks about the explicit
preemption points.

> Should we just remove it and see what breaks?

Honestly, I do not feel comfortable with removing it. It is true that
it has no effect in the printk() code path. But the vt code is used
also when working on the terminal.

The vt code still uses console_lock() because it was intertwined
with printk console code since very old days. console_lock is a kind
of big kernel lock there.


Alternative solution is to get rid of the spin_trylock(). The only
purpose is to prevent race in console_flush_on_panic(). It used
to be a simple bit operation. The spin_lock() was added just to
get barriers right. But we have a great atomic_t API these days.

IMHO, it is a win-win solution because a preemptive context is
always better.

What about?

From 0fc61b6877e9beb20429effc599bc4bc6ec3a475 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Wed, 21 Jan 2026 10:47:15 +0100
Subject: [RFC] tty/vt: Prevent re-entering vt_console_print() in panic()
 without spin_lock

The commit b0940003f25dd ("vt: bitlock fix") replaced a simple bit
operation with spin_lock() to get proper memory barriers.

But the code called under this lock calls console_conditional_schedule()
which calls cond_resched() when console_sem() has been acquired
in a preemptive context using console_lock(). Note that the semaphore
can be taken also in an atomic context using console_trylock()
which is used by printk().

One solution would be to remove console_conditional_schedule().
It does not have any effect in the printk() code path anyway.
But the affected VT code is not used just by printk(). And
the cond_resched() calls were likely added for a reason.

Instead, convert the spin_lock back to an atomic operation with
proper barriers. The only purpose of the lock is to prevent
a concurrent access to the guarded code in
console_flush_on_panic() where console_lock() is ignored.
Using a full featured spin_trylock, just to get memory barriers
right, looks like an overkill anyway.

Fixes: b0940003f25dd ("vt: bitlock fix")
Closes: https://lore.kernel.org/all/20260114145955.d924Z-zu@linutronix.de/
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/vt/vt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 59b4b5e126ba..5be64d1bba91 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3353,15 +3353,19 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
 	unsigned char c;
-	static DEFINE_SPINLOCK(printing_lock);
+	static atomic_t printing_lock = ATOMIC_INIT(0);
 	const ushort *start;
 	ushort start_x, cnt;
 	int kmsg_console;
 
 	WARN_CONSOLE_UNLOCKED();
 
-	/* this protects against concurrent oops only */
-	if (!spin_trylock(&printing_lock))
+	/*
+	 * Prevent concurrent printing in console_flush_on_panic() where
+	 * console_lock is ignored. Easier (serial) console drivers
+	 * have bigger chance to get the messages out.
+	 */
+	if (atomic_cmpxchg_acquire(&printing_lock, 0, 1) != 0)
 		return;
 
 	kmsg_console = vt_get_kmsg_redirect();
@@ -3422,7 +3426,7 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 	notify_update(vc);
 
 quit:
-	spin_unlock(&printing_lock);
+	atomic_set_release(&printing_lock, 0);
 }
 
 static struct tty_driver *vt_console_device(struct console *c, int *index)
-- 
2.52.0

Best Regards,
Petr
