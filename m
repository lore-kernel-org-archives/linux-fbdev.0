Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792907439;
	b=y1y75ksT45sLaDYZNwBz2j6D1Cs84aXvxNqxp8OlfFqtjX7YpRw6YzA1/44+O1wr4D4t
	 +tdiJamYvrKShkesBumE7gTAsrl2d+uGB03tYxEWP0KXA0L4PXB4/+xsVfgB4v3TFu/HZ
	 udO5CzH4u02YDxps2CyqGcT0wv0e51RSYg/z/Yghm2RsKbT4wPAUH4MoUT/jyGOxjxrDJ
	 cHAyDDVD84WqqEc6t0rwJBz8iXtTv6KXNUnEP9JsHsOEb5HHYr7n0UnvVf9ToQKAQSpmx
	 YMGlDacaUqtVNIg9DmB3Ec6iWdi3aGrqvjT2SWlzsNz4fKfY9P4cfFeWH41QyDysJxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792907439;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=6zElpvh8J3K9HT4cCQP7Rv5mxb8/Eqdt7hOMmMt8fCU=;
	b=YZ/hjkJmQJb03GwHHFh9Xtbgo5rNwEX8N19HRMSm301fQ9mTuUVMbtAZlO1qKL7Exl+m
	 zuw+Nmn2CnJr9Wq6mV4OV55hJ1+mT2yTN7mQrVNiyHE82+M7hU8ljjfMkJoUMLLF2saiy
	 dOu+Xnl+WStN7dGcps3+F3sf7ud+gPicwi3/KUDWcAV3Hew00ucIOpLrGJilYqqmT4X1E
	 U0LiqYFdc0Eze8/Rf1SuIspkgH8bjeh8IXPmtmwpI1osQediIQefVr/8AaeA5sAnz4MQt
	 9VDX0uVQh7qQtSPzAnGHI/WnVv93M+nKFiek6Tk4hGm9eHlVTCxExkjU4ThSbQ6xynQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWfQLN+P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE2E606A335;
	Sun, 25 Oct 2026 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWfQLN+P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0850B1F01825;
	Sun, 25 Oct 2026 05:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792907439;
	bh=6zElpvh8J3K9HT4cCQP7Rv5mxb8/Eqdt7hOMmMt8fCU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=FWfQLN+PCTMgOJ+zcHsSHwpWPLUHBFtAaazkx3/Jr/+MN+e0KOL1+iaVyCGrw+Akd
	 SX+F4vULnITOppPkwO8STFrq7l4G3tGrFx57XMxphJZezkPBSBgKDAce9aQ8u2+j4e
	 2Y1OBq6R/T8vtVQzybqWcq7NO2LUz9+Lq4PnAZcGzmZY/aUnVYxae++jbfwuaYGhUG
	 Amjrjh42BBT8B3g/pKZYjH+YKfuo+dGoe/SOiQsNoQKyurQo5+VzsMsVNdgO0zIk4K
	 VM1PBkZDoYdtgvAOZ4JcE34c/JG5HKKRTM3mDXRbvg3SqdWEtkqL30WqZMaiuWkh0F
	 bkgvWlWD6tTmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1F9D392ED67;
	Sun, 25 Oct 2026 05:50:38 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <atp9GlM3gE8uF0xo@carbonx1>
References: <atp9GlM3gE8uF0xo@carbonx1>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <atp9GlM3gE8uF0xo@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.4-rc1
X-PR-Tracked-Commit-Id: 61e1a43ca5825acb137a10ac7d52746632bfb124
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dfc0090b925243490b5b71bc9a229517cda499a
Message-Id: <179290743751.1990210.1431048982093416527.pr-tracker-bot@kernel.org>
Date: Sun, 25 Oct 2026 05:50:37 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Thu, 22 Oct 2026 23:16:10 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dfc0090b925243490b5b71bc9a229517cda499a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
