Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA5139903A
	for <linux-fbdev@vger.kernel.org>; Mon,  8 Jun 2026 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905844; cv=none; b=hxJaAimySVF7r9AQj+KC/Rj3iG7n7sliyhaaaP118Icq/QsPLt9HmC0YlSmwvaUT87h3tzP6kGBpSTKGzu5/D3t4Vkp2c8tYH77FLH56NAb+6FU1HL93CM2NcCcwcwxdUXahLrBsp99MfDPuXIIUFceT18lD2MFuWm19cPVAlZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905844; c=relaxed/simple;
	bh=3XoWMip1Ut8IJJUAfIgqC/uS1E8fEp74mZlm58wlZ6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQ0y/3ndOX8RpF1/ewWNmpT6y15vwDcvh3ewhMTae4Q2cOumyha+uCKv9norvsfOgZ86tUuuAmBKJ+6A3OuBnZyt41sXNWmKjHWL+TX/YBU0R5ySPq0hQFbmoet+FQihC3vwaoIVQjBz8ixOzwlxcxok4CDo7PMXhpSPfMTRlX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6cfc8f8e127so1169945137.1
        for <linux-fbdev@vger.kernel.org>; Mon, 08 Jun 2026 01:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780905842; x=1781510642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTxptyBz4iPUdNMe4t6/ELsmEpY5WWxIF5IUIpiHaEU=;
        b=gGhTpETYPLNRrJu85xAK4COoXf3/hWbkez1VV/YunSI2A+qyPIrEiq+mD9DZgdiIwe
         hfPW3KiH+LSr48SeEMxLAZWMVd6C8+U4kMC2nD6EwLN/BhNOdDixefx+8TFAZNFBuIsS
         yU+7DuEdgGnrzAl16DZbR6Q+0aDkCND/TZq/6l1Sqw2isTN3pMo1JOtb+GZtzb18qg3X
         OoGVPdkcYbiDrqC4BWPUJMl/uvLLWopwa9LLDbL2qC9AN8HZiUvS583olFhRWtSraZEK
         KWbUC8mq32ATcq1qVlc1C/X8ZgBs2dddEXTtUxipivc/EhGWgiQf+wU2cxxtS3xBPB/9
         UFyA==
X-Gm-Message-State: AOJu0Ywm+eLW1mpwfU6nPUE67tGaSV5nxclkNI15y/WPNfj25qjitwaA
	QiNMJkHd/yj6YidwQe7n5ApzrQsISR0mquy4QFQce1QiBVLMt8o3Gqhbi+hbRUNo
X-Gm-Gg: Acq92OFxr5ym8g5iJIPMxnP1z2WKquHD2pH9ODrRA13QcpSLgSWZc5fz+pveEv5enqG
	B+y8/RJQ30vxH6o2oRhGlO+F9HdLq4w58vTyT5lB0YIwLqdL66O5zNy8HwxM8rEOSO5W3+zQgBI
	uJol95mW/kTu/PEZB1aEE4Q/2QOUt83fCcjw9gboZigybhH7yWeE3SG4P17Oek8aVd3wXDPC/iL
	RieZaFnV4J8WrFy5N55lykgpFhCQu6CZsfbpIeioC7cnWJd6d3LHri5bevKnU639DWS4opX7d6n
	hrHfMWOOLB1kumahrqeofpy9FxlvEghGT2Dp5hG6MvXNUXCN9lJdFm3x+OfkCZOL7Bk6n7qUmA1
	vyYHig0/1QRdsUuo2dDZg+p5A4r4ufdWW4NNajlKjJ/c34/gxEEtFyr2o2H05Sy3MHl7AOS51QA
	7FkaaFbHJSdZRsBiWj+oRLgutquPyTSWWsB7fD2yaJA5frxg5jfNr5DJ5h2ukE4cag00PiJcpli
	ig0QibD2g==
X-Received: by 2002:a05:6102:e0d:b0:6c8:aed:ca95 with SMTP id ada2fe7eead31-6fef3bf72dcmr6489925137.13.1780905842557;
        Mon, 08 Jun 2026 01:04:02 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9641414e193sm12722105241.11.2026.06.08.01.04.02
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 01:04:02 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6efdb57db0cso1106761137.2
        for <linux-fbdev@vger.kernel.org>; Mon, 08 Jun 2026 01:04:02 -0700 (PDT)
X-Received: by 2002:a05:6102:808f:b0:636:46ee:2f0b with SMTP id
 ada2fe7eead31-6fef26cd8b4mr6389580137.12.1780905842198; Mon, 08 Jun 2026
 01:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607015840.11006-1-enelsonmoore@gmail.com>
In-Reply-To: <20260607015840.11006-1-enelsonmoore@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Jun 2026 10:03:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXiToNLeQqW54+tOm6-eh9Xefxe3QaMC2Zg7r-3pBOx8A@mail.gmail.com>
X-Gm-Features: AVVi8Cc7gD2W9mukDl-q9xorgLxuj6J1O9hHaHk0o5nB-ABN2zEO3tmkQoGyZ5M
Message-ID: <CAMuHMdXiToNLeQqW54+tOm6-eh9Xefxe3QaMC2Zg7r-3pBOx8A@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: remove skeletonfb example driver with no
 remaining purpose
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"

Hi Ethan,

On Sun, 7 Jun 2026 at 03:58, Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:
> The skeletonfb driver is intended to serve as an example for writing
> new framebuffer drivers. However, new framebuffer drivers are no longer
> accepted into the kernel because DRM has obsoleted fbdev, so it no
> longer has a purpose. In spite of this, it continues to be updated to
> reflect fbdev API changes, wasting maintainers' time. Remove it.
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Thanks for your patch!

Makes sense, as we still have vfb.c, which can actually be built.
Perhaps some of the comments and/or kerneldoc should be moved
elsewhere, so it is preserved?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
