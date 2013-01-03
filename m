From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 03 Jan 2013 15:36:08 +0000
Subject: Re: 3.8-rc2: EFI framebuffer lock inversion...
Message-Id: <CA+icZUUepiyko99f8PSSZm=kPKSe3cqChXeec55BszTVCmDAmw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+icZUVEBEerN=YRSS8Rx-2Xvx4byFuBDbVcE45qq4QZ67+Q-A@mail.gmail.com>
In-Reply-To: <CA+icZUVEBEerN=YRSS8Rx-2Xvx4byFuBDbVcE45qq4QZ67+Q-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel J Blueman <daniel@quora.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>

On Thu, Jan 3, 2013 at 3:11 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> Hi Daniel,
>
> just wanted to test the fb-fix [2] from Alan and followed the thread in [1].
> Me is also working with i915 KMS.
>
> I looked at nouveau KMS driver and adapted the part for i915:
>
> drivers/gpu/drm/nouveau/nouveau_drm.c-200-      /* remove conflicting
> drivers (vesafb, efifb etc) */
> drivers/gpu/drm/nouveau/nouveau_drm.c:201:      aper = alloc_apertures(3);
> drivers/gpu/drm/nouveau/nouveau_drm.c-202-      if (!aper)
> drivers/gpu/drm/nouveau/nouveau_drm.c-203-              return -ENOMEM;
>
> Untested by me, feel free to test.
>
> Maybe some of the i915 and/or fb driver experts can comment on the problem.
>

That is the i915 part [---> i915_kick_out_firmware_fb()] where I looked at [1].

- Sedat -

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/gpu/drm/i915/i915_dma.c;hb=refs/tags/v3.8-rc2#l1393

> Regards,
> - Sedat -
>
> [1] http://marc.info/?t5721787600001&r=1&w=2
> [2] https://patchwork.kernel.org/patch/1757061/
