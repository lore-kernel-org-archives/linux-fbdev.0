Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A84477998
	for <linux-fbdev@vger.kernel.org>; Wed,  3 Jun 2026 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490894; cv=none; b=uWccZjEWtX9Xx3e7YtuPzuiavehyENdqrn8Hey3gCyqBzg6IMARGtIE3rKDKi6DJbSTSEmJeYUwkqXxg5vFzPFLVYsSrjVKVRPa3YXciNMl/VnbqTV4KQpkwnZNCwxeHCPXrlIOspRrTlf3x/5QsNILhTeY2ktT+0VVpFp1Sjjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490894; c=relaxed/simple;
	bh=xlOXLAxObYM0H755ypmNgwyw2u8sfHRzxCVxtOPiR6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eavfd1sY7fbWkkFnF8ZEK+mdvmYySku5qjJ0yrxgTwZ8hm1mMFfZlYurNInW1SnH230y4G0AvMIqG6uxXzvy0Xzk/e3SH7zVVcs/4+wP4+ftRD9Q48j/PWzY2mIKjpaqBvF1ly+zS01yVXUPz/eVMeqW4/tqCP5Xffjs6Os5UGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFRqvq6p; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFRqvq6p"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso38605675e9.3
        for <linux-fbdev@vger.kernel.org>; Wed, 03 Jun 2026 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780490888; x=1781095688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVsxgh2ujbRwP+s61o1Lj96pnFL7ang79UkYU7JexyA=;
        b=cFRqvq6plQZnwjW1N10E+4jlpg1bKDo3EqO+vO8sjh9OHZhIedszNF+NAhokMnyyDh
         qI3qO8sBZ/GXjCzS9F4FQ54h31PbGN6AZYBSHSOPqI051BXvXugtP4bwzzpGMl+HYK6H
         IndiXj8r2LBFHDUPaIMHxbqnC14UENlglKPipY295Qt4LjuXDv4xQCjVmu9OWF2Vek+e
         u+MYhvHbwv+FEWfxLYMzZlP+5CcAxP1PSNuQVvJOIlwVO5t9KN4cVhzE9StIImU/j6Ly
         43bY9LVD46ucBV0BG0NH5rNxVHrNxWCIKnkhWuhoyxQKXEsevavlsqt3Vfew+q/utvP1
         wYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780490888; x=1781095688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HVsxgh2ujbRwP+s61o1Lj96pnFL7ang79UkYU7JexyA=;
        b=s9bf+KMNhQ5hXjZatvY+fGlYWJMtGZGiZVPmCNVpqkgvwvpEtRiGiIUeYgRiPiw1ic
         nUTfVoyPJEL6Rv9T1JlRAECZNrcQKvOyhY2ouqDtue3PLJzch8vIanJoV+Qoe/IXAhPl
         uCDMISE5kiCVcKCbqI6lxP5YHZHOLVwBq/DwjHKA3RS+qLxErYzJ31WQoQGRDkd8JxyE
         7+i0fyYK6aias6NB5u80VXO4MUqk680tW3u2XGuM0cA7q1CyyT64T8dk8qn6vk3gXKPw
         kuwvJ2wKDLqpj2u249GXRQeXzk1ivVUgKnQ1eRBcMYQy6nX1wsiQwDY3/fwwBdYuTlKy
         7gZg==
X-Forwarded-Encrypted: i=1; AFNElJ9TMQwmeoU7s+trSeOy7nP90vXNb5X6DPqT7YCWc+wq1Rkj5q4tT11YRT2q5ka0WEqpYAUiV1WN4LhVTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhxB6u97E4SyHicRHbIOp1X5MrdA7r9KTmHXlcHqnlrmULmWz4
	RYnlXdU7N2/6yNDfy1HnBlRrTboWG15tbG0TREcsxuwtbQbkH+JaE6/N
X-Gm-Gg: Acq92OEMyYp0vD8WyeOCHRpnHJXM3J8bLBiQM8uXi09VTg9pIKGgK7kIILBMh+kjyeB
	lp+2tcF/xiTPmoXw2VjP65JV6uqHXLSHONi5HzIqBp9NLWuj40vblMwQ6zMEKJg54fwzcLcw5aT
	ksyT31XaAfToR3Ux4GFZJcVnSJkJryf4VSeQZuJmFGM+oBAaixThMnIm0py6QNoREtBIrTL56Qr
	0HiOcxA6Wkc3GcKP2kGuP7LdSGidYfXNJPto0uY2lZroT71tNS+nOxuG9DsEuqMHBqHpvbi8VYU
	tcUpN4Q23k2LT1S8g7IYjFld9iM0sS0UodnlFBKpA3UCDEVdVhWeY0T3lsr+V5ol68nwkXt0m04
	79scQVjR83Hcqs1j6v9TRetXUYX0jX2bQ6nqhoKZFa9HNO0c5hBXYpEPylsKf1cB9V9BJOkj8wm
	36t1t3WotclqhQYau3Gw4MHUBk4n0WwJhkr3fcVPDEuKNSHqRMR86FplAGKnXpj94q63ZX82I=
X-Received: by 2002:a05:600c:8b2e:b0:490:50c5:8153 with SMTP id 5b1f17b1804b1-490b5e73ed4mr48400975e9.2.1780490888332;
        Wed, 03 Jun 2026 05:48:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b6d16f0csm59311625e9.15.2026.06.03.05.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:48:08 -0700 (PDT)
Date: Wed, 3 Jun 2026 13:48:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Dan Carpenter <error27@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@free-electrons.com>, Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Helge Deller
 <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, Chintan Patel
 <chintanlike@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Use sysfs_emit_at() to print to sysfs
 file
Message-ID: <20260603134806.69df0b01@pumpkin>
In-Reply-To: <ah_cd9Ax4fzOhBp7@ashevche-desk.local>
References: <ah_Y_Y2RtqeGxchF@stanley.mountain>
	<ah_cd9Ax4fzOhBp7@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 10:49:11 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jun 03, 2026 at 10:34:21AM +0300, Dan Carpenter wrote:
> > This scnprintf() uses the wrong limit.  It should be "PAGE_SIZE - len"
> > instead of just PAGE_SIZE.  We're not going to hit the limit in real
> > life since we are printing at most FBTFT_GAMMA_MAX_VALUES_TOTAL (128)
> > u32 values, however, it's still worth fixing.
> > 
> > Use sysfs_emit_at() to fix this since this is a sysfs file.  
> 
> OK,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> >  	for (i = 0; i < par->gamma.num_curves; i++) {
> >  		for (j = 0; j < par->gamma.num_values; j++)
> > -			len += scnprintf(&buf[len], PAGE_SIZE,
> > +			len += sysfs_emit_at(buf, len,
> >  			     "%04x ", curves[i * par->gamma.num_values + j]);  
> 
> Can we switch to use hex_dump_to_buffer() at some point?
> 

That gets hard when you really want to aim for something nearer seq_printf().

Oh, the way the loops in the code are written doesn't look like
it gives the compiler much chance of optimising it very well.
This is probably equivalent:
	for (i = par->gamma.num_curves; i--;) {
		for (j = par->gamma.num_values; j--;)
			len += sysfs_emit_at(buf, len, "%04x ", *curves++);
		buf[len - 1] = '\n';
	}
and will generate much better code.
(Although most of the cost inside the snprintf() function - which is horrid.)
num_values better be non-zero.

-- David
