Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721363264C2;
	Tue,  5 May 2026 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025402; cv=none; b=MWjKotOt7qJ0nxuiZ5/P5/Be5ijo2U+1VVzAJowi8r5VwAlQxeOx8tkUL0sKJPg+YKu6+2s8nY0YDD59B4leYH+WnM26gSpIY8lN+heNzk3oqHWM6U0t2AEg6xKieyUC4Rjj3JaaOPS9OJQDzWbqzNz/CGBiDBAnplHCs5soTzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025402; c=relaxed/simple;
	bh=SKxPzwOs2LUU6XS+S+cwge8LKnZfV+kTiCd5PwTtSI8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Swz8VFXXL1XYxrKXO4wAhamVdqH8cFEs6lKR5bwoUeH8aYPxr5MGV+2Y5wKMo7yPtiAB5BVkCf7HGVKyRfDBX1dYAbVn/5bBjLm3QxnotQInHtPS/7I4AYhpvj9Cxq2dpqsPeoELqDb535ff+GlMRsNL6+UCqCPTRyTlmv6r17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WadBA/rB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WadBA/rB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56117C2BCB4;
	Tue,  5 May 2026 23:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778025402;
	bh=SKxPzwOs2LUU6XS+S+cwge8LKnZfV+kTiCd5PwTtSI8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WadBA/rBzHYS46Pec0DntriiezSHraNm6KxHDixqZSe/fu3WK+UIJqXHmDyIJn4PL
	 xKE/Q2jqJzyNDNzIVKp5q+gskYTP7e1nn5JKe560rFGASnisTaujcscUHoZRC2m/AW
	 S9J71ns2z0tPbg+SEH6sv4aGPCjWjIk+vKLQ2tEIcLXCPTcpA698oTFJb5rB5opPCS
	 5Fw7bbYXoXAst9aaOTN3HDl32HDaGF5Dt1kiX+01UWng/20yFf/KOwgrxnG4rdQZS+
	 Z/zFQPz35V0JEMHSDe3fIEmdPgMhLq6iv+1qgCHM/L3u+3NsopOsmAkje17ze2HWTR
	 eQR1SVpLzIBig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FE439302FF;
	Tue,  5 May 2026 23:55:53 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v7.1-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <afpYkddCLxIsicwb@carbonx1>
References: <afpYkddCLxIsicwb@carbonx1>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <afpYkddCLxIsicwb@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.1-rc3
X-PR-Tracked-Commit-Id: 8de779dc40d35d39fa07387b6f921eb11df0f511
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13ad98eaabef611f042d49a9077be060ad03284d
Message-Id: <177802535232.2314843.2129849224623926149.pr-tracker-bot@kernel.org>
Date: Tue, 05 May 2026 23:55:52 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 5 May 2026 22:52:33 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13ad98eaabef611f042d49a9077be060ad03284d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
