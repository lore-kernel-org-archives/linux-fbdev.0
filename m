Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8F545003;
	Thu, 18 Jul 2024 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721328756; cv=none; b=IZqfyBkTu9SqgQQL18577kK0Cm55yd51ufPx6pzG+XhvmkZWArYQCOrttrr/EW1fzFQeinLHt1NbZU5MJpT0u6yq/BP4VBylPVFGjVnOHEU/ublJNcHef7Gpv5Cs/lfIQDqhi8UkYlT6L6qJF8FTYl450qBSt6PDOPR+1JDNr+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721328756; c=relaxed/simple;
	bh=eLYytie5OavnSK9/S/M2BFFGHyOeAhdS3/+1va2/wAk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iqo0gcp7CVZEeTWCZu2cZzs94F3ECldHrjsyrByj/HJ8Ql3RLeG1DfHlF1clfLuZiCnJH64WDQS/l5LtwdMzpOnEKykaJGcxOvD/2gSJ9YEOwfXVHZpKp3zUMqAk+NUVEe0e7Rbx8MMXyf7Sf/NgkpvpuXfILbyY2ZjvD2ovTWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3zuyns0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3zuyns0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F71EC116B1;
	Thu, 18 Jul 2024 18:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721328756;
	bh=eLYytie5OavnSK9/S/M2BFFGHyOeAhdS3/+1va2/wAk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P3zuyns0aDScdwrMYXul8/JmoujKRydt3d8TV3m8Vdiu7ZR8reeLcWo9ir66gOvGx
	 XHez0vKztLoTPX5Bqoh1z5OCyjRXAEL9E2DrH9cFh5w5qH1DkYosVftXihbwNxhPrl
	 jwHcE9aCXWYTRoU0vx4ok3b1ggsP5o+w4mCfDL7teNyt8qUba8X6U2HDFnZGDUz83o
	 SorghyCRCHYhyQlQKosIWCLotINhNOJNqqDvMv4gL+r5qIgQm4Bi3lrr2PyeBf5B1o
	 JHAo2jDsEKNbVy/CQlz5Oxqq5UKXN0LJbo3Icm96tdKU85XKpW4IOI6MBWKTpmEIOd
	 gIYMtk3jprTkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A466C433E9;
	Thu, 18 Jul 2024 18:52:36 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and cleanups for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zpk7E3ZBlh2UdXy2@carbonx1>
References: <Zpk7E3ZBlh2UdXy2@carbonx1>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zpk7E3ZBlh2UdXy2@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.11-rc1
X-PR-Tracked-Commit-Id: 8b5ea9029b03efda74292c57e0377a98ed0b7434
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb273eb7c8390c70a484db6c79a797e377db09b5
Message-Id: <172132875636.1632.11308126601806645460.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 18:52:36 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jul 2024 17:56:03 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb273eb7c8390c70a484db6c79a797e377db09b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
