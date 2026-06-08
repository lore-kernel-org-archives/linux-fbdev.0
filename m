Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC22EB5A6
	for <linux-fbdev@vger.kernel.org>; Mon,  8 Jun 2026 04:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780894264; cv=pass; b=h3sxig9hfveLOA28k+CWCkwdkXQFrZ+krDzB5vWYJkDYg8THCypc27qTU1vyP92laGC0W57JLuCn6w5I5A8a3d3QPXoJV8ixNc6gCK3y+LNrcjGb3tAMCNMkkkLroW44Ws95Toh2xsko5E0GEDVlC0hC5ADmzjuIYXblFuxbqpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780894264; c=relaxed/simple;
	bh=ruLdARqDCni48cQOkidWdNO1xRKIushOB4xhN0tsI6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrRJojBDDHv1R7bK65wOde8kBvGGSihhvkL1bPmcnp6Y6ac8WLzj4r/S7x5oRAVQNGx3fll8gGnBeihytUHsMhrGx6QKgfGXSZ5FE4cwQHYdAcrh3Frq3m9juEWzcqZBxqRA8C6vZMEycY4JAVo6omIU3jqMvR6QqcnOybnHiIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh0Wr71H; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh0Wr71H"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8ccdef9f3d4so45560656d6.2
        for <linux-fbdev@vger.kernel.org>; Sun, 07 Jun 2026 21:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780894262; cv=none;
        d=google.com; s=arc-20240605;
        b=D7mPZ+9aOWCSX+paboqUK4sV+oTY0H46swO1M8eNoFfkST/vGu1GYX7Jw+1zxyog2D
         cp20lcwW4Pek735Suecz0V6zb5nlwLZaKFlPomAEQYNjsnqPZ8i1erx7h1tgwHAjDJpX
         z6lhzS56WeWgygdLzQ2GiZGQF//orUUFdWi5Jh/dx2ZFJaaw5HHkQO75e420yHfFJpB5
         HQcF89v3xfz+V9a1ns0LR/2hjVnSKtApQRAPhHSbanLC7uFr2wo0NZRfUQ7uqNIBJnGS
         RgzhsRGQnCbJMw6Goh+VrmZv/HUjv7+mDNsT6RfIQZm6eXwybdJ0+sJEgD1VfQ34jbZi
         ARFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ruLdARqDCni48cQOkidWdNO1xRKIushOB4xhN0tsI6Q=;
        fh=UYd4uBD9KpDVLhI5XK6oUbpv2nkluIKT2vzTPI491l4=;
        b=KQQ717zmu9BkVPps5H+4C+nbx+pb5RKe6SDqZhTcdxU510DbQj+3Bl0GT+TFmfTSy6
         6tnehLCyOVEzOAGVR0xSR4iHigBUrKE08kBmJyXmEEfsWDE2fCKeobRctDYo/VkUddyZ
         O0jiZNY7IYr4si6gdKw4h8Nk9aTknZbdB05k5PAW+yBKu0CpnM6uBI/wg4nF/9ntf4EY
         jUTqcq0sqYeE6SX6qFyIAd0klNrAMdnUeOpgyY4gGVnjbqDVgLclVbf8+B9GkcGKPtxy
         RWe/esqoMemLCgBB+RDIQ7/s+FA9uixz/X8aeY72h80TMH8uHDnmoQb0aSFMl55ZzMvq
         cT+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780894262; x=1781499062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruLdARqDCni48cQOkidWdNO1xRKIushOB4xhN0tsI6Q=;
        b=Dh0Wr71HmyJQEJPpZpMJG01oYy5iShDjxyzfG6H56MWe71pS0x4dQD6VWahtokXE5n
         aBYwG0AZdjDl+f4+Kc+4GFz4vyE93rkYKJD6qiBpt8dAviT/fMVN8CceD8YFSw1rqvlp
         5VqeS3sGyMlqUTQP9z0IgTolnErllz7MR7bc7j/cfceSAz5x8n/CDyDQ2nomYv+SMEGf
         fT3Hy/38A6fYW1ETiEehRlGGDp3ZVdYzTvp040QiZsehEk+zuqAM4v63D5zxbGuHkMSN
         7N8lL+KSq5uSv5kKcfjxgwjynQakMMjScBOr8gadW2B6hPyHc+hr1qBaoA2MXvvpLZwG
         0CBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780894262; x=1781499062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ruLdARqDCni48cQOkidWdNO1xRKIushOB4xhN0tsI6Q=;
        b=X4VfC9/r4Ih3i6rYBx4/YcqmjXrQrL62G7zF3c0Mc7kmE68rcQMYExSwzwCXGZED7+
         z+KZrwiBxR8/aKDXDG9D9qDPDEgDp/kyPFS21anm3DU19utDB0ktimnH59RCAtuGMAK1
         VtfOZ2AeJtBa9RhmkDmig8akuohAeACOVQzdaQ6+phOQq7A5AFN4mPUssyVf7DwDI8TN
         wVDvHB3l2e7Xm3ktX9XYTYl/jiD70E3Pf4KfQR17PoYf8YRerIu8S7zeC/9IBjzOjddP
         C/yXIxevM9tDu6UmJIb1PRuS2ferpHTElX9i3+mnYsIW4KZMYQ83TBQRkid8HsnQZl0B
         hRFQ==
X-Gm-Message-State: AOJu0YwqZdHRUTGhamfMMQT52PrMc0jZSeumLaZdsnbw89Rng8iu7y3v
	Q+E5O8mgUsXWFe0CMCKELoChiMQ0T0B2LzPcTE+Ysv/u2DLguXHikRYnqkkF7Ac/xJLWusC++zh
	/APnHv+dtmHGa8A5fi2kPc5R19yiXKDXy/t06
X-Gm-Gg: Acq92OEu7BNwR6i7GFykOB88Go4qhMtwuT9OCO8SQ+861jmbjDSJAnxb76cdFfBPJzv
	DkWpz7ZpLZwC9mQtzy4Z5ppmohKzxPhSHL6VZDH52+F9fju6QPMVddolQsDyGqCnJfKMygVTLZg
	mJyc12Vk5vBc9OJ4LIYHNL9pvsLJFhtQzU9yINH2Mv4Teq1MmxuNE80fmFi98uDewO8EAArB5fj
	wYSRn4ND7U+c1hDAFsZjzPbs+uv17WgfnD1xx/xeRTfo/gtqSxR2jaYS/hNpyejxEa+j8eFfyYb
	JmVukq/4bgRlhrkcHpu0J3lO7+hNlLf/hj2o2y8+1ODbiyRttuC1h8mKxf70ENnEhbuga/u/8fB
	T5q4=
X-Received: by 2002:ad4:424d:0:b0:8ca:25d3:bf41 with SMTP id
 6a1803df08f44-8cee5fb6f45mr156665376d6.8.1780894262219; Sun, 07 Jun 2026
 21:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607210203.229613-1-deller@gmx.de>
In-Reply-To: <20260607210203.229613-1-deller@gmx.de>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 7 Jun 2026 21:50:51 -0700
X-Gm-Features: AVVi8CfzWmWWxt3SB7pXX23oNZUjMnDgx_nKjpLYDIPyHFfppWEBqDIhw4T6cu4
Message-ID: <CADkSEUjJErZyBQtGDpdbt4iTx6hHZhizRJV1mRONrHjV0W1WUg@mail.gmail.com>
Subject: Re: [PATCH] lib/fonts: Avoid unncessary 64-bit math in font code
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 2:02=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:
> The text display code used in the Risc PC kernel image decompression
> code uses arch/arm/boot/compressed/font.c, which includes
> lib/fonts/font_acorn_8x8.c, which further includes <linux/font.h>.
>
> Since commit 97df8960240a ("lib/fonts: Provide helpers for calculating
> glyph pitch and size") <linux/font.h> contains inline functions that
> require __do_div64, which is not linked into the ARM kernel
> decompressor. This makes Risc PC zImages fail to build.
>
> There is no need to use 64-bit division code here, so resolve this issue
> by using plain standard addition and shift maths.

Hi, Helge,

I can confirm that this patch fixes the issue. Thank you for your
thorough investigation.

Ethan
