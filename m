Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3404C74;
	Sat, 31 May 2025 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748711616; cv=none; b=BWdKxaYVNEOVw1MgvwkA208RSg5eBO3b6+R0ezpfuJiBTO7t/d9y76+M73XAmfMtoJcUCywWEPyBcytu1areBIoEn6VLxJuaRG3rROB34zcqdeBN1fssHeOSI8LhuotpU2C8QlRIu3tTZMXCQ8PX4pH0ECUNcUwRq8yYbzevYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748711616; c=relaxed/simple;
	bh=WlJNuiE+C9mhjb6dd0QzBTMplOmQ0UM3DzsGqoxwTyE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J9nBj+PIsEkk96Fd5CxTHoYH1jomDaBGiQe/mi3TLt2LtUR4iq7QKZs9/cMB4+sXGsvBHZsYfGnyOzsavVghV6XPWW9xKnwucenoqF608PMp7HsBIAfDBy/fCeJWJbMF1MZZgBR5GuKB5MF8kWUZ0q4JPmygTBzdDWGCTzIZpJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgQd6BcD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgQd6BcD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A448C4CEE3;
	Sat, 31 May 2025 17:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748711615;
	bh=WlJNuiE+C9mhjb6dd0QzBTMplOmQ0UM3DzsGqoxwTyE=;
	h=Date:From:To:Subject:From;
	b=JgQd6BcDzdLrL6qzYhrttppJeaI0GY/PdGr8PBpKyN0HXXNL8MFk25yHN1bIpDBmU
	 33UJYBOdeJugeHPrNul0ZQ3Qb9rpqqhAHpuWtSW/J0cH3B/nE1b8+M6CmLEf0zPFUs
	 wuXMko98VD3gDbaVGplhWRhB7ATqfoYvCBv4Q5NFvOaN2WewfjhB72Lk7aZwz/ayPD
	 TmLy0gVTP3uheYOtQHInDlTbE+zYeDRpYxewAThmj2qiQ9CnpKpcB3Iqp+2S6jf28r
	 tU2LcKa85PdqGUE5N6+fuQh+IKraFjneu1Fd0H7A/ivCDKDXp3YIU2jORyiwVXkz5l
	 MXIOkvlPNuoRg==
Date: Sat, 31 May 2025 19:13:31 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev updates for v6.16-rc1
Message-ID: <aDs4uwcxU_M4mpVE@carbonx1>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull the fbdev fixes and updates for 6.16-rc1:

Many small but important fixes for special cases in the fbdev, fbcon and vgacon
code, some smaller code cleanups in the nvidiafb, arkfb, atyfb and viafb drivers
and two spelling fixes.

Thanks!
Helge

PS: All patches have been sitting in for-next for at least two days (the
majority of patches since weeks). I did a rebase because fast-forward merging
with head didn't work.

----------------------------------------------------------------
The following changes since commit 0f70f5b08a47a3bc1a252e5f451a137cde7c98ce:

  Merge tag 'pull-automount' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2025-05-30 15:38:29 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.16-rc1

for you to fetch changes up to 05f6e183879d9785a3cdf2f08a498bc31b7a20aa:

  fbdev: Fix fb_set_var to prevent null-ptr-deref in fb_videomode_to_var (2025-05-31 10:24:02 +0200)

----------------------------------------------------------------
fbdev fixes and updates for 6.16-rc1:

Various bug fixes for corner cases which were found with Syzkaller,
Svace and other tools by various people and teams (e.g. Linux Verification Center):
    fbdev: Fix do_register_framebuffer to prevent null-ptr-deref in fb_videomode_to_var [Murad Masimov]
    fbdev: Fix fb_set_var to prevent null-ptr-deref in fb_videomode_to_var [Murad Masimov]
    fbdev: core: fbcvt: avoid division by 0 in fb_cvt_hperiod() [Sergey Shtylyov]
    fbcon: Make sure modelist not set on unregistered console [Kees Cook]
    vgacon: Add check for vc_origin address range in vgacon_scroll() [GONG Ruiqi]

Minor coding fixes in:
    nvidiafb, arkfb, atyfb, viafb.

Spelling fixes in:
    sstfb.rst and carminefb.

----------------------------------------------------------------
Andy Shevchenko (1):
      fbdev: atyfb: Remove unused PCI vendor ID

Bartosz Golaszewski (1):
      fbdev: via: use new GPIO line value setter callbacks

Colin Ian King (1):
      fbdev: carminefb: Fix spelling mistake of CARMINE_TOTAL_DIPLAY_MEM

GONG Ruiqi (1):
      vgacon: Add check for vc_origin address range in vgacon_scroll()

Kees Cook (2):
      fbdev: arkfb: Cast ics5342_init() allocation type
      fbcon: Make sure modelist not set on unregistered console

Murad Masimov (2):
      fbdev: Fix do_register_framebuffer to prevent null-ptr-deref in fb_videomode_to_var
      fbdev: Fix fb_set_var to prevent null-ptr-deref in fb_videomode_to_var

Rujra Bhatt (1):
      fbdev: sstfb.rst: Fix spelling mistake

Sergey Shtylyov (1):
      fbdev: core: fbcvt: avoid division by 0 in fb_cvt_hperiod()

Zijun Hu (1):
      fbdev: nvidiafb: Correct const string length in nvidiafb_setup()

 Documentation/fb/sstfb.rst          |  2 +-
 drivers/video/console/vgacon.c      |  2 +-
 drivers/video/fbdev/arkfb.c         |  5 +++--
 drivers/video/fbdev/carminefb.c     |  8 ++++----
 drivers/video/fbdev/carminefb.h     |  2 +-
 drivers/video/fbdev/core/fbcon.c    |  7 ++++++-
 drivers/video/fbdev/core/fbcvt.c    |  2 +-
 drivers/video/fbdev/core/fbmem.c    | 22 ++++++++++++++--------
 drivers/video/fbdev/nvidia/nvidia.c |  2 +-
 drivers/video/fbdev/via/via-gpio.c  | 10 +++++-----
 include/video/mach64.h              |  3 ---
 11 files changed, 37 insertions(+), 28 deletions(-)
