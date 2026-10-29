Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313075;
	b=BUWLFgAp2w9jHB5JVV/ZYmIZkzTdeWd3aMI8kRrImxt3dV/JaM4Sl5LQvHa4rLw+xRLn
	 TCRL9kYU3Y0Sroq+gm/lZRqSAnUBZuO7bzgvpA45CrZoj7RQDlIXP3roePeEL1ez1syIL
	 BEhzTsuoZchzsP472gJOOj20K991yrkh/mrDGMY4P1K0+BTwu5TNCV229VRpo6PRxoWt/
	 0u0fcGBkvRMliMEzNJKmb0INb3uO0rMUTpH5qhMkhCFS3z+j0AkNBx+QfZPoFbwA3SA4M
	 SnsSTC99iOKe0fNI5zNjBoQedtpxSbpcTZcvfIltVembKAY+FKEr6ps3VfXaLitcykQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313075;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition;
	bh=kKynRfMeyd4ry1GjXZu3dfS0+scYRKXk4/JZoEI+vkU=;
	b=MRmDxgL2ui3UQo6B4BQ6HOictCULw17Kw9F1lA5VUtStSnS4Ps0FwqtNu6FpK+m66/RZ
	 D49v+Bod3pQ1qvYD3G6KA7p+0ghdBM6QkmfbR7uKvF1Ze6nvXhPksAtzFa2pgWBou9ntu
	 ujWj9wumn1ZghThMLDqAZjMtBgBbA1grVjGZ78cYchjEbtJvc75yAMPt8kc7BjWQZcoxd
	 wwx6ozq8G1sjyDTC7ADOHKhkdhayz7WuW0Ynvfw3Mxp4DymmAFZQpuW4n8nozY3u7E1qK
	 F2WRPol/mljRrMAn0Y62snjECOTP5/+P1YfgB/ekIF4Y2CVP0dUgDXVdiZAiiScwdFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EVvez1b1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC6606A31A;
	Thu, 29 Oct 2026 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EVvez1b1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E7F1F01816;
	Thu, 29 Oct 2026 22:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793313075;
	bh=kKynRfMeyd4ry1GjXZu3dfS0+scYRKXk4/JZoEI+vkU=;
	h=Date:From:To:Subject;
	b=EVvez1b1EB47sk+UJxoqVcbHFtAUFwHpjHQkAZ1wdFeImLqzg65pJPaEeo8HmtSnz
	 b/yyFopSuKL+MC6cft3xMxg9psTTDdj3c/DDP5j3I1I1YFdAmxJ6w5SmYTXoftF4jb
	 mp/xgTqSI8JkvfYlZMemOhGc5SkXXbzg9I0Nnhl18Fh0XoY64dytuYcjBiLRndyZrx
	 wucXrav4rX9mR/iBWeBwfnmXFuGkJoPTRzmHwFhXOZGw/CoSRnNcgQaxxVpyJYn8UQ
	 lL11x+aprC9ybaznHlMbIAED344QLuM4GsewRi52l5IU53QKfhUetKTodS68tm82Ul
	 MwHg9f+gO89jA==
Date: Thu, 29 Oct 2026 23:31:09 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [GIT PULL] more fbdev fixes and updates for v7.4-rc1
Message-ID: <auPJLXQdFRtkoOCu@carbonx1>
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

please pull some more fbdev fixes and cleanups for kernel v7.4-rc1:

Simplify console blanking and one fix for a potential initialization
issue in atmel_lcdfb.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 21a7f44fd0765fcc5194130b28767786eba1d1e7:

  Merge tag 'devicetree-for-7.4' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux (2026-10-24 20:11:23 -1000)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.4-rc1-2

for you to fetch changes up to 01d1204582f16e8b7bfce29648e5cf77a585d962:

  fbdev: atmel_lcdfb: fix list_first_entry() on possibly empty modelist in probe (2026-10-25 08:57:27 +0100)

----------------------------------------------------------------
more fbdev fixes and cleanups for 7.4-rc1:

- atmel_lcdfb: avoid issues due to empty modelist in probe
- simplify the console-blanking interface

----------------------------------------------------------------
Thomas Zimmermann (7):
      vt: Add con_unblank callback to struct consw
      dummycon: Implement struct consw.con_unblank
      fbcon: Implement struct consw.con_unblank
      newport_con: Implement struct consw.con_unblank
      sticon: Implement struct consw.con_unblank
      vgacon: Implement struct consw.con_unblank
      vt: Remove old-style con_blank

Wang Haoran (1):
      fbdev: atmel_lcdfb: fix list_first_entry() on possibly empty modelist in probe

 drivers/tty/vt/vt.c                 | 11 ++++----
 drivers/video/console/dummycon.c    | 12 ++++++++
 drivers/video/console/newport_con.c | 24 ++++++++--------
 drivers/video/console/sticon.c      | 20 ++++++++------
 drivers/video/console/vgacon.c      | 46 +++++++++++++++++--------------
 drivers/video/fbdev/atmel_lcdfb.c   | 13 +++++++--
 drivers/video/fbdev/core/fbcon.c    | 55 +++++++++++++++++++++++++------------
 include/linux/console.h             | 10 +++++--
 8 files changed, 124 insertions(+), 67 deletions(-)
