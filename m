Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261405;
	b=fUfmQIcpXX/hzgp1Y6UUSP285inG6MH394etYxNEeo/c2w4TU19CE2QWeL3AvI9IhMyq
	 4W2aY9JJFR8oLn/lJcdpGzCt9nyRdA6s3DBTHy+J/ClY71qY1K7tLO83UU6TT/74dC++N
	 r86YQPd2NntG1rDxCPk+TA1pqd81VT+pBwqbAr3fyWM0lzNl9gAG21nkZYOq9lvWAMqZD
	 9Qyl/c6Qy8JMLmH+UdswVUoxz2hwLn0xuYvZ1Gg0upTMoWxLYUzVWCpg+HJ6lcJ1tLWZC
	 2/GQXD2WSAsa8QNWRptKy/nr8+0uTXQvNNnX+P+Y6W2HadveJCDS+81VfQgoaUiQyOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261405;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=j1N3C4wGR9ui6A1aTKEotaU/WbKyfzJohGbZeH+69Ss=;
	b=evA7nynT/WLs5pjd3R9FUpiFtInc2xqXlu//jz8zIqtqjmj8OzXJ5Kjxto83Q9QiHy5p
	 Aby9Y+zLqJvFVd32wpU/hvCLOSqwSojhe6CqNijRLIKmQxshtHBTkE4BTsOhF7+tKR5In
	 chdETGgDlUHasMQrPWmvqlLxPO4EzcAWTraohNfPGwXp9rHHFk1Xl/sBi1bkD6yX5xkwJ
	 mgqq/QumePa7PLdke+q7NAm/Q+AbYQvlhibsaOs7BAXKToXgU+Ufx2bkgdHv8UOSQYWb0
	 nQy26Pn0t5kWQTosoRqt7uFqIWM0EUvqgaN0ppKKsJT3gNe7J4gF5C0H8U7biqeo5Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F596606A323
	for <linux-fbdev@vger.kernel.org>; Thu, 29 Oct 2026 08:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F596606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so1679338e0c.2
        for <linux-fbdev@vger.kernel.org>; Thu, 29 Oct 2026 01:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793261403; x=1793866203;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j1N3C4wGR9ui6A1aTKEotaU/WbKyfzJohGbZeH+69Ss=;
        b=YlD3tYOY7EkRE28UpO9obyKeoKFAJgbP5TCln47+Ptcv++ON7Px4sGcYz13oEgDk10
         Rfm7+xWi3cDyBF16KFMRkEdZwaUknC2whBeIck3/2gtak0X+C21H1nwL28f88eyImSti
         NY0mAetzTTpzMc4PShxu6f13L0eL5Y/ByqiVTh7/XJcEA+s9uQQ97tzUfzEQdT5I2E1l
         QVArAUBvKFj+uvaeJWqZIM3Jl8nnwgQqSQ2nF9WHi40YWFnWZ3YBOnz7QNvn12FoLTES
         6AwNAXVZCxWU37T67HKpFdBaX1uW2gv/q8PjqYUAR2LIIRfbiLqImW6wpYWL5wgRtqNI
         dAhg==
X-Forwarded-Encrypted: i=1; AKwUvBxAX+N5ZJsgLtQbQdP4RidCzOJosqGNwN1PcRA01hC9fgIDtlQEKBOH+REEsLVT9bLAW3zBC1sqKiPgGg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK3whC5urdIKiL/ArIBcXxz1rMglGCY3/L/yNaoqHjZ5JMVY8TH
	sdbZO2jueg0uAdGXD1I7691DoRU7WttbjyaqMm4o1K0762ZhLg7GxFRIID0fl5ZS
X-Gm-Gg: AYBFou130eRhOQeM1Ke70FNZLypcZlPYObVC5kut61dc7mI5kWKbJqp0XXYDm99hkVw
	r3r02LcOHDPD6bTs1b2lsGkuzU0yF/sHOWcgvyxZYTZE3Rw3eKsdN1CYMxVieDMLcpbLJ2/DPww
	/C5nPeWx+yHgIPo06XyDv3dIf3Kr/WgfFqpsu296RH6w8O4e+seuCy97gd6JZ7PuRodY1CksEey
	WTTDADLCzy8D25mxNveZixu4vTo+l2BAtxgRSpvK8pI2baVPKXwHK47YwrWgUUvf85TgOXe4tLV
	FdJCcp4k7z4SUosshiQErwfU9IOk09ff/2aTcXnvKs/IcI8qt+bKIe13qDbcTQhk695XWDsvBTb
	HY0JNIGDI/shlJQ6C7cmuGDoMpCnCumoEdB7dV92YcKG2+jN956lOdYoQkg96q1apA+2VzHJu8J
	A++XTElEfkcMRix+Jzx5oOTeGVM0DzqNE0CM4AFvuiUV/JaeN+TcboXZBxY6+j4XgioK97N7+xF
	0vYI3wzZikfd6xLf3kP28/3wzClXYjpJJRHgaSKlUFUZtOMGp4n/wZXpf8fgW1aGksuOWZRZgXO
	RjR9ADdfbRz92d77GMU86Bh+aU5LySsyHfzj9Qbs8hYFQJMKAn1BBbr1GPLQmjqM29Q=
X-Received: by 2002:a05:6122:32c3:b0:5ea:9be5:a854 with SMTP id 71dfb90a1353d-5ec4cc61aa7mr2728877e0c.18.1793261403295;
        Thu, 29 Oct 2026 01:10:03 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f92e3e3sm4560134e0c.9.2026.10.29.01.10.02
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 01:10:02 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so1769925241.3
        for <linux-fbdev@vger.kernel.org>; Thu, 29 Oct 2026 01:10:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzVkcLNtSvnrkqAznM+e+gfRLPUPi3t2BkIWkcfSrNWz3TvDnxfy3JbWY+pwz8pERHtDiiUMfmCJ/LR5w==@vger.kernel.org
X-Received: by 2002:a05:6102:3eca:b0:7c3:f07c:f49c with SMTP id
 ada2fe7eead31-7d03a503c53mr2112556137.11.1793261402712; Thu, 29 Oct 2026
 01:10:02 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027160914.3787276-1-bestswngs@gmail.com>
In-Reply-To: <20261027160914.3787276-1-bestswngs@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Oct 2026 09:09:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUBAFGH-YoF5iTSXuX=tFjXXQhXYyxnT=-XJ6qEGym7PQ@mail.gmail.com>
X-Gm-Features: AclHuK98HJBR5jB_yT7cph-_YLUIP8WBWM3UvHpqvO4YtLNQFtBwwRQ_iZsfTT4
Message-ID: <CAMuHMdUBAFGH-YoF5iTSXuX=tFjXXQhXYyxnT=-XJ6qEGym7PQ@mail.gmail.com>
Subject: Re: [PATCH v3] fbdev: vfb: Validate framebuffer geometry and memory size
To: Weiming Shi <bestswngs@gmail.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	co+b0df61d49532b2ee@bugs.sh, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Weiming,

On Tue, 27 Oct 2026 at 17:16, Weiming Shi <bestswngs@gmail.com> wrote:
> FBIOPUT_VSCREENINFO can supply a virtual width large enough to
> overflow get_line_length()'s int multiplication and bypass the
> video-memory limit, allowing fbcon to write past the framebuffer. The
> offset additions can also wrap, while an excessive videomemorysize
> module parameter can be truncated when PAGE_ALIGN() is assigned to
> unsigned int.
>
> Cap framebuffer geometry at 8192 x 8192 and video memory at 512 MiB,
> keeping the stride, framebuffer-size, and generic fbdev drawing
> calculations within their destination types.
>
> KASAN reports:
>
>   BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
>     drivers/video/fbdev/core/sysfillrect.c:24
>   Write of size 8 at addr ffa0000001671000 by task poc/198
>   sys_fillrect
>     drivers/video/fbdev/core/sysfillrect.c:24
>   bit_clear_margins
>     drivers/video/fbdev/core/bitblit.c:247
>   fbcon_clear_margins.constprop.0
>     drivers/video/fbdev/core/fbcon.c:1410
>   fbcon_switch
>     drivers/video/fbdev/core/fbcon.c:2261
>   redraw_screen
>     drivers/tty/vt/vt.c:994
>   fbcon_modechanged
>     drivers/video/fbdev/core/fbcon.c:2693
>   fbcon_update_vcs
>     drivers/video/fbdev/core/fbcon.c:2732
>
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: <co+b0df61d49532b2ee@bugs.sh>
> Suggested-by: Helge Deller <deller@gmx.de>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Thanks for your patch, which is now commit f93dd31db3e23e61 ("fbdev:
vfb: Validate framebuffer geometry and memory size") in fbdev/for-next.

> --- a/drivers/video/fbdev/vfb.c
> +++ b/drivers/video/fbdev/vfb.c
> @@ -31,6 +31,9 @@
>       */
>
>  #define VIDEOMEMSIZE   (1*1024*1024)   /* 1 MB */
> +#define MAX_VIDEOMEMSIZE       (512UL * 1024 * 1024)

Is there any point in having a larger limit than 256 MiB
(i.e. MAX_XRES * MAX_YRES * 32 bpp)?

> +#define MAX_XRES               8192U
> +#define MAX_YRES               8192U
>
>  static void *videomemory;
>  static u_long videomemorysize = VIDEOMEMSIZE;
> @@ -142,6 +145,10 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
>                 var->xres = 1;
>         if (!var->yres)
>                 var->yres = 1;
> +       var->xres = min(var->xres, MAX_XRES);
> +       var->yres = min(var->yres, MAX_YRES);
> +       var->xres_virtual = min(var->xres_virtual, MAX_XRES);
> +       var->yres_virtual = min(var->yres_virtual, MAX_YRES);

This violates fbdev API rounding rules:
  1. If a value doesn't fit, it must be rounded up by the driver,
  2. If a value is too large, -EINVAL must be returned.

>         if (var->xres > var->xres_virtual)
>                 var->xres_virtual = var->xres;
>         if (var->yres > var->yres_virtual)
> @@ -159,6 +166,9 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
>         else
>                 return -EINVAL;
>
> +       var->xoffset = min(var->xoffset, MAX_XRES - var->xres);
> +       var->yoffset = min(var->yoffset, MAX_YRES - var->yres);

Likewise.

> +
>         if (var->xres_virtual < var->xoffset + var->xres)
>                 var->xres_virtual = var->xoffset + var->xres;
>         if (var->yres_virtual < var->yoffset + var->yres)
> @@ -434,9 +444,12 @@ static int __init vfb_setup(char *options)
>  static int vfb_probe(struct platform_device *dev)
>  {
>         struct fb_info *info;
> -       unsigned int size = PAGE_ALIGN(videomemorysize);
> +       unsigned int size;
>         int retval = -ENOMEM;
>
> +       videomemorysize = min(videomemorysize, MAX_VIDEOMEMSIZE);
> +       size = PAGE_ALIGN(videomemorysize);

Perhaps return -EINVAL, too?

> +
>         /*
>          * For real video cards we use ioremap.
>          */

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
