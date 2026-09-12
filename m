Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5933C33ADB9;
	Sat, 12 Sep 2026 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202884; cv=none; b=SFxRezavSOtjpAzAhlp68KtU836aJXxcwJwYAqACwqCzs6fFukYTxNIsaR5ViNDWDGEhkB5cqRnjWMVdq86R2C5sLxsLGWmnh6LQa1kPxa8g5v/sJ54nDDTcyps4z+BOVOD4vcZFEXM5Dn5tZliZK0RyUEDE+k8495djLdIdXiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202884; c=relaxed/simple;
	bh=1lZaF91QHfiGzUwZQQ0f/wNrXpmHEiZgXU6ixxZAij0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OSM5ojass2EtHWNyAKcTOeSvvglg4aV3D+lMe7on/bfINY5NKTfHYDd5LqYMAXSPGbBeFQeKMSaSVY+oTJ/TI9BcD0VW2Yeff8fJkR9VfM4uxMXMmP4IsZExL1o8bCruF/vcwILt30QRFiewdzRfTwR7eyIKK6vUjkhi9/iDKtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihVIE7g7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihVIE7g7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1FF1F000FF;
	Sat, 12 Sep 2026 08:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789202883;
	bh=1tk0qknEtL6ahZxQ81GjoFnTdvhRjcdA5JX5kHRZR5c=;
	h=Date:From:To:Subject;
	b=ihVIE7g7ZswI7UU3BZYJfXTIikxYRg/6sTnZ4kyPmlp4HeU8p/i1LabyK0lEFVLP/
	 WmK81HJD5QK1DYd9LZQ3i5Sv7bXmDJgp6WnMRzDdhSpSBF5CD0nOBl0NVXAIuoqawP
	 LIgb8Pr85daKhA9+Sssg2ltlrpNHJCwAS8qlYW2H6D3DKbDXGWoCRdtWgWUOQ5c2P/
	 Fji+9pUVL+xXfyhXEhStqtS/dm0vB/Rd4k8OfpnznPm/OuzfQjwGH3ecySKFMK4Bxm
	 SbLd6B8j1dM9jj6Az4iHpFzrjvSi9JhpoonMlYt7tIfXPrq/gxaoKN+v4INkINYPCB
	 Sgi/prmxg0A/Q==
Date: Sat, 12 Sep 2026 10:47:58 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes for v7.3-rc3
Message-ID: <aqURvm8xf2oDLypa@carbonx1>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear Linus,

please pull a few fbdev fixes for kernel v7.3-rc3:

Two patches for VT core code and fbcon prevent potential out-of-bounds
reads on font or screen size changes, one fix limits the Superblitter in
atafb to supported modes only, and some minor fixes for vfb, ssd1307fb
and omapfb.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 26260251022fbc2f248a3d747a9b2b961b18d2d8:

  Merge tag 'livepatching-for-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching (2026-08-21 13:11:56 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.3-rc3

for you to fetch changes up to a0a34a40ed299c9c7cff6af163a5b883ee9d6d73:

  fbdev: vfb: defer cleanup until the last reference (2026-09-10 22:52:02 +0200)

----------------------------------------------------------------
fbdev fixes for 7.3-rc3:

- vt core: prevent potential out of bounds read on font change
- fbcon: prevent out of bounds read when logo bigger than screen
- atafb: limit SuperBlitter operations to supported layouts only
- vfb: fix driver removal cleanup sequence
- ssd1307fb: fix possible NULL pointer dereference on missing match data
- omapfb: Fix sparse warning in panel_enabled()

----------------------------------------------------------------
Helge Deller (3):
      vt: hide cursor prior to font changes to avoid out-of-bound reads
      fbdev: omapfb: Fix __be32 sparse warning in panel_enabled()
      fbcon: Fix KASAN slab-out-of-bounds Read in fbcon_prepare_logo

Linmao Li (1):
      fbdev: atafb: Restrict SuperBlitter to supported formats

Weiming Shi (1):
      fbdev: vfb: defer cleanup until the last reference

Yang Zi (1):
      fbdev: ssd1307fb: fix NULL pointer dereference on missing match data

 drivers/tty/vt/vt.c                                           |  9 +++++----
 drivers/video/fbdev/atafb.c                                   |  6 +++++-
 drivers/video/fbdev/core/fbcon.c                              |  7 +++++++
 .../video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c  |  5 +++--
 drivers/video/fbdev/ssd1307fb.c                               |  4 ++++
 drivers/video/fbdev/vfb.c                                     | 11 ++++++++---
 6 files changed, 32 insertions(+), 10 deletions(-)
