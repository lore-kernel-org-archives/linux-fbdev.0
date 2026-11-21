Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295089;
	b=hR9RYUh9eLkSDEbr43Oje1bviAjJ/HxPIsK8p9cVGT/SV7afpBM6jUUoRbRTJt2O+Rsa
	 PAhOaeq+qkYr2TpJr8OVAwWnNecm+66kxoI6+rtQWAcvvWj8+UEwWZhAeFDHIaE11cmhy
	 SKmitj9ifME7xXL1CCXq20LG9OdyzsAyAaIXYQvT3I+fgQ7wk381w7/OpfH1NbRITaN97
	 g/6/m+ADcmfQtMSK1oiJL+nIJU0Qj532BkVr66+56Jx+Y6u73aQ6ZtvKpMFy/GLi1800R
	 Jw/tTtlaNf5qqlRMqHvHQczyCJkgmmwF2cV6kdBl+PwtBobAo1ZhdaDKvfhrdjb7jqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295089;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=Vt8j/LEi+gro6jjA3C2ASZ8pFvBafd4tHh6w1o5tRpE=;
	b=kc9iWvVv16vr+DSHod685Y7CjOwNEBjmSj/LdnnGcyn5EwKrg0CVyJerc6+SootJq27L
	 BAhbdM374zZ311ZETcStUU3ogQ00CbyLnvOwr1vIw7J5rvQOImOOrmPoY2/OcMzwagOPY
	 2KiJJerlyDNxcQzz2TIOp3jvhnJO3PlSpW3GUOByiEVrMgwoa96eepRt3YDXwaUBznE3P
	 kqPK3UdW5L2vc0DsbzymIWKANyfg2ExH/E7pHOA+QGn8TgoMee9A98d9/kiElmIXGC9KQ
	 xXaUdBGtxNG8c8DpIoXERcWr7KbsPzkc0A2FmyM3HsUI5B7niUletdgoOPcKbN6rSyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MN0R0IRT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C49606A320;
	Sat, 21 Nov 2026 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MN0R0IRT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47E81F000C0;
	Sat, 21 Nov 2026 21:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795295088;
	bh=Vt8j/LEi+gro6jjA3C2ASZ8pFvBafd4tHh6w1o5tRpE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=MN0R0IRTPiYb4q+rpKf7cdImXk0+IfSjzTnEbGDHlcceSOHtUo1nut+EeC/2a+900
	 D/RK6fqgXjNaNw4jb/AVm+lyo0QQWe5xtzE32MGXxnVGBTfPYsOSNAGCtB6cYG4uH/
	 WnqgaBCQZePmmMc5hj0dVGBVrJ9pPY99fP7o0qaZEFv3NR8Cd6U4qJazwu0+ygm8OY
	 Ap6Or2rezG/eRcjBLbTupPbD0Hre0XqouHFpiPGpCGP1BzAmAZa/kQEegENWChKL0f
	 XVicgLf5r2glnA0olGCR6hxoaNKiz2m5wjH096AnWB4/TZcP8kaiOvX/mKUys1FQCH
	 BZj3DoWmNN0TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B49F2391B072;
	Sat, 21 Nov 2026 21:04:48 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes for v7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <awHOB8hdCRXVd--I@carbonx1>
References: <awHOB8hdCRXVd--I@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <awHOB8hdCRXVd--I@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.4-rc4
X-PR-Tracked-Commit-Id: b3f1631d362539cfe14571ccfd7db919ffbc08c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1cc4be7687a058ecbe2b6178034a70b76e07e92
Message-Id: <179529508731.1171121.9376332317068027929.pr-tracker-bot@kernel.org>
Date: Sat, 21 Nov 2026 21:04:47 +0000
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

The pull request you sent on Sat, 21 Nov 2026 17:59:51 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1cc4be7687a058ecbe2b6178034a70b76e07e92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
