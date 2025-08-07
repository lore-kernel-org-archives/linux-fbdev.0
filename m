Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879C20126A;
	Thu,  7 Aug 2025 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565711; cv=none; b=J0ceI2OEFLcbGrMPOxNr7hT1UUauEZEWPGshdqlJyldtCoZa23tuvQbazv0SbOl8cfIlZohbDA5dObrCpR1EFxVJS5wPYaWADXt/0TAqhmLM42fElkyDFvay9c/DeyiNTgGNWWunbWSpHJiv5I8Yjo5SMsOoA7H9NeGnZvJyKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565711; c=relaxed/simple;
	bh=DbcTSWaRzktvT+5n3OPpZZIBogKl8mnhUbrMX9SXuKM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OT0a6+s1Srs/howJXjmEQ751rjC5kQT/cP8JjB1gyo6pAEh+zPXKvYtnaT3/zzCkjbW4SY57w+P942Y/fssiWZlX4wHxehZScc8gf35OWnAJcvrypanjTPfvHvZOpn4Gf5ygQhjGXTj0V/9usVLKhkUmX3S9Ij+MHrXz1Elhcw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zpfj8Dtm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zpfj8Dtm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A06EC4CEEB;
	Thu,  7 Aug 2025 11:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754565711;
	bh=DbcTSWaRzktvT+5n3OPpZZIBogKl8mnhUbrMX9SXuKM=;
	h=Date:From:To:Subject:From;
	b=Zpfj8DtmGkq6q534Y5j9vbVipoEx56NKo08uV0+vVDW0godlpQs4R8YsFCmL4dXvw
	 uAlcjgN20whTobeH4tIh2SETH5hS8KhOi3YdVsoYgU74a7CJ5o5BYrwAR7JJ5hy5LK
	 gQ8H99t/cCildzr01qHzHcHy7GdV+lbH91v0MRoTGCWbNI3kCcBCBY9/8oBnWu6QBz
	 qqXAo9XZ+Gw5DzDTHZZG7wVbaBcze5Lm2ogLD+p3VgJmd7WodIgtOHMd0LWgp4SdtU
	 ViXda9Ds4z79a9yjzYCMjbI7TX3QCe999CQULZbGQzlQDYSM6eY8RfL9SYt19A+Dff
	 tBWLsqiWW2E/g==
Date: Thu, 7 Aug 2025 13:21:47 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev last fixes for v6.17-rc1
Message-ID: <aJSMS8PhMMe0NL63@p100>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull two more fbdev fixes for 6.17-rc1:

One patch reverts a previous stable tree patch which broke the VGA console,
the other fixes an out-of-bounds access bug which may happen during console
resizing when a console is mapped to a frame buffer.

Both patches are tagged for stable series.

Thanks,
Helge

----------------------------------------------------------------
The following changes since commit 038d61fd642278bab63ee8ef722c50d10ab01e8f:

  Linux 6.16 (2025-07-27 14:26:38 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.17-rc1-2

for you to fetch changes up to e4fc307d8e24f122402907ebf585248cad52841d:

  Revert "vgacon: Add check for vc_origin address range in vgacon_scroll()" (2025-08-02 21:47:33 +0200)

----------------------------------------------------------------
fbdev fixes for 6.17-rc1:

- Revert a patch which broke VGA console.
- Fix an out-of-bounds access bug which may happen during console
   resizing when a console is mapped to a frame buffer.

----------------------------------------------------------------
Helge Deller (1):
      Revert "vgacon: Add check for vc_origin address range in vgacon_scroll()"

Sravan Kumar Gundu (1):
      fbdev: Fix vmalloc out-of-bounds write in fast_imageblit

 drivers/video/console/vgacon.c   | 2 +-
 drivers/video/fbdev/core/fbcon.c | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)
