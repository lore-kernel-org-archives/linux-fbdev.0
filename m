Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AB81BC09F
	for <linux-fbdev@vger.kernel.org>; Thu,  2 Jan 2025 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735853493; cv=none; b=IKu8c/uj8otSrm58I08lBD6dioaG9WNXm5A6Cv7tzl9Tuu74JxQTYH79RKsz/LNGL2YOpIfw94lGWAEHAuQjA/3MwOAJ2PraIPnjDBQyAACMoo4oUkQZ8mekrykOcomw4tTHIVOkDLzrOuVS693AvTYWcT/X1Z7MiDtfis7uT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735853493; c=relaxed/simple;
	bh=NnzBHzwJl1oNYm0MW1+GIWbuimntCPGF17uTfgGopJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S75WRBsNDpy1KIUCYEgwIooAqUfIPzS+yEutCXtMNv+oa6TTE2/rvVUqlW52IYO3ZsiwqU0UcrjwjkHdpCdAhcHEhX4M/CYJcL8IEojTsLi9p0UnVq3wLDO/w/qI78ChhBWO5jWSGM+GYCBmWpenNT4gYGtKbTxvf0KrCSVp2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vhbZpQIw; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhbZpQIw"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54024aa9febso13076919e87.1
        for <linux-fbdev@vger.kernel.org>; Thu, 02 Jan 2025 13:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735853489; x=1736458289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usBhbRysbrNPNt+dCknWS9a6GgYpIUw/Jl5XkjavJKY=;
        b=vhbZpQIw/bLF/xOXzHbnkMB2K8Yg0wRHcVdL7yqaOfee0TdPbVwroRLJqJ0tyOgjX2
         d/AV2QJC6rGQtYevd41ZnnRhxHhB3sh+wKcfudu4ste9zBQp8jjStrojEOYF2riXp2hD
         3YKoo+YHJvvWMLr4k/C6A7rzutyk5rXi8+x7fL7dwo8tqIWhZzoJpJfqnbMsig3CtV0U
         vzCabq91YHQgsgVhrEpLN7iHw4UJnoE60RebD1PdPeNs6zX67PRh3bftmtZzAzZ2PRb2
         2Gf2/cGm8HdH8/ImxnI6nkPZ2e8oZsuTo8HLnZ1I5X/x2dq/A30yFoxmk9Fn15aFxLNe
         twlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735853489; x=1736458289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usBhbRysbrNPNt+dCknWS9a6GgYpIUw/Jl5XkjavJKY=;
        b=War/i3E2NvrAiED3+yFClAyFRm1UzaS2vTfGoKizHgCuftRa6DhIZ3vvOu4ovyFcrq
         ZliLjW1nn2QNyiR7yIkX2N0bBanW0BnTStK8LMk3k1R7VRgvUaeyi0mNkCQ7qOpE0ODF
         GDV9/cGeHtU9SWRd0gBuTjAJtrG4e5isM8ugaP/zPRLBfL9wZOcA52vNSsNT0k5WL44/
         /6CG6hI7aEE5bHmMu9Cpbh1sfxCbrPs+PZyTV9P8r/08yFfPezkqpHuPhNQ/KhGVLrWh
         5o48IltBvvNr1maZv4A8U7/GkBM0331iI+8kXDWvfOLbALZ6kr9dacfdBprda74EJ1ru
         Qjpg==
X-Forwarded-Encrypted: i=1; AJvYcCWY5dAOTJjdi16stac+AF4V5N/jU7B3Cjt8Qf2ZtBbfo8jXt0kNHSMFIH4wHPdzurvW9n2ldq9k48uGmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4yZWU0abvIks7uBHsprOwFmFd3a8Kt0DwSV3Kis/LBlkKD6HG
	QhJiHKB0OgowNxJTLAc95CFVHiEUQFqY2aXKgC768WzWcltjYXosw70LwthwLIl0Mq3Jc4vk603
	MRyvLxe80FWAKwGLkAxdM3l1sv6Yj3b8yh/tfRA==
X-Gm-Gg: ASbGnct5pzoELmyjMehaUti5HOvkkiKL6aR6l5dv2ZGIK2QNxCiHXn3ocOz4a7+U+S1
	DJH+CTw9lZkjDk3GmBdPG+5CnCelXGU93iHa5
X-Google-Smtp-Source: AGHT+IEfQcmpt4yo78zeyiW21woV39R54BV3/zwpN1Hk/I+z3wEi50BsJMs8YPoW7H7kJj4xx3h+r/iHcsMhpVtWva4=
X-Received: by 2002:a05:6512:3f0d:b0:53e:2f9d:6a73 with SMTP id
 2adb3069b0e04-542294aeacbmr14066905e87.0.1735853488948; Thu, 02 Jan 2025
 13:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102181953.1020878-1-aaro.koskinen@iki.fi> <20250102181953.1020878-2-aaro.koskinen@iki.fi>
In-Reply-To: <20250102181953.1020878-2-aaro.koskinen@iki.fi>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 Jan 2025 22:31:18 +0100
Message-ID: <CACRpkdZP_KnRRUO2J9a6jWCCBs8wzX=ct8rRW4jnFATJ2hZh5Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] fbdev: omap: use threaded IRQ for LCD DMA
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Helge Deller <deller@gmx.de>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 7:20=E2=80=AFPM Aaro Koskinen <aaro.koskinen@iki.fi>=
 wrote:

> When using touchscreen and framebuffer, Nokia 770 crashes easily with:
>
>     BUG: scheduling while atomic: irq/144-ads7846/82/0x00010000
>     Modules linked in: usb_f_ecm g_ether usb_f_rndis u_ether libcomposite=
 configfs omap_udc ohci_omap ohci_hcd
>     CPU: 0 UID: 0 PID: 82 Comm: irq/144-ads7846 Not tainted 6.12.7-770 #2
>     Hardware name: Nokia 770
>     Call trace:
>      unwind_backtrace from show_stack+0x10/0x14
>      show_stack from dump_stack_lvl+0x54/0x5c
>      dump_stack_lvl from __schedule_bug+0x50/0x70
>      __schedule_bug from __schedule+0x4d4/0x5bc
>      __schedule from schedule+0x34/0xa0
>      schedule from schedule_preempt_disabled+0xc/0x10
>      schedule_preempt_disabled from __mutex_lock.constprop.0+0x218/0x3b4
>      __mutex_lock.constprop.0 from clk_prepare_lock+0x38/0xe4
>      clk_prepare_lock from clk_set_rate+0x18/0x154
>      clk_set_rate from sossi_read_data+0x4c/0x168
>      sossi_read_data from hwa742_read_reg+0x5c/0x8c
>      hwa742_read_reg from send_frame_handler+0xfc/0x300
>      send_frame_handler from process_pending_requests+0x74/0xd0
>      process_pending_requests from lcd_dma_irq_handler+0x50/0x74
>      lcd_dma_irq_handler from __handle_irq_event_percpu+0x44/0x130
>      __handle_irq_event_percpu from handle_irq_event+0x28/0x68
>      handle_irq_event from handle_level_irq+0x9c/0x170
>      handle_level_irq from generic_handle_domain_irq+0x2c/0x3c
>      generic_handle_domain_irq from omap1_handle_irq+0x40/0x8c
>      omap1_handle_irq from generic_handle_arch_irq+0x28/0x3c
>      generic_handle_arch_irq from call_with_stack+0x1c/0x24
>      call_with_stack from __irq_svc+0x94/0xa8
>     Exception stack(0xc5255da0 to 0xc5255de8)
>     5da0: 00000001 c22fc620 00000000 00000000 c08384a8 c106fc00 00000000 =
c240c248
>     5dc0: c113a600 c3f6ec30 00000001 00000000 c22fc620 c5255df0 c22fc620 =
c0279a94
>     5de0: 60000013 ffffffff
>      __irq_svc from clk_prepare_lock+0x4c/0xe4
>      clk_prepare_lock from clk_get_rate+0x10/0x74
>      clk_get_rate from uwire_setup_transfer+0x40/0x180
>      uwire_setup_transfer from spi_bitbang_transfer_one+0x2c/0x9c
>      spi_bitbang_transfer_one from spi_transfer_one_message+0x2d0/0x664
>      spi_transfer_one_message from __spi_pump_transfer_message+0x29c/0x49=
8
>      __spi_pump_transfer_message from __spi_sync+0x1f8/0x2e8
>      __spi_sync from spi_sync+0x24/0x40
>      spi_sync from ads7846_halfd_read_state+0x5c/0x1c0
>      ads7846_halfd_read_state from ads7846_irq+0x58/0x348
>      ads7846_irq from irq_thread_fn+0x1c/0x78
>      irq_thread_fn from irq_thread+0x120/0x228
>      irq_thread from kthread+0xc8/0xe8
>      kthread from ret_from_fork+0x14/0x28
>
> As a quick fix, switch to a threaded IRQ which provides a stable system.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
