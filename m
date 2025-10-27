Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC1252912
	for <linux-fbdev@vger.kernel.org>; Mon, 27 Oct 2025 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588172; cv=none; b=jkfELigLEbgO1crGWbv9Qy9n7TyPT/L77LszKYSvinRPrlESRz6oJKm0TlTZC2t/OvCuy7shkDC3HAVXNeXS1fUlGpW2QxLvP4QTr4cX2GSQteFwaU5oZN/LQTbp74GBH9yBU/75LGMb2sYqvwooceTCdl6xJhy0hUl4AGdRvm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588172; c=relaxed/simple;
	bh=LvP36OFqg1n8BtKv/l9bCO2uLiZFM2W8O0LRWvjaIRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjk9qlPfspJ6yCy3xsiTEwVHVXIqxXcelU2gaIljcGPK2yrK01FzPeLcNJ2F5gvL1CHvdJbgUmHDyx9Iud3x7QXkJkCA7N3kJKrQ03JFP+HB4IqXoWlvbx9lkWit/CxOUPxBfAZm4K2HbvoNzfvtSmvya6iwe2az9mgfErY17Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqw5m9xV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqw5m9xV"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d402422c2so1174474166b.2
        for <linux-fbdev@vger.kernel.org>; Mon, 27 Oct 2025 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588169; x=1762192969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=keQgCiVBqugDEVy75un1KzT9J08z1JpEGApwh+kNxek=;
        b=lqw5m9xViL14XfWCA9IYLvK9rauu1SJrWXaIsv4X/vVIeR3be/1BxXALbqRitr50iA
         XzoBP34LGbZZAbLkId09tCkwv8llCoHG8cn6HYWskNnzInqCvdksjV2xQNZFjlcbU6VA
         EMoIcSyJbJYcrFOHuUTrVY1P3uyu43inTgIZ58lF0l8PUj3rSL0R/yb/vX173B75EiaM
         7WMQpwMLIab1anPpDNv2AHeZHomeRQnrWs5phQokU2+NoUFqcwzDJkW3/RXgDnsCxUVj
         GLg2rX8k8HR+BIu4Iu6kYcV4A64+FPPV0SHFpQSxWbwXPI86NI+5o2kQr3GuS5KcWI+L
         UbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588169; x=1762192969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=keQgCiVBqugDEVy75un1KzT9J08z1JpEGApwh+kNxek=;
        b=KWvNm+OuEZvgaQFD8VNOHzopIEnjQ5J/uC/hGX/V7emS8W4qzKLqroalzF65deO5Xx
         NiM8mrFh+7N2Lv76aaRGBpH6p/AdEPibgeoJUbP5wvVvN4YZAYw0iogNntxbFKTEh3Yf
         v/GrLqB4QPO6Cz1jyotMh4k3ur8LRWN7Ey/usKBkzRBOtku1XsDnnXEc5POY21BlhVkx
         pbg8daWaGnJHMR8vwhTxOCgTf+buSX3IP1JaoboAgcGOvrwHKtzS043XrOTtKiu3MZ3p
         zdFOG+CTloHsF9/O4ov7aoevdPhHawOA+/rbHe9hjJoYpx4grujA2XF4b03d+KaX0/69
         3gWw==
X-Gm-Message-State: AOJu0Yyp3hk8SyBuwOWL2omjL5R7TEms101j2kE4JA2EJ/euem5U7jmt
	45FIo0xNa6YQ+/UagDMkdJiOm8lpsG861sYQ6PUv5AM86V0kfiDAPzJcqqi+VzFnqp4fIjqRSCU
	VSBCEpVOkCn3lfKQ8Tzy5XAw8K+WgVa4=
X-Gm-Gg: ASbGncsHEBAwEgQpDgbh4a0CZnnT9ox1kWtu7lwGhbFYMRE/Qd2a5VS1TXa9eogTtGa
	V44c8arqqMuiwlME6qkjZZquJQSCdAbnry/Uc3Wsp9RXT1qN/Ui5puC/1EXTXMR7SNxnEfgIIWt
	O63ZTN0+nE2XoFy7OvFJxW7TYl6n+9MrojhpO9f4IOmunmq1qHebN81pgS5DrPPiCTEdA/gFdPV
	HYtxMvZqNH5YhvKZYYdg5nV+Ljkj9shtCf2S+nKsBU+y5FOimJ8GUA6nj8TJdW0KR15ZUEmZ08L
	ZcochccDRwU9Uz3IReQmaRDK
X-Google-Smtp-Source: AGHT+IHP/V1F9P3TW5ZFh/h+hXxyEHvlqMWOQvAOVjJ5loLIb8qqHYGPMlplTaY2sFeQxNozQ0fFjQ7ofp+S0wxS29I=
X-Received: by 2002:a17:907:785:b0:b6d:6a3e:b960 with SMTP id
 a640c23a62f3a-b6dba5c0ce8mr88785366b.59.1761588168846; Mon, 27 Oct 2025
 11:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016171845.1397153-1-rampxxxx@gmail.com>
In-Reply-To: <20251016171845.1397153-1-rampxxxx@gmail.com>
From: Javier Garcia <rampxxxx@gmail.com>
Date: Mon, 27 Oct 2025 19:02:37 +0100
X-Gm-Features: AWmQ_bnRxFLdM34KXqFkDra9NbBgRdtN8M_nP9qHeXiirDeaOiJxudxosg27OyM
Message-ID: <CABPJ0vgtpjh2q605TifawiS36qAS+OO_dAnYVGsqd03GSXZp+g@mail.gmail.com>
Subject: Re: [PATCH] fbdev: vga16fb: Request memory region.
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Helge Deller, any comment on this patch?

---
Javier Garcia


On Thu, 16 Oct 2025 at 19:18, Javier Garcia <rampxxxx@gmail.com> wrote:
>
> This patch reserve and release VGA memory region with `*_mem_region`
> fn's.
>
> This align with Documentation/drm/todo.rst
> "Request memory regions in all fbdev drivers"
>
> I've tested with kernel and qemu both 32bits.
>
> Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
> ---
>
> When I've run the code always return -EBUSY which makes sense as
> mem is already requested,`/proc/iomem` shows `000a0000-000bffff : Video RAM area`.
>
> I've seen that `cirrusfb` has this kind of code wrapped up with `#if 0`, and I
> wonder if it makes sense to also wrap up with `#if 0`, at least , in
> that way the code gets commented about expected behavior.
>
>
>  drivers/video/fbdev/vga16fb.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
> index eedab14c7d51..f506bf144a97 100644
> --- a/drivers/video/fbdev/vga16fb.c
> +++ b/drivers/video/fbdev/vga16fb.c
> @@ -1319,6 +1319,11 @@ static int vga16fb_probe(struct platform_device *dev)
>         if (ret)
>                 return ret;
>
> +       if (!request_mem_region(vga16fb_fix.smem_start, vga16fb_fix.smem_len,
> +                               "vga16b")) {
> +               dev_err(&dev->dev,"vga16b: cannot reserve video memory at 0x%lx\n",
> +                      vga16fb_fix.smem_start);
> +       }
>         printk(KERN_DEBUG "vga16fb: initializing\n");
>         info = framebuffer_alloc(sizeof(struct vga16fb_par), &dev->dev);
>
> @@ -1398,6 +1403,8 @@ static int vga16fb_probe(struct platform_device *dev)
>   err_ioremap:
>         framebuffer_release(info);
>   err_fb_alloc:
> +       release_mem_region(vga16fb_fix.smem_start,
> +                   vga16fb_fix.smem_len);
>         return ret;
>  }
>
> --
> 2.50.1
>
