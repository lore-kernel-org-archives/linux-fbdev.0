Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1FC418A35;
	Sat,  8 Aug 2026 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786200734; cv=none; b=o47pg/5BBX2eUCZ3XS/LNDZNRTOFh/S3SM+TyAjs7Kvhc+5Dn92D9hVMpcMnvvTTVeJYywAEGh3PblD+fuOkjTj/F4YHC9KMY6HtrUX7iBoTIpX5CNeXWGnVI4mfzGFxSy7YJmFDl5cQn05Dgvo2rbQ1+LXdH7StNjhE99g/DHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786200734; c=relaxed/simple;
	bh=0F31cbrBWIZ5SQQi3N0MizULuKISlTPZ2SiM2zQtLrc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XBGNFvzTgqrB/+A7ImTjruMgC6wv3KbgT2/DfcATEm4CzQDNngkbEGnGll14OvA/05OArBHupso9x3ieDHAmhkZeYNEcD42JNqih79UIu2zhyeJ1OLKNeo9L3GNEkivAOscWj4eoXE2YUwODL8hWyOehVb5nkmkYi+LoX9XvAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsMV3ewK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsMV3ewK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C01A1F000E9;
	Sat,  8 Aug 2026 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786200732;
	bh=JXGRGi0cBLAHZ0vB2PEtYx3AOux4VBAjL8eG0OhesT4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=EsMV3ewKso9gXvhHRdMRu+1741OrYveoTBfwzajrkXY2bJx+/TBspcbxLA75yWFcB
	 VWvCZfVw8zD8+nYsNKgxCyB6fDqWbUTeoF1Y/kOFC3pbpEmBb105yC23eM7+eaQluY
	 qS9uoqeYN8oEPam0nXZ/80hea/t63fBl3fFvxR+QEYEdeo7ia2xCLZf9Z92Rp0V4dY
	 gYvZzJ2zKDBjymyHO97UUkmWgdpCY3dduW7rsXQoX6/VfXeLRUWDXznrIl/dTGOg3a
	 P8zTE1h5P1SuaElGvYzbJHGf58u0iPBwJySSfHosKppviHiE5wieIFqv4lM/Hq8Oay
	 7NqK6gNIOWXAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0ABA380CFEA;
	Sat,  8 Aug 2026 14:51:31 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes for v7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <anc0HhpSwT_c7CTg@carbonx1>
References: <anc0HhpSwT_c7CTg@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <anc0HhpSwT_c7CTg@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.2-rc7
X-PR-Tracked-Commit-Id: e033cbf3975a8465f879ebd5989dc35b04423a4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7c7074b58d28c4206d666a12aa2e33447b3c581
Message-Id: <178620069055.2671154.551609346497003543.pr-tracker-bot@kernel.org>
Date: Sat, 08 Aug 2026 14:51:30 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 8 Aug 2026 15:50:22 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7c7074b58d28c4206d666a12aa2e33447b3c581

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
