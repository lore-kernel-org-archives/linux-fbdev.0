Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9192F60A4
	for <linux-fbdev@vger.kernel.org>; Mon, 24 Nov 2025 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763976541; cv=none; b=mC2zMQXJz+KqqFIL46lTz6VzKYMVrCz4gMvl5I7WnCgYnDkDaf/8pDF8/7RvUT+fHbs6w5omjLMn/LWWIUV0lOH0UlThsv3yA1Y3sQi5dfYLLvnBNXSpsOYGQHsJ1lef7iU/ycsKzQEjfijYgktdwFquPd7KbaxsS8YCUYY6gAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763976541; c=relaxed/simple;
	bh=PUxuEYfHaMXKyRQa8nksQ38OVmVCrv/2GMdnL6jPYFU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GySAlG101kaDmV44t669gtcRRWWj7iKbequHpkuGH93jZKfsHiH5dtG9j8sOGRMQZZmZiJNliNA8vhDsk8YwIOO7tffEibKJSzuq4I/cFF5A1KutAbNVFFiLfzuS+5B4lJy6ggaKn3PugSV+ubVd72Bvi+gIgwBKEDAMV7gxDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NghiHQ1X; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NghiHQ1X"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a1c28778so44835545e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Nov 2025 01:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763976536; x=1764581336; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSUd6Iu5swY1yI3rOZ1kFsJAdObQXxI7F4AS/dEiKfI=;
        b=NghiHQ1XnuVAxJDYO9j5gFue3oxXZobpMnaAc0O0j+bvafBSaYiBWYoA8JSBTz/Fe7
         ru1UeThmjk0uBr0A8Cv47ChE1AcEqOdOafnSq7D8rLKnbXcEahyM8/Rib+sLwp9XB06n
         beePpTwd/p6pNhHiDDAShLzH6NjAisRkRKqQU7K8qjgRuqMYoCKnYsGyRm0x+AdvRSOu
         07JPh0E246JgrOqgkevqiOgE3wiQ8cevZCECmMZeVV+MNzWeZbXACSvm7LZXn6M4n90E
         vO0xdNpo/J2aFrwTJc0YwnKXiNfEbHTEuUC5Z6K/OUuykMKdW5VkCYcxmTBVl1w3ztNF
         XSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763976536; x=1764581336;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qSUd6Iu5swY1yI3rOZ1kFsJAdObQXxI7F4AS/dEiKfI=;
        b=SughTn83cOdNy3UGgmJhPpeZw+FP2Y71blU7LD/8K0Lyzx58XJVsCrf6na0L4K+kzt
         z0Gn1jy70imLmVc2+ps01rcNjdL5Y9VQyQbRdwKL6ODtNKE8/WxiqkueTUNiMf1u/6D0
         44kbnGcTB8iA/Fiee4VcI4WvZEX5CuATlL2bpma2F4G+tFzxvLftmz2djVJzTuSaMtmJ
         1aUR3o27zDyBiUBszczRpV51c8ljY9bmzZlK9ip74D7HW4jsRn9y22X6BCwjKMwLxUbl
         Ws4lu2OY685/2bAL/Tynr4UbUxntzEqlPb8lL4/xP9rsTDltfcxGEQTFcev4imEHRJ2M
         z68g==
X-Forwarded-Encrypted: i=1; AJvYcCXqUhL1aHipLl71bv2nq8xKHI1h38t1pyRRQgR9ewvYtXtvUP1CivAj/Os/vzW7qz1CHxDPbKxDY6p0Wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKjno447t1x0DyKGUyfAuzbJfPxklawlHK/8h3HA+6p9s7Selh
	O7IrMEscvA7xCiv6tee59xK85yj5dADu1jJP0OwPxN+JQkxg14vWX8t5QFpqMxJyKwI=
X-Gm-Gg: ASbGncsaQxNrytq9CdcTkf2C858gAxaLapK1Q1U7ce7bEmEswWukr06CzT9MPsBNF2o
	b5Cdb0MOVY+HYP49H16Dm1WY5fgzm0WOazssKzdaJZyMg2FUL2dFJ70+EFTeG0yn/Tb+TR0/R1n
	Ku8q9og/ZqpCtsOJbjnDCwI8hLnN5oliYwU91XRTG++k6BvALveZRT6L4gXev+CDTA8NF90ooDT
	JekwRsRAM800kTk4tLsUdysg9rbihM6ZZwPEzJ8bbGib6gvL7tzXP+krl+n8lGgP/quCiCIdAhU
	F1gbV8hhDboBHBpvZDts7x8+RAK6byTbj38mviqCbrUFdztGOMN+7BsLcNj0QsgjWit0RwdE17g
	fqrV44K495VcKJ2bPK+74Q1ZBtr1OBl9vuwqNW2ITw8TmDBoIkQ9PnTvfAJ2FK/oNLxqVCNRJVo
	m7klz1r0tIyZlFQ1iRgaksXPxVE+NDXYGDz12+/PEU
X-Google-Smtp-Source: AGHT+IGqX87Liusvu8VA+P6vAK2NQvQqKGFS75x4fPSdpk7QAnEFO6Q86alRxbuZVhECcom6UWrp6g==
X-Received: by 2002:a05:600c:1c0c:b0:46e:7e22:ff6a with SMTP id 5b1f17b1804b1-477c018a099mr145588045e9.15.1763976536416;
        Mon, 24 Nov 2025 01:28:56 -0800 (PST)
Received: from r1chard (220-129-146-231.dynamic-ip.hinet.net. [220.129.146.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b03c7515sm9757191a91.5.2025.11.24.01.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 01:28:56 -0800 (PST)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Mon, 24 Nov 2025 17:28:49 +0800
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
	javierm@redhat.com, arnd@arndb.de
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/6] efi: earlycon: Reduce number of references to global
 screen_info
Message-ID: <aSQlUVPfQrEwXPWm@r1chard>
References: <20251121135624.494768-1-tzimmermann@suse.de>
 <20251121135624.494768-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121135624.494768-2-tzimmermann@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)

Reviewed-by: Richard Lyu <richard.lyu@suse.com>

On 2025/11/21 14:36, Thomas Zimmermann wrote:
> Replace usage of global screen_info with local pointers. This will
> later reduce churn when screen_info is being moved.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/firmware/efi/earlycon.c | 40 ++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
> index d18a1a5de144..fac3a295c57f 100644
> --- a/drivers/firmware/efi/earlycon.c
> +++ b/drivers/firmware/efi/earlycon.c
> @@ -32,12 +32,13 @@ static void *efi_fb;
>   */
>  static int __init efi_earlycon_remap_fb(void)
>  {
> +	const struct screen_info *si = &screen_info;
> +
>  	/* bail if there is no bootconsole or it was unregistered already */
>  	if (!earlycon_console || !console_is_registered(earlycon_console))
>  		return 0;
>  
> -	efi_fb = memremap(fb_base, screen_info.lfb_size,
> -			  fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
> +	efi_fb = memremap(fb_base, si->lfb_size, fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
>  
>  	return efi_fb ? 0 : -ENOMEM;
>  }
> @@ -71,12 +72,12 @@ static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
>  	early_memunmap(addr, len);
>  }
>  
> -static void efi_earlycon_clear_scanline(unsigned int y)
> +static void efi_earlycon_clear_scanline(unsigned int y, const struct screen_info *si)
>  {
>  	unsigned long *dst;
>  	u16 len;
>  
> -	len = screen_info.lfb_linelength;
> +	len = si->lfb_linelength;
>  	dst = efi_earlycon_map(y*len, len);
>  	if (!dst)
>  		return;
> @@ -85,7 +86,7 @@ static void efi_earlycon_clear_scanline(unsigned int y)
>  	efi_earlycon_unmap(dst, len);
>  }
>  
> -static void efi_earlycon_scroll_up(void)
> +static void efi_earlycon_scroll_up(const struct screen_info *si)
>  {
>  	unsigned long *dst, *src;
>  	u16 maxlen = 0;
> @@ -99,8 +100,8 @@ static void efi_earlycon_scroll_up(void)
>  	}
>  	maxlen *= 4;
>  
> -	len = screen_info.lfb_linelength;
> -	height = screen_info.lfb_height;
> +	len = si->lfb_linelength;
> +	height = si->lfb_height;
>  
>  	for (i = 0; i < height - font->height; i++) {
>  		dst = efi_earlycon_map(i*len, len);
> @@ -120,7 +121,8 @@ static void efi_earlycon_scroll_up(void)
>  	}
>  }
>  
> -static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h)
> +static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h,
> +				    const struct screen_info *si)
>  {
>  	const u32 color_black = 0x00000000;
>  	const u32 color_white = 0x00ffffff;
> @@ -145,13 +147,12 @@ static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h)
>  static void
>  efi_earlycon_write(struct console *con, const char *str, unsigned int num)
>  {
> -	struct screen_info *si;
> +	const struct screen_info *si = &screen_info;
>  	u32 cur_efi_x = efi_x;
>  	unsigned int len;
>  	const char *s;
>  	void *dst;
>  
> -	si = &screen_info;
>  	len = si->lfb_linelength;
>  
>  	while (num) {
> @@ -174,7 +175,7 @@ efi_earlycon_write(struct console *con, const char *str, unsigned int num)
>  			x = efi_x;
>  
>  			while (n-- > 0) {
> -				efi_earlycon_write_char(dst + x*4, *s, h);
> +				efi_earlycon_write_char(dst + x*4, *s, h, si);
>  				x += font->width;
>  				s++;
>  			}
> @@ -207,10 +208,10 @@ efi_earlycon_write(struct console *con, const char *str, unsigned int num)
>  			cur_line_y = (cur_line_y + 1) % max_line_y;
>  
>  			efi_y -= font->height;
> -			efi_earlycon_scroll_up();
> +			efi_earlycon_scroll_up(si);
>  
>  			for (i = 0; i < font->height; i++)
> -				efi_earlycon_clear_scanline(efi_y + i);
> +				efi_earlycon_clear_scanline(efi_y + i, si);
>  		}
>  	}
>  }
> @@ -226,22 +227,21 @@ void __init efi_earlycon_reprobe(void)
>  static int __init efi_earlycon_setup(struct earlycon_device *device,
>  				     const char *opt)
>  {
> -	struct screen_info *si;
> +	const struct screen_info *si = &screen_info;
>  	u16 xres, yres;
>  	u32 i;
>  
>  	fb_wb = opt && !strcmp(opt, "ram");
>  
> -	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI) {
> +	if (si->orig_video_isVGA != VIDEO_TYPE_EFI) {
>  		fb_probed = true;
>  		return -ENODEV;
>  	}
>  
> -	fb_base = screen_info.lfb_base;
> -	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> -		fb_base |= (u64)screen_info.ext_lfb_base << 32;
> +	fb_base = si->lfb_base;
> +	if (si->capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> +		fb_base |= (u64)si->ext_lfb_base << 32;
>  
> -	si = &screen_info;
>  	xres = si->lfb_width;
>  	yres = si->lfb_height;
>  
> @@ -266,7 +266,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
>  
>  	efi_y -= font->height;
>  	for (i = 0; i < (yres - efi_y) / font->height; i++)
> -		efi_earlycon_scroll_up();
> +		efi_earlycon_scroll_up(si);
>  
>  	device->con->write = efi_earlycon_write;
>  	earlycon_console = device->con;
> -- 
> 2.51.1
> 
> 
