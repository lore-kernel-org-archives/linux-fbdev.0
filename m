Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F2030D3F8;
	Sat,  8 Aug 2026 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786197028; cv=none; b=LsCqodSDUDnBuOvGqSnS8dKe2Ktwr2GDg0qzD5y73+zGv+y85jufO3yg8/c4+khtlJiBCNYZLjmTi4E4hRZ5WQ4JM+l6859RAk5/Hx279ugxIrX1T5BRzgIGCJmouUh5t6op3Ms633LZZlPbgZTwBRV4kPq9mkUkF7SsxBo60yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786197028; c=relaxed/simple;
	bh=Rm7T4Wjqp0sJ5H1SW2qnmbcQIc/hyxpzGUWjbtJIn+Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g1wJjdU4DA2LOiZxp2lctFaY+5Rr0wS7pqLWJHywu4R8yfN1HROqG6EO9MeRkDxzDpAO6V6DsRafozAwQJ80jBXoP+kQLYMWomH4JqaJD+lAeChu/OTmEsPAUEOhibBcMDx4XiyM/2zIBp8EvrYEomjEHZDql/mEn5eMvgqDF1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJMd9i9P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJMd9i9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C853C1F000E9;
	Sat,  8 Aug 2026 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786197027;
	bh=3zxx3/PzGwASfboZ9qvWP2qPW71D1PeGodgREbdfyV0=;
	h=Date:From:To:Subject;
	b=kJMd9i9PdZRXVQzMMeLTNSmjm/F0485RN+i1aVWNghmTI5yzQJPGNxEyGPIZM9jJA
	 maA/DNy3g4XzGkVnHZo+so2Myai0f5JTkZFk31USfOX8jnJUPOB8SxQc9MnHVrlvKg
	 R2v7Rx3q5J5mprgBGcU6RqsX0pWQscNVDmeD5O1oyr2F0My2lC7GOAiUCAMfRo7KOK
	 t1c0CTS9JZ1UawZMOh7Zo/16lYHsjLFjwNUi8KAUBBUUhXYTeCy1+Ep7/h/uk+msa9
	 KPtDbj5hsXg91kOubrl5F8srDzHA+dorERetv4zDDTSpKUhPO6ESuWe4pKxiFrtr2x
	 6+pCwbs48Azhg==
Date: Sat, 8 Aug 2026 15:50:22 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes for v7.2-rc7
Message-ID: <anc0HhpSwT_c7CTg@carbonx1>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear Linus,

please pull a few important fixes for the core fbdev layer for kernel v7-2-rc7.
All patches are tagged for stable, and most of them have been in for-next
for some weeks.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 075b74841bd0065a3bda3440873c747938e69b68:

  Linux 7.2-rc6 (2026-08-02 16:24:24 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.2-rc7

for you to fetch changes up to e033cbf3975a8465f879ebd5989dc35b04423a4d:

  fbdev: bitblit: bound-check glyph index in bit_cursor() (2026-08-08 08:08:58 +0200)

----------------------------------------------------------------
fbdev core fixes for 7.2-rc7:

A few patches for the core fbdev layer which stabilize or fix potential
issues with text font rendering after screen rotation or after user
initiated font changes and locking fixes for sysfb during modifications
of the graphics mode database.

----------------------------------------------------------------
Melbin K Mathew (3):
      fbdev: bound mode sysfs output to the sysfs buffer
      fbdev: clear fb_info->mode before deleting a videomode
      fbdev: serialize mode sysfs access with lock_fb_info()

Mingyu Wang (1):
      fbdev: core: Fix pointer desynchronization in fb_io_read()

Rik van Riel (1):
      fbdev: bitblit: bound-check glyph index in bit_cursor()

Zizhi Wo (1):
      fbdev: Fix out-of-bounds access when rotating console after font resize

 drivers/video/fbdev/core/bitblit.c    |  9 ++++--
 drivers/video/fbdev/core/fb_io_fops.c |  8 +++++
 drivers/video/fbdev/core/fbcon.c      | 25 +++++++++++++++
 drivers/video/fbdev/core/fbmem.c      |  5 ++-
 drivers/video/fbdev/core/fbsysfs.c    | 59 ++++++++++++++++++++++++++++-------
 5 files changed, 91 insertions(+), 15 deletions(-)
