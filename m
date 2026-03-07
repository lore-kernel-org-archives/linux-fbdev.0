Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDBD30DD1C;
	Sat,  7 Mar 2026 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772916276; cv=none; b=jyjleSlwZ6P6GYTE3ttMII+PbUS+1imkwyHEaCjYER9/yfqdF15+tCoziN2di22IPNHMVieYADOcOJHrf3KyfedI+5vkFxWF2d+m8pcexRhKN2tNKkgjW+2+vH/Z3vB5lzAxR0662eWelQHFekNbC1UXuHq3v35FRDE35VxEAG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772916276; c=relaxed/simple;
	bh=oY0s3W/hYUWrijfF6RWam4IbufwGlzeBGFnSWdw4w5U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ikBy7uUlw6urrfwileztIoLDqmlhgSfbiKdoiJZxbixOtW5PjGv+eIbqk/zSOTzzaicUHDD7f+hJpyxaJhWB9FDanAdpKOAi0shm+PkyCEp0ZvpTOLoffeeqRzPeoQy9xuY3+ShR4xmKCWokq4zgMY3g9UMkY+HJWy/Sj5VxVO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhTmnhbv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhTmnhbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6002C19423;
	Sat,  7 Mar 2026 20:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772916276;
	bh=oY0s3W/hYUWrijfF6RWam4IbufwGlzeBGFnSWdw4w5U=;
	h=Date:From:To:Cc:Subject:From;
	b=JhTmnhbvQRC6xFqEylAw2qDd32ZiTar7Vd/U6oDeApqA9jP+4jdD3N7xLmfQRu2Tv
	 G2Q2Bi76fyclIuRNbbMu9ocZIAI7ezLF2M0vmS6Z6wXD3qiCXIjwPmmm4GdY4DCRP5
	 ytslczVgch+7sl1JhY4zB92hxeVbLw3vZoOlJlDqe8I+2kE5w5khcnohwezegRWOZO
	 fdCuJcG/3FdzNA8O9J42unqD7/nTOl8Jn5t6rtwOh2TLPmJ+nAM8DTl/JjLmOW/piq
	 lUwEiY0AUhLr9xElKlv3Wt0SBQVQ0m25XgJVe2RvsApOQBcYv8+ON5D8XKN1mKoYWK
	 9Gv3i8gEyMf3A==
Date: Sat, 7 Mar 2026 21:44:31 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: [GIT PULL] fbdev fix for v7.0-rc3
Message-ID: <aayOLznDX70UUs6T@carbonx1>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull one patch for the au1100fb driver to
fix a build error reported by the kernel test robot.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.0-rc3

for you to fetch changes up to e31a374a99f5026df6ebff2a1c49492276e776fd:

  fbdev: au1100fb: Fix build on MIPS64 (2026-03-05 17:35:12 +0100)

----------------------------------------------------------------
fbdev fixes for kernel v7.0-rc3:

Silence build error in au1100fb driver found by kernel test robot

----------------------------------------------------------------
Helge Deller (1):
      fbdev: au1100fb: Fix build on MIPS64

 drivers/video/fbdev/au1100fb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
