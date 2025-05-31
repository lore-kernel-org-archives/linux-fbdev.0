Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D42DC13D
	for <linux-fbdev@vger.kernel.org>; Sat, 31 May 2025 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748734780; cv=none; b=nBjds55vA0HObUaviXWmHixnqRlH4afQ+ChoIIA8BcKfrqbIrCbZSX6vKv6Qa9BZuxsXTZPmN8IGpgFkt6XMU+6litByA3ERxSwf4D94IWjFfelv6r7zRFRiNlcYEdkFkepD45uK89rubiTILT7Vf8gVrEeREj4brK1EOFFM4JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748734780; c=relaxed/simple;
	bh=kd827Ce0hTuNaIlAkVXzNP84i6qA7l0LXFXBXg+hr4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMdSp6AaKjc5hqotHRjnugA2gMe4RrzXLwiGB6NO0l0pETwBeUso5R2NQJ/wL+LDUdG92bTKzxfjkZYYXm0aG/AmshXHimVoXRL1WuuQ+srsbIqxVEd+aS3qGdri+Pbq0NxBKvGinxwcexFKn8HEry8laAvfM8+uffsp+xwr2z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFBquLNN; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFBquLNN"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476ab588f32so43057101cf.2
        for <linux-fbdev@vger.kernel.org>; Sat, 31 May 2025 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748734778; x=1749339578; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9sa8jyu8zWOeQJ+jxCR5b96Jz7G6ZFhDclzi7FmbPs=;
        b=BFBquLNNUwQFQdMNp3PRnYhPrrzgDRPRzwM7Qd/QIkIyCobo4nomItPTF6Y7+TvSqj
         MS2YCJBFQbkGbH+GDqDS2wq25D+A8yps3UKYrHRg05G8hzxLg8SPnn0lNDvV4Z+/CT6f
         AQaRdCOZOZRN95nRFnr7KUfYK9dOX9+dn/Z2Gv5BzZmHUxbC2LKuSujGAkA+8WHNDMEH
         mTEtrEIXGnIoL6dxCCLlAhiIM5NJ4JC57XC1VXXYLih9fYdUyD+Pw3gqY0S/C38Be12s
         FxH46LJu8sbYNaxlpfKPrPQF0J855dctRn0Zat2jbpQN7+8zndR0m38tcLzmGmQEc4Zu
         f/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748734778; x=1749339578;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9sa8jyu8zWOeQJ+jxCR5b96Jz7G6ZFhDclzi7FmbPs=;
        b=ASMf1EL/Sr+0gGyv4LzZ8BzBmhnq0DgLGp9Hl9B0v93zAUYMnuRsgCWinoPyDCCvxQ
         ici1BiP1bT9CNPyov7MTCcGFRfake0pKuiE6oeAEuqJbCi297cTXNKDDxmy8qHEHRtQe
         RKfFhNutzzERuMI2Vm6AcB6WKBEYFh88tTj4SJquWwySL6UuvHT4d8uyOno9zz4Y9oWg
         oYDFvhPC1SQZiwx5V82Aw/KRpi68vkRa2Nr0Lghh4UHx8639wyjW3mBWgPUdUa98UuQL
         /4PpewQKKMVkqDin8UBmF8LWbfzGMyPVcDUrSPbWBzYpJjrwMiWTvn4CjJnVJk4GohEs
         7wZQ==
X-Gm-Message-State: AOJu0YyUMK5OcpPtnBBLIxRyB1mjOhp3RBedmyUPeM9DIyd9moKwqdaD
	cA7v5FcB/ccbT9FnXfDmBbtIAfyDG9Bm6aglnKiRlIiflS7bjgDfSiQY
X-Gm-Gg: ASbGncuCejRfFipHhtG6IvToN1W23Ob9QPi91nfd9Mt9/FQCVh09TtTbBXGOVqZXVho
	V1gxhHMnlBiV0O3TmZBoOCxPLeuo49ysZuECS3ASf8hHU+qOnq5hvYv/H9gLCm/s8FWCRGxMxBu
	mL7vVOdhF28hUMDM1rtLlcBVHj/y1bMrUsbUSQxIvE6nci988EM8BNF8KIy+lZrLFkweeM8Mocn
	P7QUyqH2krRTVWb1ROJ/0aUGIZGI3JMMM0uNkLt5ylrIo33LbD/BToWHrlzIn6hcz4JQXKYv1WZ
	vWJOjlqnu4LGnNs+XxX64kM+ufnCBOUQuyq41HIsY48r3bsmxUyti4/KzReEMKWUYb6It/W+CUH
	0MDFluq+Br5sALA==
X-Google-Smtp-Source: AGHT+IGiXkib/X2qWN6rUZEnIIfJFERpDSlpYKAb6eIzbVVy6G33lS6csaqK1XOzdr09FJ0851tgYA==
X-Received: by 2002:ac8:7955:0:b0:4a5:8820:a0ac with SMTP id d75a77b69052e-4a58820a109mr2039791cf.3.1748734777749;
        Sat, 31 May 2025 16:39:37 -0700 (PDT)
Received: from thinkpad (ip-74-215-254-164.dynamic.fuse.net. [74.215.254.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a4358ad334sm38644161cf.27.2025.05.31.16.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 16:39:37 -0700 (PDT)
Date: Sat, 31 May 2025 19:39:35 -0400
From: Adam Stylinski <kungfujesus06@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Subject: Re: Issues with vgacon with kernels >= 6.13
Message-ID: <aDuTMkxrQt7ItVbG@thinkpad>
References: <aDt4pp9NE85BuAec@thinkpad>
 <e7f421ea-ecc6-4b86-9657-c784f36468af@gmx.de>
 <aDuLW5Zwt1uGhrXH@thinkpad>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDuLW5Zwt1uGhrXH@thinkpad>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

On Sat, May 31, 2025 at 07:06:09PM -0400, Adam Stylinski wrote:
> On Sun, Jun 01, 2025 at 12:48:51AM +0200, Helge Deller wrote:
> > What is your .config?
> > 
> > You could try to:
> > - disable DRM:
> > # CONFIG_DRM is not set
> > 
> > - enable:
> > CONFIG_FB=y
> > CONFIG_VGA_CONSOLE=y
> > CONFIG_DUMMY_CONSOLE=y
> > CONFIG_DUMMY_CONSOLE_COLUMNS=80
> > CONFIG_DUMMY_CONSOLE_ROWS=25
> > CONFIG_FRAMEBUFFER_CONSOLE=y
> > CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y
> > 
> > Helge
> > 
> > On 5/31/25 23:46, Adam Stylinski wrote:
> > > I apologize in advance if this is the wrong tree to be barking up but I'm hitting a wall on this and I'm hoping someone on this ML can point me in the right direction.  Ever since kernel 6.13 (I've not yet bisected but that may be my next step) I've been unable to get my potato system booting up via the any of the simple framebuffer consoles.  The kernel simply hangs right after loading the disk IO schedulers (which, looking at my dmesg logs from 6.12 is _just_ before the vga framebuffer is supposed to take over).  The system is definitely in the realm of antique, with a Core 2 Quad Q9650 and a pre EFI boot stage. I've tried simplefb set as the default console, I've tried vesafb, and I've tried vga=normal, all of these seem to fail just before the GPU handoff.
> > > 
> > > The major change I do see around 6.13 was a change to support the DRM friendly panic message and I'm tempted to maybe think that's where the regression lives. I also realize I may be one of maybe 6 people affected by this by keeping this system limping along, but I do use it regularly to test SIMD related performance, as it's the last CPU family in Intel's line that actually has the unaligned load penalty.
> > > 
> > > This is the last kernel message I see prior to boot (hopefully LKML doesn't flag me for adding a URL, but I figured attaching an image would be worse):
> > > https://imgur.com/a/3QkVs2O
> > > 
> > > Does anyone know of any major changes that might have caused this and anything I should try? My previous configuration is actually to use uvesafb, of which has been failing due to v86d being missing from my distribution for some time now, but it would gracefully fallback. I have an nvidia GPU in this system so the nicer fb options aren't really a thing.  The builtin nvidia modeset is a thing and it does work but that doesn't happen until much later in the boot process. For all intents and purposes, I'm relying on VBE right until that module is loaded, but it hangs much much earlier than that.
> > > 
> > 
> 
> So, DRM I'm building as a module with 2 or 3 devices I'm not using (strictly it was required for the proprietary nvidia drivers). These modules aren't being loaded though.  Here's what those options are in my config (along with a few others):
> 
> CONFIG_FB=y
> CONFIG_FB_UVESA=y
> CONFIG_FB_VESA=y
> CONFIG_FB_CORE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB_DEVICE=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=y
> CONFIG_FB_SYS_COPYAREA=y
> CONFIG_FB_SYS_IMAGEBLIT=y
> CONFIG_FB_SYSMEM_FOPS=y
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_IOMEM_FOPS=y
> CONFIG_FB_IOMEM_HELPERS=y
> CONFIG_FB_SYSMEM_HELPERS=y
> CONFIG_FB_SYSMEM_HELPERS_DEFERRED=y
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> CONFIG_FRAMEBUFFER_CONSOLE=y
> # CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not se
> CONFIG_DRM=m
> # CONFIG_DRM_DEBUG_MM is not set
> CONFIG_DRM_KMS_HELPER=m
> # CONFIG_DRM_PANIC is not set
> CONFIG_DRM_CLIENT=y
> CONFIG_DRM_CLIENT_LIB=m
> CONFIG_DRM_CLIENT_SELECTION=m
> CONFIG_DRM_CLIENT_SETUP=y
> CONFIG_DRM_FBDEV_EMULATION=y
> CONFIG_DRM_FBDEV_OVERALLOC=100
> # CONFIG_DRM_CLIENT_LOG is not set
> CONFIG_DRM_CLIENT_DEFAULT_FBDEV=y
> CONFIG_DRM_CLIENT_DEFAULT="fbdev"
> # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
> CONFIG_DRM_TTM=m
> CONFIG_DRM_EXEC=m
> CONFIG_DRM_TTM_HELPER=m
> CONFIG_DRM_GEM_SHMEM_HELPER=m
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_AMDGPU is not set
> # CONFIG_DRM_NOUVEAU is not set
> # CONFIG_DRM_I915 is not set
> # CONFIG_DRM_XE is not set
> CONFIG_DRM_VGEM=m
> # CONFIG_DRM_VKMS is not set
> # CONFIG_DRM_GMA500 is not set
> # CONFIG_DRM_UDL is not set
> # CONFIG_DRM_AST is not set
> # CONFIG_DRM_MGAG200 is not set
> CONFIG_DRM_QXL=m
> 
> The "TTM" bit is what was needed for nvidia drivers if I remember correctly.

Oh and here are the boot messages on a kernel that can boot, right around those timestamps:

[    0.663455] io scheduler mq-deadline registered
[    0.663496] io scheduler kyber registered
[    0.663539] io scheduler bfq registered
[    0.663851] pcieport 0000:00:1c.0: enabling device (0106 -> 0107)
[    0.664474] uvesafb: failed to execute /sbin/v86d
[    0.664521] uvesafb: make sure that the v86d helper is installed and executable                                                                                                
[    0.664570] uvesafb: Getting VBE info block failed (eax=0x4f00, err=-2)                                                                                                        
[    0.664613] uvesafb: vbe_init() failed with -22
[    0.664654] uvesafb uvesafb.0: probe with driver uvesafb failed with error -22
[    0.664783] Monitor-Mwait will be used to enter C-1 state
[    0.664818] Monitor-Mwait will be used to enter C-2 state
[    0.664853] Monitor-Mwait will be used to enter C-3 state
[    0.665084] tsc: Marking TSC unstable due to TSC halts in idle
[    0.665222] clocksource: Switched to clocksource hpet
[    0.665573] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.665679] ACPI: button: Power Button [PWRB]
[    0.665775] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.665923] ACPI: button: Power Button [PWRF]
[    0.681553] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.681772] 00:07: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.682710] Non-volatile memory driver v1.3

I'll CC the list as well, as I think that's the proper etiquette.
