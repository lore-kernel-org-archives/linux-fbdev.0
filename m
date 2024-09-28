Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FF92B9B1;
	Sat, 28 Sep 2024 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727522890; cv=none; b=BQhIeq/4Pwy0MFxJa3OGwRjlp86YocUJTyEmhXNUzMYmmu/hCHj17Szd/TGUGeyVLF2m8QQTOFVoWUc+JhZDbKYokK8FgqmB0VtKFOJxFuZ0a2Azybf+7tEQT0C2D3pYpERX+P77YmszWfH/m3nmEhkiaOOP5iWBWkrIoeY2v0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727522890; c=relaxed/simple;
	bh=HnqwsqxX6e/UhhhJRSVaLb04OKzlAy7bdb+ridZLIgY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tiq3rXEh8BnH2s1U6Un0zaJf9jOhK5qEIDECms3PlO2CfV+hMDP/EYymAmcYawDmTxYMvu296xwcOC3PRsHqfs7w226Rb4gd2yyV6KX2QTBHOX/LWTpaTCSMDp0My7EtBfYvygwdfaBZFQBwpl/OmKx+s/l0JoSM5kEPPgfXp3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bevd2xj4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bevd2xj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C684AC4CEC3;
	Sat, 28 Sep 2024 11:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727522889;
	bh=HnqwsqxX6e/UhhhJRSVaLb04OKzlAy7bdb+ridZLIgY=;
	h=Date:From:To:Subject:From;
	b=bevd2xj4qrX2BqoZGePTT04a285AgkmV9s1r2vVALj2p6Nm2JzZz96xPcKp3HWGdr
	 Kp2VQAOm7Z/a6NAEfnlniTDqXJn31saJ/BhzYO/4QOkEmqlTr5Frl7JE0EkO/vx7uX
	 3TatZmcA+hkQkeV3CEgPYC385sdfLNJToOBWLwILXfiLAusRuiOMxP9L1nHCq+5b1j
	 xvGMC564zBbsYVokqYSJ1AWyKqj6d6GsORdZOlvjYub45pUMIvsKwfUqMhPb/vmNW4
	 lxJp3srU3r3Nu7BgFKsm/fl1+JabD+fRN3hM0Gsfqxxy9XTRkr0ISa8pAG1Lkz5maS
	 6NIkmtKWXyLRA==
Date: Sat, 28 Sep 2024 13:28:04 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] additional fbdev fixes for v6.12-rc1
Message-ID: <ZvfoRGNbTUOzLL9X@carbonx1>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull the last few fbdev fixes for this merge window.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit abf2050f51fdca0fd146388f83cddd95a57a008d:

  Merge tag 'media/v6.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2024-09-23 15:27:58 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.12-rc1-2

for you to fetch changes up to 9cf14f5a2746c19455ce9cb44341b5527b5e19c3:

  fbdev: sisfb: Fix strbuf array overflow (2024-09-28 00:42:11 +0200)

----------------------------------------------------------------
additional fbdev fixes for 6.12-rc1:

- crash fix in fbcon_putcs
- avoid a possible string memory overflow in sisfb
- minor code optimizations in omapfb and fbcon

----------------------------------------------------------------
Andrey Shumilin (1):
      fbdev: sisfb: Fix strbuf array overflow

Markus Elfring (1):
      fbdev: omapfb: Call of_node_put(ep) only once in omapdss_of_find_source_for_first_ep()

Qianqiang Liu (2):
      fbcon: Fix a NULL pointer dereference issue in fbcon_putcs
      fbcon: break earlier in search_fb_in_map and search_for_mapped_con

 drivers/video/fbdev/core/fbcon.c              | 10 ++++++++--
 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c |  7 ++-----
 drivers/video/fbdev/sis/sis_main.c            |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)
