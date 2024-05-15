Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76EF149DEE;
	Wed, 15 May 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785977; cv=none; b=i42Z7Hdp7V0Jxt5t7dMH6eWFbksuiZ6DHbwzedNUBks5ffskvWEaZfoF30hr3vf0yEnJmB0pK9vttuhEmujp/l2ub0gsOMxYlo/cieGGPckZi+TUqsj1434sJpfUyZpJtt3oh2CZ7EKN01UH9AwXY8SqbMXZollTle1K/EREY3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785977; c=relaxed/simple;
	bh=MohQRmuzij8zaBjvSZ6XgNSJTKoAkymN8xRjFcjX1xw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lD+CKUWhuCqWSp6RSvYJUPcE35x22LRrkGbeOGFzU29dJpZn2wlr5mTseYWKu9t6PwsU/TZYNzmfJhhbCREoK7NhBPNb3G3iIHQhNOH502nQ67LUrYSoCkdz7wQum3zAxrCwVv9t0/RUTP10BbixUbqzqn3SJ4rPQtifsxRVcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFgnIH4x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFgnIH4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5722FC4AF11;
	Wed, 15 May 2024 15:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715785977;
	bh=MohQRmuzij8zaBjvSZ6XgNSJTKoAkymN8xRjFcjX1xw=;
	h=Date:From:To:Subject:From;
	b=vFgnIH4x9Jwg2t+XFj1osZJGM2+MM6XiahjRQBHPWE/OR2xFNrrnIOfiLM45840B2
	 NRdRLZ/AvHv4NnSlvQ6zX+cIwBdd2O2XsjNMai2ShUT6uxrIeM/gyzNsgtgu7WOoTF
	 SQc69hKVbpc6N9oOtfQF+LxRZ2PfEjGbxOvrgMQnb6sANNcGSE6z9KBE9tGnmvxWbF
	 upA/nVAzEEpgU4XQPcUTPc+gXGoCr5uo8NUvoJ+0xcuBjIsciDpxYR3sftnWzCa/U6
	 45NUgg3Lu8q8B20u8dML900U1ZDI1N0jFrmLtEKkInBshKK4KnDQHW9WpiUleZD0Q2
	 lz0K7Y+dUuNLw==
Date: Wed, 15 May 2024 17:12:52 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and cleanups for v6.10-rc1
Message-ID: <ZkTQ9JoGXFwuMzZS@carbonx1>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull some fixes and cleanups for the fbdev drivers for kernel 6.10-rc1.

Code cleanups for offb, shmobile, sisfb, savage, au1200fb, uvesafb,
omap2 and sh7760fb, as well as the addition of some HAS_IOPORT
dependencies and adjustment of generated logo file to make build
reproducible.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.10-rc1

for you to fetch changes up to ce4a7ae84a58b9f33aae8d6c769b3c94f3d5ce76:

  fbdev: offb: replace of_node_put with __free(device_node) (2024-04-25 12:13:06 +0200)

----------------------------------------------------------------
fbdev fixes and cleanups for 6.10-rc1:

Code cleanups for offb, shmobile, sisfb, savage, au1200fb, uvesafb,
omap2 and sh7760fb, as well as the addition of some HAS_IOPORT
dependencies and adjustment of generated logo file to make build
reproducible.

----------------------------------------------------------------
Abdulrasaq Lawani (1):
      fbdev: offb: replace of_node_put with __free(device_node)

Arnd Bergmann (2):
      fbdev: shmobile: fix snprintf truncation
      fbdev: sisfb: hide unused variables

Cai Xinchen (1):
      fbdev: savage: Handle err return when savagefb_check_var failed

Justin Stitt (4):
      fbdev: fsl-diu-fb: replace deprecated strncpy with strscpy_pad
      fbdev: au1200fb: replace deprecated strncpy with strscpy
      fbdev: uvesafb: replace deprecated strncpy with strscpy_pad
      video: hdmi: prefer length specifier in format over string copying

Kuninori Morimoto (1):
      fbdev: omap2: replace of_graph_get_next_endpoint()

Lucas Stach (1):
      video: logo: Drop full path of the input filename in generated file

Niklas Schnelle (1):
      fbdev: add HAS_IOPORT dependencies

Randy Dunlap (1):
      fbdev: sh7760fb: allow modular build

 drivers/video/fbdev/Kconfig                   | 26 +++++++++++++-------------
 drivers/video/fbdev/au1200fb.c                |  2 +-
 drivers/video/fbdev/fsl-diu-fb.c              |  2 +-
 drivers/video/fbdev/offb.c                    |  3 +--
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c    |  3 ++-
 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c | 20 +-------------------
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c  |  3 ++-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c  |  3 ++-
 drivers/video/fbdev/omap2/omapfb/dss/venc.c   |  3 ++-
 drivers/video/fbdev/pxafb.c                   |  2 +-
 drivers/video/fbdev/savage/savagefb_driver.c  |  5 ++++-
 drivers/video/fbdev/sh_mobile_lcdcfb.c        |  2 +-
 drivers/video/fbdev/sis/init301.c             |  3 +--
 drivers/video/fbdev/uvesafb.c                 |  2 +-
 drivers/video/hdmi.c                          | 10 ++--------
 drivers/video/logo/pnmtologo.c                |  2 --
 include/video/omapfb_dss.h                    |  3 ---
 17 files changed, 35 insertions(+), 59 deletions(-)
