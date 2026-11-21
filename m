Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795280396;
	b=hz1Q81AzGiHHgsqk9OVGYGge9ao00Wg/7YxDYZSS6KwMMKAWKlNE2LqZaFIZtdQB4xcx
	 Relf1QtwnsCfMa69GhDFeHK7K0b9iCFsKQySbXA+fWi1Zp2/TJTanJLEKv7ruLsqrgqLh
	 3DnG2dOHmSnbe/RDyruUsigfqac1+9gyupc4cYKxwfdXmd6eD+ddPVdcwiFqVf+6PuvQi
	 0tjHYIaNv6jtGO3431DdW1Q4M+YYqlwiYnu/9Bz3H4O7yAlHc2/VvjeZ6EBqu26yskZh6
	 tTVVaj459hiV+xRGunju0qhud3lY1VYeLf9Nme4PJu20C/+eqGtfmiBtOl77YlhYhBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795280396;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition;
	bh=HxFQ2qa/MmVsd7tMIBT1v4526ip7d+VB96nm/kUeU0c=;
	b=R5uY6aNjsxN9XRAeLUrsrOAct0jWQ81XjMZTg0Us6+j/TEaO++I9PlN40SpzmHqyBJGn
	 l41MiQLmh6zxYXroQ9dpJf3Mgpbw74R/ieQ2qcUeNROvSzSAO4cab5wvBxNCE6CYRPmyQ
	 9OoT6+JAruqpegmDESjz9VyX+/NDEp4xRfEPynid6j8yIesDlpdRtyozLy4D8+FJJAKHf
	 yM+OBCgK9bnvlagyYxRvWQbm/2UBw6Z2JYVWy2hBJ+HD1FbzhZjSTAZgiUR1tTEBgenKM
	 1KPIxQuw9QMrLj1HlWyuW3G/7lOpAaOOXYqtTHwuMrZH/e/YdVlZoVg2F4Qqq7pnKxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrA1lHl4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427CD606A32C;
	Sat, 21 Nov 2026 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrA1lHl4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBE31F000C6;
	Sat, 21 Nov 2026 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795280395;
	bh=HxFQ2qa/MmVsd7tMIBT1v4526ip7d+VB96nm/kUeU0c=;
	h=Date:From:To:Subject;
	b=XrA1lHl4gnn2kw/Bz9DfiQwty3vdVgUUmcCpbnNE5YokCOeCyK9ut/VNAUd+/LI7F
	 ny/GwGPeF9RR/9wExG7twav6NXRbpAVE9dxPYHoC5nRWVY9bQgZbN5g/3CkH2smJg5
	 Tpzf8iGI/7pKH0AiQiuxl4D7IBRPe7mvJQ4hgcAddeG4J9e6bqRd+H0H/mx3gAYd8+
	 CGAkSDk7YlsxZXLi0yCdMivpTQUzIquIFlm2QT8+VHu4XNE8E2fFWYqxx1S20Ry17p
	 WmMcSIWogeY2Uu1Gppxt6mmwjbPSGil5+hTpKK3UJm0/Poub821WFMZtWmNGPzAhmE
	 R17rjA13cn9NA==
Date: Sat, 21 Nov 2026 17:59:51 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes for v7.4-rc4
Message-ID: <awHOB8hdCRXVd--I@carbonx1>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear Linus,

please pull some more fbdev fixes for kernel v7.4-rc4.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:

  Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.4-rc4

for you to fetch changes up to b3f1631d362539cfe14571ccfd7db919ffbc08c7:

  fbdev: radeonfb: reject a zero pixclock in radeonfb_check_var() (2026-11-19 17:57:11 +0100)

----------------------------------------------------------------
fbdev fixes for 7.4-rc4:

Various small fixes, all scheduled for backport, which fix out-of-bound
accesses, improves the parameter checks or fix use-after-free accesses in
fm2fb, radeonfb, cobalt_lcdfb, valkyriefb, sstfb.
vgacon now falls back to the dummy console if mapping the VGA memory
fails, which fixes a crash on Alpha, and fix one sleep-in-atomic-context
bug which is triggered by the blinking cursor.

----------------------------------------------------------------
Jianqiang Zou (1):
      fbdev: radeonfb: reject a zero pixclock in radeonfb_check_var()

Matt Turner (1):
      vgacon: Fall back to the dummy console if mapping VGA memory fails

Miro Kropacek (1):
      fbdev: atafb: Restrict SuperVidel handling to the Falcon

Steffen A. Mork (1):
      fbdev: fm2fb: Fix iomem access

Suyuan Wang (1):
      fbdev: cobalt_lcdfb: Don't read info after framebuffer_release()

Tim Douglas (2):
      fbdev: macmodes: compare the pixel clock of each candidate mode
      fbdev: valkyriefb: keep the framebuffer mapping size fixed

Weiming Shi (1):
      fbdev: vfb: Validate framebuffer geometry and memory size

Xue Haolin (1):
      fbdev: sstfb: Error out if pixclock equals zero

Yao Yiqi (1):
      fbcon: Avoid cancel_delayed_work_sync() in atomic context

YuanZhe Liu (3):
      fbdev: smscufx: don't free registered framebuffer on probe error
      fbdev: smscufx: keep the usb_device alive while ufx_data is in use
      fbdev: smscufx: allocate the size advertised in smem_len

 drivers/video/console/vgacon.c        |  2 ++
 drivers/video/fbdev/atafb.c           | 18 ++++++++++-----
 drivers/video/fbdev/aty/radeon_base.c |  3 +++
 drivers/video/fbdev/cobalt_lcdfb.c    |  3 ++-
 drivers/video/fbdev/core/fbcon.c      | 41 ++++++++++++++++++++++++++++++-----
 drivers/video/fbdev/core/fbcon.h      |  1 +
 drivers/video/fbdev/fm2fb.c           |  2 +-
 drivers/video/fbdev/macmodes.c        |  2 +-
 drivers/video/fbdev/smscufx.c         | 26 +++++++++++++++++-----
 drivers/video/fbdev/sstfb.c           |  3 +++
 drivers/video/fbdev/valkyriefb.c      |  3 +--
 drivers/video/fbdev/vfb.c             | 18 +++++++++++++--
 12 files changed, 99 insertions(+), 23 deletions(-)
