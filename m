Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794806654;
	b=bwIsBEU8RRjqv0baBH7+kC5FNJEb/Ydgs/sExRluGw5ugSocpRd7EQfB7gJ89Uemy+Xi
	 VV7e8k3dp0g3Tquww4QOFa3JUhJbm0BBRAdHAOEmMFVr6AGH5cp6t0W4sVFT2nos4nfEl
	 dS2SbQVx9HdzWFGn3WLAbOhXSkygJ+puZPAUQFr4Nf1hQpqThbBQrwyHwpTRkNmAWW6Fz
	 oYyfJO7MeIamiwljB3g2TBTwRpMB/kVfiwQjDzmp7KSC40p1xSRVyh2bZfeLvJGE3G2eR
	 e4VOCjhTpOkd5oxAJyDqFJ2HfsMw+1N9zQszrX7o+rk82zmHOaYMarWMwYIDW8Jou7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794806654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=nETJmKCVqPlTrkNAEmg4/bOwp28yMSUgmfSsOnU7Qbw=;
	b=cH0UsQsTExOpQdDQA3NuuClwTNh4io8TPDpBDiAE3seMKZ4Zayfw5CseVRv4OxE3oWEk
	 JKfiN2fUavVJYAEyVRYwO4HF8jxoXC58fgPU3kpYBfhy8NsgUFlr3jSjSEekFmggPLK7p
	 UJud0b3hzbXNVekjEwfGq2hh0+Z0Vn3GkfK4bIoY81w9tfXvRrOzbYX6VfIQUtouOM1E9
	 /fmEQpOb/gN6yLdLl9sKOGKC6HM4aKIbdPccBoqadZ8Vu9ApAH/te7Ie5Zg10LN2pIm4i
	 3SM9/I53vSweh55YG9+8xhYGBIgd3HkRfdwcNyc4gxpHajPRlH5Wl3/mPse5lE8E1WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B7XoiCVB;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F35606A329
	for <linux-fbdev@vger.kernel.org>; Mon, 16 Nov 2026 05:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31F35606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B7XoiCVB
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso17314775e9.2
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Nov 2026 21:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794806652; x=1795411452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nETJmKCVqPlTrkNAEmg4/bOwp28yMSUgmfSsOnU7Qbw=;
        b=B7XoiCVBWcLLauFc4QQM/czqNFSGW1NPGEfC+PyLmIqjrGv1oyrbV/aVLl6zGTvISY
         mXsfDCE4NkfbirtgGxoAe3r5ZJ2pFCadwgOvvA73ODxZMbLJ3t0AGec7DKCvU5vvQPIS
         hQsfJOOHDDQ26/tEpqe4AYDkTinH3kqYEldVRAl2ShxhnOKGWBm0SZlUx+tvh318kmI+
         +kpKyUGjpB2S8IAoK/fVAH24W01WgTtGLEQThqfETm5D3u8eGhSVwS7cq0ZAjo/6u7UC
         4eYSgPjmbTzW35oP8Yb4JsqZBZCUfeBam8p/y8NtkVw9SIFOO4ghTbXX2FynX7L+0d7x
         qkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794806652; x=1795411452;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nETJmKCVqPlTrkNAEmg4/bOwp28yMSUgmfSsOnU7Qbw=;
        b=vGzkhMAvLprH6vE+Q7AV1oQGlDsWudZNjTE51H8R4YjOd0vGmE8V55jNQsSYOF7DUP
         FMRdgjqXEsiELrP29ZFzTDldFHFrsLwHNYMRb81cY9YuTeMeB8LZjWajIS6wnygz+75g
         B0xpXzwQLnw+FTkI+Qur5K0pgbtNEnTr9AAb+eWnmsGt/Vhz5S7+GkfWcX5VuitDh5bg
         ui6e0OLNFRcwSnF+TAxV4zniHFhkbDT6cNydRn9V8a/KROIkfrbCujDTs4UkcOQhTw+o
         XEQS7pDB34g9iYDA6JWtBGylqoBrDPijsdNmjxrRKiyO17I1cGLRW3/dc4FGbefcZRMf
         j5cA==
X-Forwarded-Encrypted: i=1; AL+hErGNY/BZgEJz4hkQy9EzfmMyip0fJ8frNSshYRCQmwDatzfz+ehkXpCZ8ch8uhdgMK0tBM7Hlc+KvnCXVw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9vjdzs78u5v8AR12N7/dz7Rp/SgM8rsW4xwUxGdIPOC+4pEuVR
	b/M78tepK5+Mgeo96HpVESwHIbC4NYYBVmYeTOCGomFMCgENvNmlhmYM
X-Gm-Gg: AYBFou10xLHII+BR6mx20dSHvXlw/Zpq4EA2AqG7+q+K6yWheTDkRYW6SqzFmBmw/jH
	r+8SNzmC8nq1B9ftTCvFFsjXengsq/4bPZXcRu/1jwPyuAX5PyXvyw2siWqTKaII4xesMzH1BbK
	UZo1hBAy/ETEIm13lWnuvfWVQ4lkxQUfwJQUQrJgkvB15APH1Ujg0zWKyrly2HevD6+Na3vWRdb
	7IV9MIkCkCvbFNc3yc1Pm7xMn3SuHG0CyXjim5Y6hgs+w5706DV6OcJm9Ee04NJUlzZDMzi+pPe
	CQeG2JqXkbMGdrK4UhpmvJ2pMXrZ/GHrMsAzkCvW8OUZ5Z+6/TbVESlSwepXICv3LdljOGcWlqY
	SAg6CD+WVQhZnFWFSQz4ItbDdt86JtM0Lun7rYUm7OnnUfzepKC5IYBKkwyNmXI5yFkDO/SXKhJ
	Nve+TYD9HLuY/ow7AHKlA1bfVeSS0NTtkgR+EcT4r1OdcPVa5Heg5SPb0oo/4vuVbKotdhQK/ON
	EZbNRzPqOVTdWzey1YfNGbACFH70TJ2zL+R4tGYli4XJEgOXMgM+UzkP3MgKp14yGowCjE24W2l
	vSMOoUvxYeCNUqH3FKC+9s+rcqfkHfFdtAjxEB3bnUha+5sI056dsfYI/8v8vugjqqJPwFm9jhv
	7lwLZjwzQwDov+vrCY/XxW7qiwAgsz82rpgyL8CrDhfKJdhk8d9BdbPdIhV2UpzhLmP0=
X-Received: by 2002:a05:600c:4ecd:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4bb5599a73fmr224061135e9.0.1794806652295;
        Sun, 15 Nov 2026 21:24:12 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb64ec7b58sm194039565e9.5.2026.11.15.21.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:24:10 -0800 (PST)
Date: Mon, 16 Nov 2026 08:24:07 +0300
From: Dan Carpenter <error27@gmail.com>
To: Leon Pelzmann <brunonick1801@gmail.com>, sudipm.mukherjee@gmail.com
Cc: gregkh@linuxfoundation.org, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: remove ineffective sw_i2c_wait() busy
 loop
Message-ID: <avqTdwA-2E_-lKL9@stanley.mountain>
References: <20261115215427.112315-1-brunonick1801@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115215427.112315-1-brunonick1801@gmail.com>

Sudip, Is anyone still using this driver?

On Sun, Nov 15, 2026 at 10:54:27PM +0100, Leon Pelzmann wrote:
> sw_i2c_wait() is meant to insert a delay between the bit-banged I2C
> operations, but it only consists of a loop that computes a value into
> a local variable which is never read. The loop has no side effects, so
> the compiler removes it entirely and the function compiles to nothing.
> With W=1 this also triggers:
> 
>   ddk750_swi2c.c:95:16: error: variable 'tmp' set but not used
>   [-Werror=unused-but-set-variable=]
> 
> Remove the function and all of its call sites. The I2C timing is not
> changed by this: the object code of ddk750_swi2c.o (x86_64, gcc,
> allmodconfig) is identical before and after this change.
> 
> The W=1 warning was found by building the driver, and the change was
> prepared with the help of an AI coding assistant (Claude); it was
> verified by comparing the objdump output before and after the change.
> 
> Signed-off-by: Leon Pelzmann <brunonick1801@gmail.com>
> ---

This driver is old and when it was written the loop did add a delay.
It does the silly stuff to hide that the loop is a no-op from the
compiler but then compilers got clever and saw that it still a no-op.

The busy loop was added based on testing and is presumably required.

Your patch doesn't break the driver but it disguises the bug to make it
look as if the driver works.  We don't want that.  We want the bugs to
be obvious.

We have some guesses as to how to fix the driver, but actually we can't
do it without testing so we are in a bind.  We can't move forward
without testing.  To be honest, the most likely way forward is to remove
the driver if no one is using it.

regards,
dan carpenter

