Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383232;
	b=E/ZUjA5sED5TDELcQEmPciNJlbP+jTVSp3eMwQmWRkDnMc0tTeJvhIivgTvh7FMh91mP
	 RgnLhl6kzzmRk0lGRIg5QAESoWcgoPDXEPpu0SDMeTQMT8STLopn3z8CB3WJn4l+GIeB+
	 1gsgh8GTM7rf8M6kXPtIj92J47vuK6ESr1t6Lb67Nr5WJhVORoTTPwfHVf+0cvuGY/4XE
	 0ASy42U+Gub9aQHTZ3ydurHn9f94NOwK7irSS95PJonL40lxtqNtTOTjUuoODvIa3/Unj
	 usXcTANumq4qNUonPGxX5uHovi0GwvZ27w6Mt4H4ogaEpVfdirq4b9pTW2WlLBhN+ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383232;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=arldDgIN+DCbRWttC/pNZKTNCd0fMgl+I3NlSIduriw=;
	b=nWyT/sig3UuwYK9HLcJC7vY+oui8DWPAw4JZaCdiv9RDe3HVMgdq6cugzndvghmveImO
	 85aU8RW6YzUApujiNR9YLj9YVdvIakqqM3XaOnb4F2FqBn14IcpgmB40GJ0gtK21vbC4w
	 MTpaOyWwuVxWa86L2ma4MP+lMaH7BgK7h7K+yNfa4r/mLPUEvlx01WiczsMy+FVZDB+QY
	 LHNafgAJOIuXfaGLBFD29bfNsQbl48NmYm6aRlddTKDbEwCa9aMz0yeebk0okQftapxL9
	 d68lXWaikBsWCGJMF/4bupvfGnsHTzpJ1hikDGrxGOa4Y09SIcEeX5CiWT/4yuSxXAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJhpEMme;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2353606A33C;
	Fri, 30 Oct 2026 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJhpEMme
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0441F00A1C;
	Fri, 30 Oct 2026 18:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793383231;
	bh=arldDgIN+DCbRWttC/pNZKTNCd0fMgl+I3NlSIduriw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=jJhpEMmeqXC0RcZsXl7WFapgrUzaX9VYlBMmNTjFqSrtS738L6LLpmt+ewFzcgoF7
	 XZzgp54Pipn0MHA17YnDEQmYNYN0vQEKIOzePveG2XPy0h9UgnKcqSu+QZgHloqFQ+
	 2DNj/T/HcDHQX+WfQMcCVE/drS5eRUMg6B3f+Ckr3Xszp0ij/xHqpYJ2fte3n18f7t
	 lOTi8vJyrpYt1Pe4gzbzts0BPtWk7sZh5OVJFPGyD9jaMSUy8Slad+qoNqe9Nj5Pql
	 R9yeNFLIrfAQV0RwBTrOWxFR4rZjhd/TTFiyhlMM7L3YT/dJX/PHKU87ElwZI57Q/W
	 gLZ8beaGSe6qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C3D7C3800471;
	Fri, 30 Oct 2026 18:00:31 +0000 (UTC)
Subject: Re: [GIT PULL] more fbdev fixes and updates for v7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <auPJLXQdFRtkoOCu@carbonx1>
References: <auPJLXQdFRtkoOCu@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <auPJLXQdFRtkoOCu@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.4-rc1-2
X-PR-Tracked-Commit-Id: 01d1204582f16e8b7bfce29648e5cf77a585d962
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67f1f9b38c15b54d257a1efc544873b53905737f
Message-Id: <179338323067.1671436.4542824899544592054.pr-tracker-bot@kernel.org>
Date: Fri, 30 Oct 2026 18:00:30 +0000
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

The pull request you sent on Thu, 29 Oct 2026 23:31:09 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.4-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67f1f9b38c15b54d257a1efc544873b53905737f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
