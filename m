Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B2733BBC0
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590928; cv=none; b=WztFYXv9S8V35E0LW6WaoWwR3SEukVMZUbvANeD4M6Qa/KOrukVITMfm6kSMpeqMb0f+V54WK0iR3MwVGyjhcndICsp4uSup5Wv9Xu7Gq6mR6qguhpvjLBlX7jwChoA01zTO7NLAKBmf69cmAHJCLnClIwp9yABWHTr0P6ac4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590928; c=relaxed/simple;
	bh=1GPlGKZgcb1DldoonD0OPHNoXEsNDWUi3TBlJQ2/goc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8qqRAhyKKpimGJONt8FWfr0xj9RcGz4WngSajwo2vVFEJ8+o9sJzsRONMyzIHIY0HrtL369PRfE6zH4DxHbj+x24k9RwlScx2/lfkg03XN7pkZWbW3irb5MvvMQWbTM0CwyBRcTiss79jzQ7zYutUy9Lmcmx1dVVClv0PAE6js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SV+SE//Y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SV+SE//Y"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so3962885e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 01:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769590925; x=1770195725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qAOxIVYTEue9E0jsTADeINvfipVSQ2+6/g8YDctDKvU=;
        b=SV+SE//Y+5F3DksQv4y6lLM9JJhsuUk/LhKy1Z2iWviotqjZvZRuzivoJAUf4WS3pY
         HXaqPlqKFg2/zrSeftU2o/v6EYfI2efFxfwo8qFEf0oTjNaTXvxBDOdHtI9B4L+8IAxi
         PYs4KrRfSDTZvynb7RAzB6zzHXMGXPrKYqR9QRrqy1OS3QHDqgZK1i3DyIpSGDVXYjvq
         eWZmn6QbqnjdQf7mCyU/tMXpXux1KAdLdQ2mtL6KXp0WcaoLrNyitgrCbhSbO3VArfCH
         YoG9Hk3U8FOsTpoaFA+zTMu8bZDgVTlKx3rAK67wJ58HUos1YqQpRV0FK1Yu7O+iAIRW
         GZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769590925; x=1770195725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAOxIVYTEue9E0jsTADeINvfipVSQ2+6/g8YDctDKvU=;
        b=GtoLdaOrAZVdgrTeHoFt3FSRowLexFxgLHRtIHo+gkmyrlO6NYNro5wYE89o0rY1e4
         h/LLy0OzDtH8ft/kZVEWWNkKBDi6JFHV7h1BusET/RvnprVAQXeRIfnqkgsliL1P7z+K
         jiT9Y7T3IptWlnbCy+YTHuJRmt+QQx6eC8SDdPM4573rf5ZMN1E+2vHjZCS58SyLcMg9
         /LW3CygWHQPAPJWZ6yCPm6Q3GBcs8HlGCa/cLQO7jnGePrPBZ0lqXbb6E5aVSidju/RN
         b9DyNTXn12lQv+OclZbD8xJ1HUOm3xwI4lTLTAg4V3sxUvNJzdDkA61GaTUvoIWI8Mg4
         AuJg==
X-Forwarded-Encrypted: i=1; AJvYcCV1BTuadlZncffJkk2x/S+bb5soijUS4ydVg8sKqRgRjshSNxmmcd034BEG1MigUz+31M7f0r053sZM9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7DUcycTU/NUOhsRg+BR8br1P79KfQK3iLyjBHCIOFG8MdtzSo
	f8CAB2xH7oOT9BkRNtIBo917JnjXOqFsBdekOqJfl3CzwpBygZ9OlglzC5H7yP/cO78=
X-Gm-Gg: AZuq6aK8+B4iXyclhvqz/U0nFu7W062ENFgL5z/o0UxpYIAPj+dnJFPgoeCIFgqwiW6
	GUXk19WPl69YjTYRVCbRwaMk3BIdYbRR9C1iIKCXsWPk1YdAZ28Zot0ls57snVtYnn12BJGGumf
	4wYQ4PARi1k4EHz6cl2NQ0MtzUtmTPgUg9wPSv8LtGTHwbhph48DhVnXM4BytwcJmJcH3mzXMAa
	AgMN6WYQ1mMXNcHNEZMtH5cQ0hBBp4c8D0/dN7oIJOJN0gpPyj1V1lEIWkdz1mGgSb1bU78gVjx
	yFxOI60g9hG0uKGeE177ipyXcv58SJxz1iJ7FTyBqlkeq14TxzIWSSxjmn902/cmb8Iq5G/Yu37
	L7k5L0/Y15riK1QThCSHVOW9ix5uJGYI6NEMB/0dDbz025oCLb8HMLjNDn5qVbC6IeC9Tyl3NdZ
	619mi6EfiTAgFJpA==
X-Received: by 2002:a05:600c:3154:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-48069c1a7ebmr50821355e9.11.1769590924606;
        Wed, 28 Jan 2026 01:02:04 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee7d0sm122234435e9.4.2026.01.28.01.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:02:04 -0800 (PST)
Date: Wed, 28 Jan 2026 10:02:01 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] printk, vt, fbcon: Remove console_conditional_schedule()
Message-ID: <aXnQiSBskXo4RDAL@pathway.suse.cz>
References: <20260126180836.SNCdMW2f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126180836.SNCdMW2f@linutronix.de>

On Mon 2026-01-26 19:08:36, Sebastian Andrzej Siewior wrote:
> do_con_write(), fbcon_redraw.*() invoke console_conditional_schedule()
> which is a conditional scheduling point based on printk's internal
> variables console_may_schedule. It may only be used if the console lock
> is acquired for instance via console_lock() or console_trylock().
> 
> Prinkt sets the internal variable to 1 (and allows to schedule)
> if the console lock has been acquired via console_lock(). The trylock
> does not allow it.
> 
> The console_conditional_schedule() invocation in do_con_write() is
> invoked shortly before console_unlock().
> The console_conditional_schedule() invocation in fbcon_redraw.*()
> original from fbcon_scroll() / vt's con_scroll() which originate from a
> line feed.
> 
> In console_unlock() the variable is set to 0 (forbids to schedule) and
> it tries to schedule while making progress printing. This is brand new
> compared to when console_conditional_schedule() was added in v2.4.9.11.
> 
> In v2.6.38-rc3, console_unlock() (started its existence) iterated over
> all consoles and flushed them with disabled interrupts. A scheduling
> attempt here was not possible, it relied that a long print scheduled
> before console_unlock().
> 
> Since commit 8d91f8b15361d ("printk: do cond_resched() between lines
> while outputting to consoles"), which appeared in v4.5-rc1,
> console_unlock() attempts to schedule if it was allowed to schedule
> while during console_lock(). Each record is idealy one line so after
> every line feed.
> 
> This console_conditional_schedule() is also only relevant on
> PREEMPT_NONE and PREEMPT_VOLUNTARY builds. In other configurations
> cond_resched() becomes a nop and has no impact.
> 
> I'm bringing this all up just proof that it is not required anymore. It
> becomes a problem on a PREEMPT_RT build with debug code enabled because
> that might_sleep() in cond_resched() remains and triggers a warnings.
> This is due to
> 
>  legacy_kthread_func-> console_flush_one_record ->  vt_console_print-> lf
>    -> con_scroll -> fbcon_scroll
> 
> and vt_console_print() acquires a spinlock_t which does not allow a
> voluntary schedule. There is no need to fb_scroll() to schedule since
> console_flush_one_record() attempts to schedule after each line.
> !PREEMPT_RT is not affected because the legacy printing thread is only
> enabled on PREEMPT_RT builds.
> 
> Therefore I suggest to remove console_conditional_schedule().
> 
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Fixes: 5f53ca3ff83b4 ("printk: Implement legacy printer kthread for PREEMPT_RT")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Just for record. This change looks OK from printk() POV.
printk() does console_trylock() and calls console_unlock()
with preemption disabled anyway, see vprintk_emit().

VT code still synchronizes some operations using console_lock().
It is possible that some non-printk related operations rely
on this. But it is hard to say. It might actually be a good
idea to find it out.

Also I have seen many printk-related softlockups. But they
were always caused by slow serial consoles. I can't remember
any in VT code.

Feel free to use:

Acked-by: Petr Mladek <pmladek@suse.com> # from printk() POV

Best Regards,
Petr
