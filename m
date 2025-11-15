Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0653915ADB4
	for <linux-fbdev@vger.kernel.org>; Sat, 15 Nov 2025 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763191887; cv=none; b=qX218XcEYPxHRbMgayDMBKBMiwDkZK8wzfWm42kRlegMBJ+QTpv9sJhZJOFLIASHkHlT7aTi1/WyU9QA+6Gu5c3AzXT8xFouXsVO40hsqerqXHnr8PAhbVZO+/ZKb63jsdBTvve/dg2kBTwaV89AakbUBNhfTfruGwBNxQ7fqeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763191887; c=relaxed/simple;
	bh=oceXXfmf1W1YpR/9JX9LqQEdHPQin3xr9lzATtBM+Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MInvJ/5uFEoN4299Rw5yQv7AKr/N1kRNBMd1pdUx8sA30YyIa8ISQwX44+k+EAMbKq1gNQIbcRL8CI5rnLN7ct3MBUg4f6ULMt1lZIp0Rj6jvXaH4HGM/uY0MWUNxDfgoujK+783eAX5s463/kqheGUzi89Wg+8b7AZVs7H4z6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k14zeULW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k14zeULW"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7379641791so93435166b.2
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Nov 2025 23:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763191884; x=1763796684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1GthNzvU7oIYpZFVMhRNcIwup0JI2wPPRFd6se98Fvw=;
        b=k14zeULWLLNzc0I59N+pf6Rrp4WJQvPh5n4gzDVQox4FnsOYAz4/zX76SBVRfVSE0W
         M+3LfKUdpTdJMY6vDi8XWIJXmGdehf1mg8e+5T7zWOb9ZHLpI0aq7VX4WLVFuuPRbDTQ
         hacKllf5XPP+zXwEyESt7sD6me5afusO2vdfs0QF5/PHPxc+8ovQdVqONEOGB8y0vEil
         qvrfgtikvQmO4/araVqBsjPUNho8ZAUeyBLy6nfaOEQC8TjTcY1v+upfwY8fG0ZjPQRn
         EKC8TIRzp7wUeLgU2/uGdG6nfxwSwW0phjF7HhWPsqPsy/ou8poRiMXlB5v+VsQtfzFx
         R20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763191884; x=1763796684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GthNzvU7oIYpZFVMhRNcIwup0JI2wPPRFd6se98Fvw=;
        b=spMS7n89979JmsUFSIBpwkcNK8xDvV23jJ7yeW00GYwpO3EszofeDOk4MGUaQPXUCx
         ONK9mLT1tDoReOthDGn5lzDNbJgqpvfWwKeMcjBzJSg2KZG8euhOosKsSy7WX0Rq+k2R
         5GcChZCVDiaauv5ou/NLpwY3km1SC4BwP7q/MsBD4tF1+oAYWuID5GY3om7UMLJj7pwr
         JxqXFZ2v5grkpYLgvt4NqaptdG2OXqSjQ7uF0S9Ky/SaAAmuc1+ZZLLif4qnx3Eit7pb
         57sYWQCj+fl5HrNOLg5sf63ShwAVNbIdQfHE4BHAr6aLW7h2Cy8Hi/5548tVaBaBaViy
         2V6Q==
X-Gm-Message-State: AOJu0Ywq3x4P7AJC3x7oB+pcPnIT9YWl9MNPbAYVpfTmHVqwdbPn4mG2
	qL4TbdOAQBUu3YDYck3eZmKLX8kTcHgBBiDW0L298thMfP78DFHZq9lnMhJZtT37+Eis8brNWkh
	jQSCWAQFXAfUlKpUTe/jxwF/7kxH2Ehe/3bu7
X-Gm-Gg: ASbGncvPX0SPX2qsH7TqVXWEs+BoKdaARnvN2elkHjHTocBPLJCYb3iZ4Fcq1pBCklD
	hL6xWM7qNM3kalhoUkY4dQWUj/KmeZg5kW5Lo8jkb3mqEmKZghHbwYYE7DSYS3wGP9w5s7OpSYU
	dZvhSvCdUG4xnPltHnjHA4Aa8qS3kv7mzELOuMM+ruKs0WDzIRWYhIIEBsIq4M9MHdci2gLTLXn
	nktgfmLvAZCJbrmTCvdWdrZWgHnMXcdUEeSGzQyZtcUbmBTkQ1g46v4epc615xeaNS8Usa3uHzD
	/TrRKGGdbGZv980K7D7rDHt2
X-Google-Smtp-Source: AGHT+IHeQM7ska+yl8ZfByGr4aIQ8nWV7A0qqzSGCvXBmMDkvmobczaDf2bIGmtPK1vTSc5h13fGDlsqSNTRmjJYcJ8=
X-Received: by 2002:a17:906:c18:b0:b73:6d57:3e06 with SMTP id
 a640c23a62f3a-b736d573f0fmr368135966b.7.1763191884278; Fri, 14 Nov 2025
 23:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f9998d60-e532-48ae-8e03-d867cc0ec847@gmx.de> <20251108093348.2842180-1-rampxxxx@gmail.com>
In-Reply-To: <20251108093348.2842180-1-rampxxxx@gmail.com>
From: Javier Garcia <rampxxxx@gmail.com>
Date: Sat, 15 Nov 2025 08:31:13 +0100
X-Gm-Features: AWmQ_bn5W6cFQWAXvma80RKDC3o72Zt4SI3uXLPsjYIbAeCDIpi_bsg6NlHL0hg
Message-ID: <CABPJ0vgAK5-vhuqCDa0LNkjUeD8qE8GD0Yu5D3wc59ixw6OHiQ@mail.gmail.com>
Subject: Re: [PATCH v3] fbdev: vga16fb: Request memory region.
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Helge Deller, added this extra space clean as a I received a bot msg.


---
Javier Garcia

On Sat, 8 Nov 2025 at 10:33, Javier Garcia <rampxxxx@gmail.com> wrote:
>
> This patch reserve and release VGA memory region.
>
> This align with Documentation/drm/todo.rst
> "Request memory regions in all fbdev drivers"
>
> I've tested with 32bits kernel and qemu.
>
> Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
> ---
> v1 -> v3:
>       * Add space after comma.
>       * v2 https://lore.kernel.org/lkml/20251028191615.2765711-1-rampxxxx@gmail.com/
> v1 -> v2:
>       * Add release in vga16fb_remove , thanks Helge Deller.
>       * v1 https://lore.kernel.org/lkml/20251016171845.1397153-1-rampxxxx@gmail.com/
>  drivers/video/fbdev/vga16fb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
> index eedab14c7d51..3b4c50d98ba6 100644
> --- a/drivers/video/fbdev/vga16fb.c
> +++ b/drivers/video/fbdev/vga16fb.c
> @@ -1319,6 +1319,11 @@ static int vga16fb_probe(struct platform_device *dev)
>         if (ret)
>                 return ret;
>
> +       if (!request_mem_region(vga16fb_fix.smem_start, vga16fb_fix.smem_len,
> +                               "vga16b")) {
> +               dev_err(&dev->dev, "vga16b: cannot reserve video memory at 0x%lx\n",
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
> @@ -1407,6 +1414,8 @@ static void vga16fb_remove(struct platform_device *dev)
>
>         if (info)
>                 unregister_framebuffer(info);
> +       release_mem_region(vga16fb_fix.smem_start,
> +                   vga16fb_fix.smem_len);
>  }
>
>  static const struct platform_device_id vga16fb_driver_id_table[] = {
> --
> 2.50.1
>
