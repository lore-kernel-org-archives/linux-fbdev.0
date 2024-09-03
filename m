Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55F1EC01E
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Sep 2024 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725404039; cv=none; b=DJ2BktanqKUk1EdUid754gy1xOUBlsLR9iOlTfaPLim/SZgznFZymvqQuba4pB/+6z8DQZQGYLBr4AgedhF09iePaOST9LQ5ZDfmFCCs8B71lDO361jsbCETWF1cBFc9keQmsk47DY8h67uwctqFrH/JmWi2z3z91HmbUxCmMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725404039; c=relaxed/simple;
	bh=jtBRMu1TAEL0du7YqwjNetbvsQfSpNr1nTzabVDnUBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAkYaW9T43DDVbA3V/sORrweT6oRlyhArpFfHK4ZNAEGg6xWq3MKwjtZSKjaR8Y4cTvzx26p59/EccYe7mmGpLNz1FgDMQYpiqzZ07FEuC0riuhHDpWD+2ntjRNjQF8fJzRnEJ+vaY+Xfq/0bHMgljN90pkBBIBA5PE6rIwq3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HACnV2ar; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HACnV2ar"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-534366c1aa2so6085282e87.1
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Sep 2024 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725404035; x=1726008835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TibCX6FTpMc9lkiFRh0zYuPWiiEk7PlvKZMAQzqxZ48=;
        b=HACnV2arT1E8KIB91vedUBlp4v7kAQKa2a3ydNZC1/YjmAc64W6cAmERYJsSBmwhqt
         ldrL02bjITRK6cWlBeBO6JFI45P40zkSmt9duhXRe72A99v/SsmWLzbJzVCQkq577ARO
         xYq2hgNB2L4vTZCtwI55bLP8t4/PuK0nBRG2Iq83bX4cVJ7qLvBsuo9hZqHz5sKgOGWm
         oEb22tDf8Sva8ekFozRxeeObwcc2NFZqN97aEegbZMuUSHju/CovJzXomI0qtvDi8Ixx
         rqrYO6w8wpht+KIotnX8PEiyVa+V1skl1kswo0/gvLxz+foFrmKlTgEjs1QGg4Hs9q8v
         v5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725404035; x=1726008835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TibCX6FTpMc9lkiFRh0zYuPWiiEk7PlvKZMAQzqxZ48=;
        b=QxkcbxKOjs3LzFz6vFf4HxoX/ejSLxauRx+cFn0bbxLKiwC5TSzhkwY66WnhKmoYuj
         Nb88yy1icW5NAVsdGEmqsC0RucLQmf0F6xV4uqOQumm8+FqHB/KF+SHOstnLQ41vpPP0
         AHJS4gQkjSEdjtCzIr1ltDfow0AJLw05MmJRfmh79Ri+b79cjeAymUHlBrrbodnjKF+x
         MOIYefx3Ffcqusmr+v/mrbQeOHU9icUBZytKfIKtErClAeKONWOkL2yBoRP8TxT4+j7q
         KNMDoI+t0ASxzszmbaENWpc/TCI3GCE6VVBlktwpGXO6FaEE9YUahc+0+24Q/z4Dv1dH
         Et8g==
X-Forwarded-Encrypted: i=1; AJvYcCXkuszbJJFQ/7aaSQd4J+0DeHR/aPPRbPcSrtriARO/VoROd+WmARVq6srI1dZqZ45xPYhWMuAhILfecw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyP0CHoNDlilczP8WZ3CQsD+8BHRH43kVIesfN2FqTOHxRTmxOl
	Lh+sDOfMEHSR7+GnyVJ2yWsXUSxRcanPN/JaeLtEJXN99ZUv2tBJ8wzi8SnP0gyDtvtlvJYu5+3
	HwILOYRmGtnMfxK9HX67AOyuyAc7fXZIaZPRecg==
X-Google-Smtp-Source: AGHT+IFRNTe/g6GLik1nmRR1r5xjF73+mOYf40nztdLD4gl+EJ+yBMPvlttQPkX/TaWzvcWQjbOeS5Cq3693XklkXE4=
X-Received: by 2002:a05:6512:3f01:b0:52e:a63d:e5c1 with SMTP id
 2adb3069b0e04-53546b2bf41mr10655390e87.30.1725404034288; Tue, 03 Sep 2024
 15:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419083331.7761-1-tzimmermann@suse.de> <20240419083331.7761-22-tzimmermann@suse.de>
In-Reply-To: <20240419083331.7761-22-tzimmermann@suse.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Sep 2024 00:53:42 +0200
Message-ID: <CACRpkdb+hb9AGavbWpY-=uQQ0apY9en_tWJioPKf_fAbXMP4Hg@mail.gmail.com>
Subject: Re: [PATCH v3 21/43] drm/fbdev-dma: Implement damage handling and
 deferred I/O
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, deller@gmx.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 10:35=E2=80=AFAM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:

> Add support for damage handling and deferred I/O to fbdev-dma. This
> enables fbdev-dma to support all DMA-memory-based DRM drivers, even
> such with a dirty callback in their framebuffers.
>
> The patch adds the code for deferred I/O and also sets a dedicated
> helper for struct fb_ops.fb_mmap that support coherent mappings.
>
> v3:
> - init fb_ops with FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS() (Javier)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

For some reason this makes the Versatile Express crash in QEMU
(I can retest on real hardware if necessary):

8<--- cut here ---
Unable to handle kernel paging request at virtual address 18095000 when wri=
te
[18095000] *pgd=3D00000000
Internal error: Oops: 805 [#1] SMP ARM
CPU: 0 PID: 75 Comm: S08_ledflash Not tainted 6.9.0-rc6+ #44
Hardware name: ARM-Versatile Express
PC is at mmioset+0x34/0xac
LR is at 0x0
pc : [<809c2a54>]    lr : [<00000000>]    psr: 20000013
sp : f8dddc38  ip : 18095000  fp : 00000000
r10: 81109a18  r9 : 81238b04  r8 : 00000000
r7 : 00440dc0  r6 : ed4f32a0  r5 : ed4f32a0  r4 : 00000001
r3 : 00000000  r2 : 00000fc0  r1 : 00000000  r0 : 18095000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 81d6406a  DAC: 00000051
Register r0 information: non-paged memory
Register r1 information: NULL pointer
Register r2 information: non-paged memory
Register r3 information: NULL pointer
Register r4 information: non-paged memory
Register r5 information: non-slab/vmalloc memory
Register r6 information: non-slab/vmalloc memory
Register r7 information: non-paged memory
Register r8 information: NULL pointer
Register r9 information: non-slab/vmalloc memory
Register r10 information: non-slab/vmalloc memory
Register r11 information: NULL pointer
Register r12 information: non-paged memory
Process S08_ledflash (pid: 75, stack limit =3D 0x(ptrval))
Stack: (0xf8dddc38 to 0xf8dde000)
dc20:                                                       00000801 802af8=
88
dc40: 80a0fb80 00440dc0 00000801 811fad80 00000000 f8dddd28 ed4f32a0 811fa6=
80
dc60: 00000000 802b0c30 ee1d2140 ee1d215c 95ff4385 00000001 00000001 000000=
01
dc80: 00000000 00000000 ffffffff 8196a70b 000000b0 00000064 0000006c 000000=
00
dca0: 00000001 00000002 00000001 811fa798 00000801 811fa940 80a0fb80 00000c=
c0
dcc0: 00000001 00000001 00000000 f8dddd28 811fa93c 811fa680 00000002 802b0c=
30
dce0: ee1d2140 00440dc0 00000000 00000000 00000001 00000000 811fad80 00440d=
c0
dd00: 00000001 00000000 00000000 83201100 00440dc0 00000000 00000000 802afa=
18
dd20: 00000bdc 00000bd8 811fad80 00000000 811fad80 00000000 00000000 000000=
00
dd40: adf00ec5 816d5fa8 816d5fa8 821c3c00 00000000 7ebc2000 7ebe3000 000000=
00
dd60: f8ddde44 8028cfa0 816d5fa8 8288df50 8169cf00 821c3c00 7ebc2000 7ebe30=
00
dd80: f8ddde44 8028e1e8 00000001 80bbe932 f8ddde44 f8dddde8 f8ddde44 8288df=
50
dda0: 83201100 809cf474 f8ddde44 8169cf00 00000020 8169cf94 821c3c94 7ebe30=
00
ddc0: 7ebe2fff fffffff4 00000000 816d5fa8 821c3c00 8169cf00 81d65fa8 809cdb=
b0
dde0: 8288df50 81ffa910 7ebe3000 82890b00 00000000 00000000 00000000 000000=
00
de00: 00000000 00000000 adf00ec5 00000000 00000000 8169cf00 8288df50 832011=
00
de20: 821c3c00 81ffa910 f8ddde44 8011f6e4 00000000 00000000 821c3c7c 8169cf=
7c
de40: 83200880 821c3c40 7ebc2000 7ebe2fff 82890b0c 76ea4000 ffffffff 000000=
00
de60: 00000000 0f000a01 f8ddde68 f8ddde68 adf00ec5 00000000 00000000 000000=
00
de80: 00000000 01200000 83201100 00000000 00000000 8011e2ac 00000000 83200d=
7c
dea0: 83201020 83200e70 83200e80 00000000 f8dddf30 83200880 00000000 000000=
00
dec0: 00000000 00000000 00000000 82182f38 adf00ec5 00000000 01200000 f8dddf=
30
dee0: 00000000 00000000 00000000 00000078 000cb21c 8011fe24 00000020 000000=
00
df00: 828a5d80 80a10140 adf00ec5 01200011 00000000 00000000 00000000 f8dddf=
30
df20: 00000000 00000078 000cb21c 801203d4 01200000 00000000 00000000 76f464=
68
df40: 00000000 00000000 00000011 00000000 00000000 00000000 00000000 000000=
00
df60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00
df80: 00000003 adf00ec5 76f46468 00000000 76f468c0 00000078 80100290 832011=
00
dfa0: 000cb21c 80100060 76f46468 00000000 01200011 00000000 00000000 000000=
00
dfc0: 76f46468 00000000 76f468c0 00000078 00000000 76e81000 76f46400 000cb2=
1c
dfe0: 00000078 7ebe2938 76e0854d 76dae7e6 20000030 01200011 00000000 000000=
00
Call trace:
 mmioset from prep_new_page+0x160/0x194
 prep_new_page from get_page_from_freelist+0x10f4/0x110c
 get_page_from_freelist from __alloc_pages+0x15c/0x280
 __alloc_pages from __pte_alloc+0x28/0x1bc
 __pte_alloc from copy_page_range+0xc10/0xd28
 copy_page_range from copy_mm+0x5cc/0x850
 copy_mm from copy_process+0x508/0xd8c
 copy_process from kernel_clone+0x94/0x338
 kernel_clone from sys_clone+0x94/0xb0
 sys_clone from ret_fast_syscall+0x0/0x1c
Exception stack(0xf8dddfa8 to 0xf8dddff0)
dfa0:                   76f46468 00000000 01200011 00000000 00000000 000000=
00
dfc0: 76f46468 00000000 76f468c0 00000078 00000000 76e81000 76f46400 000cb2=
1c
dfe0: 00000078 7ebe2938 76e0854d 76dae7e6
Code: e92d4100 e1a08001 e1a0e003 e2522040 (a8ac410a)
---[ end trace 0000000000000000 ]---

I bisected down to this commit and reverting the commit solves the issue.

What is special about the Versatile Express graphics is that it uses a spec=
ial
dedicated video RAM, looks like this in the device tree


        reserved-memory {
                #address-cells =3D <1>;
                #size-cells =3D <1>;
                ranges;

                /* Chipselect 3 is physically at 0x4c000000 */
                vram: vram@4c000000 {
                        /* 8 MB of designated video RAM */
                        compatible =3D "shared-dma-pool";
                        reg =3D <0x4c000000 0x00800000>;
                        no-map;
                };
        };
(...)
         clcd@1f000 {
                      compatible =3D "arm,pl111", "arm,primecell";
(...)
                      memory-region =3D <&vram>;

This gets picked up in the driver
drivers/gpu/drm/pl111/pl111_drv.c
like this:

        ret =3D of_reserved_mem_device_init(dev);
        if (!ret) {
                dev_info(dev, "using device-specific reserved memory\n");
                priv->use_device_memory =3D true;
        }

Yours,
Linus Walleij
