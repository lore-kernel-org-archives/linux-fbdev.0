Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C94FECFC
	for <linux-fbdev@vger.kernel.org>; Wed, 14 Oct 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976006; cv=none; b=BsTTmgLO0g1c0nuOw/yjA9yClpPxNCoJ140oRvB3cY2CYoJr1w1CGSPqsPi8yoZfW/Q13EP+zfN+dELoSPXX4/W1NWHwZ6Cdn1pqkcavqaLjSM3OO1RvXNVAUF2K35tSDAkPcLlK1vsEQXBthuSb64p6Ud/Nw1KnK7jy9saJT/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976006; c=relaxed/simple;
	bh=Q4sS6ysJkh6bVqmDm0t8nwutvdPtgGri+t2E+qvwZrQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=gHi8nRlRWC654Fwjh9qz7CbFTQaaMsFPBaByy5Z+Vx2jH/6cAdA9Vh9oSLguDvQqOcTn1ff/QawLbCszFR8MCHtC57VgwDadHvbiEgDFZAwdvUMoPDqIJJcCtGfPyoBBT/F2zL328ASHBLtWOe1SSZvr9APFH0s7fBfS4LdwUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnNRWHem; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnNRWHem"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3ab37ea4798so1458456a91.0
        for <linux-fbdev@vger.kernel.org>; Wed, 14 Oct 2026 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791976000; x=1792580800; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E41qJNRzVmPfHenlZSA2Vl9639pSTN9ZvaDbaLPA2p0=;
        b=lnNRWHemxl4Adum9W7q2lsSnAeuUGVAJM10nga7X5Ny3gjQ5nYA4FjQR4lEDYeTn4J
         QvoncNKcllKwbJkxdqgKQMANLUaCrSAm6NEZZm+LkmNBewYdAEFDkQch9VsAFSLokQuR
         iwEt/R+EF/oE5l14hESfPsB/m/v+x0qIjY62h88Jl58wY5b/nEI8SbiIC/1330VPQmpE
         WGJ8AxCc1Pih9+MHHLsgjSxEdsYwh1t6FGFqDrOim7gYI2kaaW0TFPDc0DiLA+vMkSjb
         MWMDKgIgVPOnAsil1oesXfD2fR/lRxXJvId/UyHS7jwJW5W1gouuRgFpdKef2iL6Unr9
         oeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791976000; x=1792580800;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E41qJNRzVmPfHenlZSA2Vl9639pSTN9ZvaDbaLPA2p0=;
        b=Lv3ZUx2+qe+aZn8BZClbp/EkZH7p+FtmvCZQnbPvB/hHnlVWTGg5/J8vBdGPC+U9+x
         cby0p0k8GJEF/Uf8lWFibCsEk/ioCoe4XzSLcwUpn1l20q4YKSy1aZUjw8w2MV88fj/a
         Yki93N3zDzIrnwL+e66NjTOK2M4SqOPX9GOs8cMoMLK4B3DzVe6gjURRgdRHy7diZOph
         PUyNZ3KLWXSkq9mIKLdooGs95uPbxvXFzgj8rDhHXQIE30zgeIuLSTCW0K4eHpCyujAk
         AiqotrKZfdFshXhGQ9WUUCKcdXBERInE64EGmhtN0tFL4pehkO0uMQseVmHNtdJKN1bU
         cOKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzq/asG0cwMinHLjS23zk0hjsskPgca/ho3wy9tGlvofy1z9xQg9+czqe4EhtU6m4FP1Jx2L7V/kS8bcg==@vger.kernel.org
X-Gm-Message-State: AFq9FYI9ntAI+OmcKmcPx3WsEmeebIEwbIBHS37RO1pi9XN+sMoig9yY
	zM207Vll5NspKO3frAVccja6ZViRZEfqm6OulohsUN1rd8+qm9KQOtx5
X-Gm-Gg: AYBFou3qk5n32jYXTy8TVHDgsOF4Ga9YChpNX0jkyQcGPXJGsG7heUpYtaWI425T4ze
	UnMoySNGwH4mwhj/dKSMMCIcsArxg/gVxwqQtQyoVCeOmy5RdVsqtxG2qQp/5KUtr5HuJPn8C3C
	zkAPRrNf0n8nBvXccJbtNCUOWc2XeZr+Ir7oddfF6u/+5Nn3CirzbPXQYH103JV80leGdrYfA7/
	i8BN8FVzJp+vrhYFMfPrP7kcW+lNzg59dp+sV8f5az3Ybsqab0Xbmc2uTi4vv2kSu320O63KUnh
	jDeaO4iS6yLWZFq6KQhvkm963xNh+5cyHqPOoU7YZzGfL6B2hOW0BVjQwMgkWbaPQFLZCClCBSC
	d1l5i/ZwBCbvqcTfG1yWtxq3PWlIDQNQDmtU4IYtvn448NU2vlTfhW9BYEVjpRr9VJrw+RnG8jL
	LXYCfilYNXPjyUxXi3rYbd1Q83f2AzLGRMXxvvEX/FGU3X9aOfMi1Kz5pZT+/qbkT8hlOefLehM
	pZ6RmYD0XMAn0vlSbE+LMCfjlaAHSo=
X-Received: by 2002:a17:90b:4a08:b0:3ac:4e91:bff7 with SMTP id 98e67ed59e1d1-3ac4e91c1b6mr2825151a91.48.1791975999552;
        Wed, 14 Oct 2026 04:06:39 -0700 (PDT)
Received: from [172.20.10.4] ([240e:471:300:dde:5eec:32d6:f33:1d4b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd5e2b79df5sm5281837a12.19.2026.10.14.04.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/2] HID: picolcd: Fix output-request and
 framebuffer locking
From: Aveline Noir <jm5905938@gmail.com>
To: Aveline Noir <jm5905938@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, 
 bigeasy@linutronix.de, linux-rt-devel@lists.linux.dev, deller@gmx.de, 
 simona@ffwll.ch, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
References: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
Date: Wed, 14 Oct 2026 19:06:31 +0800
Message-Id: <179197599193.532954.6543599494592547892.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1791975994; l=2119;
 i=jm5905938@gmail.com; h=from:subject:message-id;
 bh=Q4sS6ysJkh6bVqmDm0t8nwutvdPtgGri+t2E+qvwZrQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgboJ0y2WZIrQV0H4HJI1WEQ5sxS6pM
 Nc/XEYGLW8ee6wAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJSB+KMp1PvZyKEm4roi9iB1DW2hPjN7sh98ZjltMhWCFYkG+UkBAjTEszr3F5A7A+M39+3Sa31
 Dwagjpf+n0w0=
X-Developer-Key: i=jm5905938@gmail.com; a=openssh;
 fpr=SHA256:oSxqik6Pl1M8EjQW1QXKHoylm1jy0sguOWFFJlA9zf0

Hi Jiri, Benjamin,

Just a quick ping on this v2 series. Have you had a chance to take a look?

Both fixes have been tested with QEMU/UHID, though not on physical hardware. I'd appreciate any feedback and would be happy to make changes or run additional tests if needed.

Thanks,
Aveline

On 2026-09-28 18:15 +0200, Aveline Noir wrote:
> This series fixes two PicoLCD locking problems. The first moves output
> requests into sleepable context and serializes LED state updates. The
> second breaks the last-close/deferred-worker lock dependency using a
> private framebuffer update mutex.
> 
> The first patch was tested separately with the original syzkaller C
> reproducer and bounded concurrent sysfs/UHID-destroy workloads on
> PREEMPT_RT. The complete series additionally passed repeated framebuffer
> open/write/close and persistent-open framebuffer tests. Pre-fix modules
> reproduced the respective failures. Physical hardware, prolonged stress
> and suspend/resume have not been tested.
> 
> Patch 2's Fixes tag identifies the fbdev change that began draining
> deferred work from fb_release() while holding info->lock. Patch 1's Fixes
> tag was checked against the upstream transport-conversion diff.
> 
> Changes in v2:
> - Address Sebastian Andrzej Siewior's feedback: clarify that the issue
>   is not specific to PREEMPT_RT and identify picolcd_data::lock as a
>   spinlock_t in patch 1. The code changes are identical to v1.
> 
> Aveline Noir (2):
>   HID: picolcd: Move output requests out of spinlocked sections
>   HID: picolcd: Avoid framebuffer last-close deadlock
> 
>  drivers/hid/hid-picolcd.h           |  4 +++
>  drivers/hid/hid-picolcd_backlight.c |  7 ++--
>  drivers/hid/hid-picolcd_core.c      | 46 +++++++++++++++---------
>  drivers/hid/hid-picolcd_fb.c        | 56 ++++++++++++++++++-----------
>  drivers/hid/hid-picolcd_lcd.c       |  7 ++--
>  drivers/hid/hid-picolcd_leds.c      | 31 +++++++++-------
>  6 files changed, 93 insertions(+), 58 deletions(-)
> 
> 
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> -- 
> 2.55.0
> 


