Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0F480604;
	Fri, 10 Oct 2025 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120756; cv=none; b=iFRaf92R25a54zOM+Sa6FHcWkF/gjcCXc02aa2yJBPhvlwqfQLgDW6BtRK60/nUI+cReKirR3tJB5+gSb37ilbz4OsgOGdMg1MJkzz+nY8xBDLZQ3SquJCdEDpJvfpbKoBmy6PkeZzsvq2jUcizhGx7MZ13SG1YinZrGUe7KmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120756; c=relaxed/simple;
	bh=y8fzFnlKunWEVat2RXlybSvQtyQAeDPzKvb7bm0YiXc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FuZThfgr4SaECO1r+O3M2hazehjD6hFWR9H/bEmhwFfY5/KUaynTk+g76mKRSsvaeQm+376nfTN6L2xqOb8eE7+T1u/BV/1RA1tZq3N9jDsbQTqzJ+KA8obDhxD4tX75nimhlmLyhGx+ffSgdolGXjiVvj5KhH0WpQTowyzIwaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6O+yOmO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6O+yOmO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63A2C4CEF1;
	Fri, 10 Oct 2025 18:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760120755;
	bh=y8fzFnlKunWEVat2RXlybSvQtyQAeDPzKvb7bm0YiXc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=l6O+yOmOKx4iHMva2BFIJpVqz9f3UwLpP4446+ygYKeVWVCFtxZJyDvF8Tieptphl
	 WSjTpFlMTuMcg59J9+UwUnJj7lBiImyUAuHiJWz1PPhEbQppzZuEfKMjD4djiedEcI
	 fLPbr+eHQlaOwguOTe2WYKYra4frWWi/m1qex0QQp0H0QJIiVVqJfT9OusDpWp3BIp
	 ADVFZD+s9UFtoBoYhYOL0j6WdU5XMFxTl5MsQMpzR7hGgkAsLLhTWFh2wFe6Fp0Zu+
	 Q2DJ42Cl1MyzJrSEEPHBIR+zzLpoMvlFEdroAVYvr8tRbJebwtD/VpObZTcwJjzVU6
	 8bNR/AhpLa9rA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB03809A00;
	Fri, 10 Oct 2025 18:25:44 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev updates for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOkKroU5EAorYET0@carbonx1>
References: <aOkKroU5EAorYET0@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <aOkKroU5EAorYET0@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.18-rc1
X-PR-Tracked-Commit-Id: 15df28699b28d6b49dc305040c4e26a9553df07a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06a88f47990974f1322c2bf2e8c5125f8a2f69fe
Message-Id: <176012074303.1074429.6013388198844623304.pr-tracker-bot@kernel.org>
Date: Fri, 10 Oct 2025 18:25:43 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Oct 2025 15:31:26 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06a88f47990974f1322c2bf2e8c5125f8a2f69fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
