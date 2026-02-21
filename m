Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6719A215F7D;
	Sat, 21 Feb 2026 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771636798; cv=none; b=TpYX+vafzo2tbD9CcRQFd+wTEknLAePO0PfBYLZI1N6rAUMadNhAqVoRiOqPV+gZe0+Cu983VCNXxUQaonzAtpB49lXQePZ2getwiEeU8Sgrs1Ix+8ASSJEHdRtrh2iU6YnBeuU6JSNvZy2Obzr8Az+AKt/WJbyOSzPeE0TK9K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771636798; c=relaxed/simple;
	bh=L55pkzbw5lu9jxdcZyXCb1sHIAJ3NpLJRa/SrJivsmo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A0eZLw7pS3n0KA1GDqZk8qp7yPWFXyUtM1eYNv50cxkvSo3XmaUFKmGvnTCIsqNtzi+nttlh9+k2T80jcYvDdmwz7GBJJPLbZYUCUrDU2cnpiyG0FHQNtcOdu4QIx+Vzz+m/NG1HCcjWS3IXhMi0LIxbx8HHWnKgiI/C95afy9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwp9vkrq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwp9vkrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32A5C116C6;
	Sat, 21 Feb 2026 01:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771636797;
	bh=L55pkzbw5lu9jxdcZyXCb1sHIAJ3NpLJRa/SrJivsmo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uwp9vkrq1hTpgynRBmVEeKreN8Zr0178cQgjU9qx+fo2azNNaRUp9cdKH9mdAvwg0
	 W6QbMLxF6nZ+9I+hx8NWiysggcdhDYcX5Wzv3TBaIS5Wf8LgRrxtVp7ZenPwwup+4D
	 GaQYhgjYngUBEdd0M3mGJlR50jceLbWrONJLjZSfL2B8+1mJDtGbbWXXudj+15XnkC
	 a3cAkxK96pzpYhKX5wZK+VRLLJnKeYH41GP1OtulI7bIKPKn+cxW01Syc35/MKbRGO
	 fHu40aTExom3lM2D9Spb6TcYt6ehm6Ish/94FY7ALYAN70WbpN4DLbXGaM88YkmwIP
	 wBEdHc6D2VSVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 033B13808200;
	Sat, 21 Feb 2026 01:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] au1100fb fbdev updates for v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aZgSDyT2VcYM4R_Z@carbonx1>
References: <aZgSDyT2VcYM4R_Z@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <aZgSDyT2VcYM4R_Z@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.0-rc1-2
X-PR-Tracked-Commit-Id: 0f967cb8ea04486953f85b249b42dda3de842053
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eee3666c92406fd8e5e3084b0b3129528dfe9557
Message-Id: <177163680550.969912.2742665400454037648.pr-tracker-bot@kernel.org>
Date: Sat, 21 Feb 2026 01:20:05 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Feb 2026 08:49:35 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.0-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eee3666c92406fd8e5e3084b0b3129528dfe9557

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
