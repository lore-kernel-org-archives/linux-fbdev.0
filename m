Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C130F52D
	for <linux-fbdev@vger.kernel.org>; Wed, 21 Jan 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011688; cv=none; b=e4YvGGI1QZ6Fmyy+vQoKL2JD9XL+tG3WxMHj01WfrUEsr5onPpaSNYnmf9iqSpeOSY/ddxSL/Y46tOjeocAQ69A7VyQb6QaAwvZU21fMZJV1BVli/3Mr/0MqOjFtzZKKqKXZbqzkbT5xteRGoFbQwocFW4bQ93X0XQgX1HfN49E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011688; c=relaxed/simple;
	bh=CvbQrVmA1B6xeBzrWD46ToaJbCB+3kTz5b65FZW+DPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7mgO0F1qR/gFa8PsteXShMoHr8PwlMCsr9o7fuwvfqKrmhD7jonLjH5DAqsxa/jnNHL/4uxUjMycj4+qjnH+9kzposMh8WxGt8Mr1qkXu58zCar8wwVHFcHXh0uHKtJ3zvxCqgPNLjW5ggG78HyjkSqwXv5wJ7GHIc3qpSQOsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EhT7hpEY; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EhT7hpEY"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4801c1ad878so145455e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 21 Jan 2026 08:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769011684; x=1769616484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a/m+CBFSuaRKey5NW1eLVVltJt+NfVZlJh5CXQB3NHc=;
        b=EhT7hpEYeCmHmWtNQ8IpBop33UBUEmSN3I2is6nKQ12vqMMU7948r+GtCxkZdYEaOP
         u9vn6mXn7vrishY02k4dK6Qp6ecT3i9g7KOUH6JuYb0x7bfrr9V+Sg2VkcKPMz314/Td
         gr0ZlCoA4tHp6ZBXfUp4Z1NbaOY08lqt4rlsjpqx0oHOAQo2PsbTR8yqRLkfFOMhloH7
         e2NUpxPU1Nu3Wws01K4ShV9KEXANxrZLTmhvpE61Rz8rOcUdYWQ3YeAxS4YKE0x2793n
         mE5n1PexLxmUp6gGuXiRslMr9wqyuA6DuXGeTAIn2VzHAa/9SOpnvitjWryjBEG5rHFe
         JlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769011684; x=1769616484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/m+CBFSuaRKey5NW1eLVVltJt+NfVZlJh5CXQB3NHc=;
        b=VNwy9uXlu5uQf29dHsM0QQzHXkSj7nOTNTspC3FfZCPHYZLWWvYqXf9FAGKpmfuM3h
         mwB4MKRN7WYfkmV7D+3ZvVIaskH3xwT3odyWt9LxiO52Gjz43XLEo3CbodqlHRAm9UUS
         j1wslmS+zgwvNqeXN3RFx8uDNEPDrtPrxXE0nT65oPbljf0L3Q+xgaqlQhW2dOHGNaBt
         ZhE6qyt7Mpc0adb9ou0bUlgpurmpXeSTJBpXXzXclSQ57of/Ol2bajZC6xd9F3xD1JeZ
         rK2Pl9oNSU4UCU9Y0LvP/WptCO7mn2vaAFJ2RHlpp8fmzcyBfhdhgsFgWyFONHVVB1ji
         vyvA==
X-Forwarded-Encrypted: i=1; AJvYcCUoabt3XLs0TZk9d3M7aX4XjwIn3wtUsGsS1zduhbqEkl9dfwjYKxXERJwjVw+HyusvPQcsx3DpRPS99A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKBmhrcHQLmBnM81tcM/KQZD0hjRvguk4YYZKtpbGPBmWjTQ7
	ZWbsRW88RfZUxKzXpotF+aTd7//PPlpvDf88wLdOcxDyOV4CTZ/+VN1jcYLCd45resE=
X-Gm-Gg: AZuq6aJfHsjaajcAzVUZg1dRBR9jSU+AXSwHWX/YrAHhUZkvUX/OLTCdo8lH8pMLwUK
	jA68ZZJMWUILbYrdBpOwOKd9IS9qAxqw5sG/c1+q+wuBfy+TIPaRnxXXEZjM0KT8AyZEc+xZfwE
	4jm8ybmrUI6mnR+Scz2ySTelBq3avrKv33RW3OiISrspSozSYKHnv/Rr9iE9qppa1ge+dwhyO8j
	ZPOLdHkp0Yx2gRLR1pX31s9yz7sU7rMZm7GsnTZeE3YHwA8xfbP0GvwNoJovxDwIUSkKUmUPz0S
	G0yQihjBN1QFkPDaK43q5u4O8Cxh1OInX2kwDym48ozjFQjupZ0QYaN41wwKqmy4oIhbF+Yt1rO
	9SrAY7ko3Eo0lrUVpQEbsIcFNOWc0UTYUkrsiM/D/0N4lYxA5IlKqFkup7fzwO7Hqaxj9FjvgQH
	mENHlxiWYCUovob+Pi8EI5QjVt
X-Received: by 2002:a05:600c:3b1b:b0:480:3230:6c9b with SMTP id 5b1f17b1804b1-48041472847mr68408865e9.7.1769011683738;
        Wed, 21 Jan 2026 08:08:03 -0800 (PST)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm371807795e9.11.2026.01.21.08.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 08:08:03 -0800 (PST)
Date: Wed, 21 Jan 2026 17:08:00 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Subject: Re: printk's threaded legacy console + fbcon => schedule where it
 should not
Message-ID: <aXD54PcYpxQ-SeNh@pathway>
References: <20260114145955.d924Z-zu@linutronix.de>
 <20260120110845.2922a91a@gandalf.local.home>
 <aXDYEVlkFgxdSVSG@pathway.suse.cz>
 <20260121135737.K7b-4M5r@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121135737.K7b-4M5r@linutronix.de>

On Wed 2026-01-21 14:57:37, Sebastian Andrzej Siewior wrote:
> On 2026-01-21 14:43:45 [+0100], Petr Mladek wrote:
> > I know that there was a plan to get rid of cond_resched().
> > But what is the status now, please?
> 
> It is slowly moving => https://lore.kernel.org/all/20251219101502.GB1132199@noisy.programming.kicks-ass.net/

Good to know.

> > I still see more that 1k cond_resched() calls in the code:
> > 
> >   $> git grep cond_resched\(\) | grep "\.c:" | wc -l
> >   1263
> > 
> > And config PREEMPT_VOLUNTARY still talks about the explicit
> > preemption points.
> > 
> > > Should we just remove it and see what breaks?
> > 
> > Honestly, I do not feel comfortable with removing it. It is true that
> > it has no effect in the printk() code path. But the vt code is used
> > also when working on the terminal.
> > 
> > The vt code still uses console_lock() because it was intertwined
> > with printk console code since very old days. console_lock is a kind
> > of big kernel lock there.
> 
> Do you a have path which loops and would mandate it? I found a few which
> do not matter and have their own cond_resched() around. So I don't see a
> reason to keep it. And I found one which breaks things so a removal
> makes sense.

Could anyone from VT guys comment on it, please?

> > Alternative solution is to get rid of the spin_trylock(). The only
> > purpose is to prevent race in console_flush_on_panic(). It used
> > to be a simple bit operation. The spin_lock() was added just to
> > get barriers right. But we have a great atomic_t API these days.
> > 
> > IMHO, it is a win-win solution because a preemptive context is
> > always better.
> 
> So why do we keep warts again? Just because it *might* be required?
> Keeping things preemptible makes sense but this is locking with no
> annotation what so ever.

Well, the current locking is documented but it creates false
positives. The "printing_lock" is taken on a single place
using spin_trylock(). Nobody would ever spin on it. So
sleeping is perfectly fine.

> Again. printk has its cond_resched, the tty has it, too.
> I'm with Steven on the removal side.

As I said, the cond_resched() does not have any effect from
the printk() code path. But the other VT paths might rely on it.
If VT-guys are willing to take the risk and remove it
then I am fine with it.

Best Regards,
Petr
