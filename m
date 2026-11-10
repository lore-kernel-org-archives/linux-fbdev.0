Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304866;
	b=vuNTfF33cgI0wOb/jiiL8rZ6uTs6DEjIJaS6Su9VsKhwpAMzmaQmQLDRcRbCWuUJy+Nd
	 aHQPKIrFrTFE5kZGJazTEHAYhvAzg7UGcdB8HSva+ZtzhCmgBVKT3EIzxu5vy9/0AJRv3
	 BhXuM4qYzs0MCDE3mfcunf2v4dfEjWYFSbCyqLxEq1Tw/MBH/Rf4ecoKSJHn3UohqoG/S
	 zk1lzcaS3SsOtJJmmMpm6PlU5iVHsFi/nk0lIGutKp0EWiy+mLiFedVBCN7N0IsnxL8aQ
	 bMaez4JLJ6NeMJmTs03HlknzS5Do3e8k7E6Qamg0y63NbmrAH1V7kdeOz9qJQnfkpVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304866;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=InjrUa8PtgxebaoPU5gAdUxBP+Q7iA9KZue8Z0bePJ0=;
	b=m9PqtSsKamtZGl3arGckMCPR5W4VPFK33LRQyYVPzqK1MD7kAsB9LqYc1rG2I6OU9zA5
	 wi2sd42C7E7UQUaSg9L13wUvUTi7mgHeauch36ec6SH2+vZbvosnVRiXLaqbmbYMEv62/
	 N0Dvg8IoQrDdrKmhXnlb4EH+j78sSGzko5VhLIwtap/PL06umFqYeFfxh8zg5PjrheyR3
	 08wosko8NlWYWtp1cC70XpgTgS7RwOROElU1PKcCPy0OVJLdg7/Idq+ADDH8jEhyqW89i
	 4kZ1CEJMjiVoMcaQnX+00JP8SxiI5m2Xlszp4C1Riyi35j33hY9marAEJkr45amE9cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+hfUJO7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2D560A261B
	for <linux-fbdev@vger.kernel.org>; Tue, 10 Nov 2026 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+hfUJO7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2695B1F008A7
	for <linux-fbdev@vger.kernel.org>; Tue, 10 Nov 2026 10:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794304866;
	bh=InjrUa8PtgxebaoPU5gAdUxBP+Q7iA9KZue8Z0bePJ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=K+hfUJO7sVbzoCoh+i1LFy+ufPpUI+d5dAtrssBx/TGKR0PeddorTjht1Ef9+5Mqz
	 EBuXqLBI4C0xb/2o0t4XecOnWq43i/1z9OInIaDmW3Sot4Z7VWjR1KCPSWDBYEjnS+
	 R6B5EjC88Ae9Nvq9gBtlEtQCQuu92xn1eJzaOCymhRBNVOcFDFrQTWkVapHl2WoEci
	 SCxsi6tBkIyI/L7zbE/D2crP9b9TAZ7TKrjL79Yz/cT0F4yFLSHpFpkkKX3mn07f/0
	 s+Y07IB4qT9OjKrj/dOjXFacjsuBoF7LG7Zkux4d7uzzt1hHyIVMs5cE9SABePpBbO
	 yReDGAkO9gfnQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b6e8b6d424so2646309a12.0
        for <linux-fbdev@vger.kernel.org>; Tue, 10 Nov 2026 02:01:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGPbP/7pMaPzJLoKPqnXPr7D+K491IG2p9JpDYjC3H2DamR+enidmuu90y3HF/zzXPkJ69x1db/kwx0WQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/fwEbR+zBB47G46k/ldpFkoF/Qo/Ntyvf4hZKu0ajXadfZ15nB
	dFctfoeCmDV/V4vlUIau44MUsXRQoL85/RmeVgdi9E7N2sjifFEGEY72iGV/x+kgtUHNZ4Hx0Tu
	h6qc6+3HzM0ITtbd6LbU/6BkTAXzsS8E=
X-Received: by 2002:a17:907:ea89:b0:c4d:31cd:9dec with SMTP id
 a640c23a62f3a-c50495a3646mr156885666b.30.1794304864528; Tue, 10 Nov 2026
 02:01:04 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029033440.973077-1-wuqianhai@loongson.cn> <20261110090203.2631481-1-wuqianhai@loongson.cn>
In-Reply-To: <20261110090203.2631481-1-wuqianhai@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 10 Nov 2026 18:00:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6=7SbhLpzWOYFxi9MaM5f2BHfJXjWjQW-uBeLCKMHPVw@mail.gmail.com>
X-Gm-Features: AclHuK-9P_C8nOOOdEbmYQVc8OO7W71bMN2RKSel305MdnvrCGkGtc7VDw_SrUo
Message-ID: <CAAhV-H6=7SbhLpzWOYFxi9MaM5f2BHfJXjWjQW-uBeLCKMHPVw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] LoongArch: Identify the firmware/boot display device
To: wuqianhai@loongson.cn
Cc: kernel@xen0n.name, tzimmermann@suse.de, deller@gmx.de, bhelgaas@google.com, 
	ardb@kernel.org, ilias.apalodimas@linaro.org, javierm@redhat.com, 
	loongarch@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qianhai,

On Tue, Nov 10, 2026 at 5:04=E2=80=AFPM <wuqianhai@loongson.cn> wrote:
>
> From: wuqianhai <wuqianhai@loongson.cn>
>
> On LoongArch the kernel cannot reliably identify the display device that
> was set up by the firmware and used for the boot console.  Two code paths
> need this information and currently get it wrong:
>
>   * The PCI VGA arbiter: vga_is_firmware_default() is compiled only on
>     x86, so on LoongArch vga_default_device() may select the wrong GPU
>     when several are present (for example an integrated display
>     controller and a discrete card).
>
>   * The framebuffer console: LoongArch does not implement
>     video_is_primary_device(), so with
>     CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy the console falls back =
to
>     the generic stub that always returns false and binds to the first
>     registered framebuffer instead of the boot display.
>
> This series fixes both by publishing the firmware framebuffer information
> through screen_info on LoongArch and consuming it the same way x86 does.
>
> Patch 1 always defines and initializes sysfb_primary_display, and always
> provides its EFI stub alias, instead of guarding them behind
> SYSFB/EFI_EARLYCON.
>
> Patch 2 refreshes screen_info from the PCI resource-assignment path after
> the root-bus resources are assigned, so the framebuffer address is final
> before the VGA arbiter and sysfb_init() consume it.  The call is placed
> in the LoongArch PCI scan path because only LoongArch has this ordering:
> acpi_init() relocates the BAR before vga_arb_device_init() runs.  On x86
> the screen_info address is still accurate at that point.  If you would
> rather have the helper called from the generic
> pci_assign_unassigned_root_bus_resources() path so that all architectures
> share it, that can be done instead.
>
> Patch 3 removes pci_fixup_vgadev(), which overrides the VGA default
> device to a discrete card after the arbiter has already selected the
> firmware framebuffer device, so vga_default_device() consistently
> reflects the boot display.
>
> Patch 4 implements video_is_primary_device() for LoongArch by reusing the
> VGA default device selected by the arbiter.
>
> Patch 5 lets the EFI stub link directly to sysfb_primary_display on
> LoongArch, so the firmware framebuffer information is always populated.
>
> Patch 6 lets the VGA arbiter use CONFIG_SCREEN_INFO instead of an
> architecture check and makes VGA_ARB select SCREEN_INFO on LoongArch.
>
> Patches 1-4 are LoongArch-specific.  Patches 5 and 6 touch generic code
> (the EFI stub and the PCI VGA arbiter) and are placed last so they can be
> reviewed and merged separately.  Patches 3 and 4 depend on patch 6 taking
> effect, but are ordered ahead of it only to group the LoongArch changes
> together.
>
> Changes since v2:
>   - Split the screen_info refresh out of vga_arb_device_init() into the
>     LoongArch PCI resource-assignment path (patch 2), following Thomas'
>     suggestion to decouple it from sysfb_init().
>   - Drop the per-architecture check in vgaarb.c and the select of SYSFB
>     in favour of CONFIG_SCREEN_INFO and select SCREEN_INFO (patch 6).
>   - Always define and initialize sysfb_primary_display, and let the EFI
>     stub link to it directly (patches 1 and 5), instead of guarding them
>     behind SYSFB/EFI_EARLYCON.
>   - Remove the vga_default_device() override (patch 3) so the arbiter's
>     firmware-framebuffer selection takes effect.
>   - Implement video_is_primary_device() (patch 4) by reusing the arbiter'=
s
>     default device, so FRAMEBUFFER_CONSOLE_DETECT_PRIMARY works.
>
> Build-tested on loongarch64 with GCC 8.3.0.
>
> wuqianhai (6):
>   LoongArch: efi: Provide sysfb_primary_display for screen_info users
>   LoongArch/PCI: Refresh screen_info after resource assignment
>   LoongArch/PCI: Remove vga default device override
>   LoongArch: video: Implement primary framebuffer device detection
>   efi/libstub: Enable direct sysfb_primary_display access on LoongArch
Please fold this patch to the first one.

And your signature should be:
Qianhai Wu <wuqianhai@loongson.cn>

Huacai

>   PCI/VGA: Enable firmware default device detection on LoongArch
>
>  arch/loongarch/Makefile                       |  3 ++
>  arch/loongarch/include/asm/video.h            |  7 +++++
>  arch/loongarch/kernel/efi.c                   |  5 +---
>  arch/loongarch/kernel/image-vars.h            |  2 --
>  arch/loongarch/pci/acpi.c                     |  4 +++
>  arch/loongarch/pci/pci.c                      | 18 ------------
>  arch/loongarch/video/Makefile                 |  3 ++
>  arch/loongarch/video/video-common.c           | 29 +++++++++++++++++++
>  drivers/firmware/efi/libstub/efi-stub-entry.c |  1 +
>  drivers/pci/Kconfig                           |  2 +-
>  drivers/pci/vgaarb.c                          |  2 +-
>  11 files changed, 50 insertions(+), 26 deletions(-)
>  create mode 100644 arch/loongarch/video/Makefile
>  create mode 100644 arch/loongarch/video/video-common.c
>
> --
> 2.34.1
>
