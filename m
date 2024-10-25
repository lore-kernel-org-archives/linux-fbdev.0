Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B8502BE;
	Fri, 25 Oct 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872258; cv=none; b=DMmauvW+z57nB/1aGzFz6dk+MtBtZEU4esAjH0kG9/r2nDGD+s5xYHtzm/guQU6mFKtdZs54GHBlbEZwVSvpqK4u2kKjeeS4wFhBhLaLcFzegUk/+3urxGbbOdkbGjyrzfN7FMquBMnYpQzu5jj+cJDBacnS8NdLhXGNni6kIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872258; c=relaxed/simple;
	bh=3GN/a7Ti2kLXwP3TMysp3onE62zTDtm+ka6CTxhAJ9Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eYqft96KsRpkfuX/x/JGKYr7UI6lTkBqBv3iXi8YVKNpLdz+wRoVODpsEhzVO13lhYSi/pMwas6AAX7Afw2b0WT/Sud4/lzGPthK30wHRoqMYJITvj8y3epGd9ORZjufyKz7Lpp0xq10qeGUQFyaUdX3K4Pu4OQrADxPpDD98wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYzT5HuL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYzT5HuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C9FC4CEC3;
	Fri, 25 Oct 2024 16:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729872256;
	bh=3GN/a7Ti2kLXwP3TMysp3onE62zTDtm+ka6CTxhAJ9Y=;
	h=Date:From:To:Subject:From;
	b=dYzT5HuL0ca1Ql0ftP33qpVjOvn1I1nZA4HCiVCwVO0TT4DP4xq4bWwxG3y2bSrCY
	 S7/bx0h1eX4ATDO1qKIO9OZeJe7oOIhemklGo05qlwk3/F8CuG2mBV9NfSpU20smBk
	 229RIJ+UEWNAzvrdwer4fW/WPfuLlhDMM508ZTqsU/mcHoMN0FI2elTdWe2GJC7w0A
	 +qpmzzks+EmikJh759czZFpOzyy0cGEaXMjagqj0WhuN2Hd+w2F94Hb6C8QD2jPMvg
	 673iIqZby5l3zIO2XaJgWerrar6yiS3+VquThGrmT/ZXwhJZSxXvJMlllCaq9zUDU3
	 P5brjUqLgyaVQ==
Date: Fri, 25 Oct 2024 18:04:12 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev late fixes for v6.12-rc5
Message-ID: <ZxvBfDuqSC_TEM78@carbonx1>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

would you please pull a few late fbdev fixes ?
It's mostly about build warning fixes with cornercase CONFIG settings
and one big patch which removes the now unused da8xx fbdev driver.

Those patches have been in for-next for the last 10 days without issues
(Arnd's patch shows a later date because I added a R-b tag).

Thanks,
Helge

----------------------------------------------------------------
The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.12-rc5

for you to fetch changes up to 51521d2e2c35959cc70a62ccddf694965e29c950:

  fbdev: wm8505fb: select CONFIG_FB_IOMEM_FOPS (2024-10-21 11:16:51 +0200)

----------------------------------------------------------------
fbdev fixes for 6.12-rc5:

- Fix some build warnings and failures with CONFIG_FB_IOMEM_FOPS and
  CONFIG_FB_DEVICE
- Remove the da8xx fbdev driver
- Constify struct sbus_mmap_map and fix indentation warning

----------------------------------------------------------------
Arnd Bergmann (1):
      fbdev: wm8505fb: select CONFIG_FB_IOMEM_FOPS

Bartosz Golaszewski (1):
      fbdev: da8xx: remove the driver

Christophe JAILLET (1):
      fbdev: Constify struct sbus_mmap_map

Gonzalo Silvalde Blanco (1):
      fbdev: sstfb: Make CONFIG_FB_DEVICE optional

SurajSonawane2415 (1):
      fbdev: nvidiafb: fix inconsistent indentation warning

 drivers/video/fbdev/Kconfig        |   15 +-
 drivers/video/fbdev/Makefile       |    1 -
 drivers/video/fbdev/bw2.c          |    2 +-
 drivers/video/fbdev/cg14.c         |    2 +-
 drivers/video/fbdev/cg3.c          |    2 +-
 drivers/video/fbdev/cg6.c          |    2 +-
 drivers/video/fbdev/da8xx-fb.c     | 1665 ------------------------------------
 drivers/video/fbdev/ffb.c          |    2 +-
 drivers/video/fbdev/leo.c          |    2 +-
 drivers/video/fbdev/nvidia/nv_hw.c |    8 +-
 drivers/video/fbdev/p9100.c        |    2 +-
 drivers/video/fbdev/sbuslib.c      |    2 +-
 drivers/video/fbdev/sbuslib.h      |    2 +-
 drivers/video/fbdev/sstfb.c        |    9 +-
 drivers/video/fbdev/tcx.c          |    2 +-
 include/video/da8xx-fb.h           |   94 --
 16 files changed, 22 insertions(+), 1790 deletions(-)
 delete mode 100644 drivers/video/fbdev/da8xx-fb.c
 delete mode 100644 include/video/da8xx-fb.h
