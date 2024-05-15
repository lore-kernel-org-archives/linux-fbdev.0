Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573B38DE9;
	Wed, 15 May 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793608; cv=none; b=YAM2080RH+xjkTiQPdfK8+NG9t31BxU6Oup2xt377hbPZfjTCgASBK8KYFxC/MQBZgTcNr27GfJ0UoAj9hesgA0BVw/DPc28pEg6v+GYnKsc3ZZcqd1eF3OVOxkoD9EL8QGpwNmAGggvVnlA9GLwG2ud6aq9MMwIju6dRz2OOqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793608; c=relaxed/simple;
	bh=PDCAtBJJsZQWI8/lbOPR4SI5lHA/YI+4rWdxytXXhOU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EaFFHMSvjlg+QVvrBg8GXcdF8Pfpa259ITlJxRvRqzzpIi3oBdhla+QNByTZJRGShHcMzXOygSl3ybgw/gag2kqF/cQ5SM46pL36CN1kAKpaQE1a1DFChiDPZ4rllRVyEy2Ut9Fl0kWs2AJhBnnYzYSzk8N0kA04ApnZkhhJAQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgkRZbAX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgkRZbAX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A67DDC32781;
	Wed, 15 May 2024 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715793608;
	bh=PDCAtBJJsZQWI8/lbOPR4SI5lHA/YI+4rWdxytXXhOU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JgkRZbAX4kvSb7xoc+rJJ0TMuV4TlT++0qO92dvZfePlL/6cX9Avk9ZQj8CtQKzld
	 C5Q+zI/zQ1OT9Fed8fPjDzmb1o0+G8Q+SYdy2CAfdhy7YMV3X0VL0RBKqpiTbvAa0b
	 E+3s7oO3FD30PmCx6JjkR/rIs+Rp52Mqgx3BrQdYpGXd5GKvbaDBRi9wTN+mkMU8Ul
	 ufplTTEqh7E84Zz19fCi2t9HjxOyQQOne0eFFjSsl0ZnucNBDIDAH5nHlTEGxYxT4d
	 1ws3GKYJLrv6TkK/cV4ASgrUg8bM6/D4/ADnGVjwI5cAhjvnCqxm8uqEdjEVZE0lpZ
	 zrGardYxftOEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91FADC43332;
	Wed, 15 May 2024 17:20:08 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and cleanups for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkTQ9JoGXFwuMzZS@carbonx1>
References: <ZkTQ9JoGXFwuMzZS@carbonx1>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkTQ9JoGXFwuMzZS@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.10-rc1
X-PR-Tracked-Commit-Id: ce4a7ae84a58b9f33aae8d6c769b3c94f3d5ce76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d34672777da3ea919e8adb0670ab91ddadf7dea0
Message-Id: <171579360857.17791.12648387199973228616.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 17:20:08 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 15 May 2024 17:12:52 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d34672777da3ea919e8adb0670ab91ddadf7dea0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
