Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B2174EFA;
	Sat, 28 Sep 2024 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727541912; cv=none; b=aL9b4wO9GhrL7tvLILHgTyiJl6MyIVqf3m8kMTVJIHAijX6h/4nkJb+5isffv5ySIyKWu3h7glg3CqXyksd3ke6CHszmayeKtwvBTRVUtThsQyaJoCx+Y597TTQdZRqL8iTCRPktA9L8E4nS99qHGBKDeAWnGBkq2mgfvqkh3/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727541912; c=relaxed/simple;
	bh=KeVe+PMFx3Hc/WeSruzNM5szsYAxL/6EfsQiRJE5kfA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VKsZ2p80j2j+5nZOuKUrbTkRktvKVHj+muqISrxNPEtAx5Q4oE6PnagoY0AU347JTonnzD6PTUhr2l1NuxUPQszdVKauA4M3PHbRGDvtv7/QxNx/bprdfOAvIQG+hqWoXl0Q+KCYqW4XkbBvdd4w2EA1LJX0FrwH1O4OJEaKEyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRONPYY2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRONPYY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B944C4CEC7;
	Sat, 28 Sep 2024 16:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727541912;
	bh=KeVe+PMFx3Hc/WeSruzNM5szsYAxL/6EfsQiRJE5kfA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZRONPYY2K3LZxq5N5MzxRudoGl2cmqfU9NM1G2DRpu4XXMHsiA8q7CVdy2l//3H8V
	 SYAG1lyefSN6Y5RObZTMv08IMGpXray2bzAMWiKe/FhnYs8sGM42Awcpl8Bpf8FOKn
	 5EbzDT1Q/971XPn/Gk6xMB62JVT1KUxEVIa/RUcSEfQjOAZUyb9yjTWWZSixibXs++
	 kclzByGRw/QJikiUfY6kCRN8bj33edJvmaWqRnejHXmOCKYlLM6pwTt1dqHlq8KKnD
	 tchQ03DIdrokFRgWY5lXtQRFXIVarludCA5XWbIXN0/W4Hd+0RaKrwW3SG0C50b8Rq
	 Pob0p+44Qkwmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EBC3809A80;
	Sat, 28 Sep 2024 16:45:16 +0000 (UTC)
Subject: Re: [GIT PULL] additional fbdev fixes for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZvfoRGNbTUOzLL9X@carbonx1>
References: <ZvfoRGNbTUOzLL9X@carbonx1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZvfoRGNbTUOzLL9X@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.12-rc1-2
X-PR-Tracked-Commit-Id: 9cf14f5a2746c19455ce9cb44341b5527b5e19c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f95c139099f8dad235191caec9e9268ca717beb9
Message-Id: <172754191479.2302262.4145148096064377606.pr-tracker-bot@kernel.org>
Date: Sat, 28 Sep 2024 16:45:14 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 28 Sep 2024 13:28:04 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.12-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f95c139099f8dad235191caec9e9268ca717beb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
