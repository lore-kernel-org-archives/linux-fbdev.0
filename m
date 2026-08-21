Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E93603C2;
	Fri, 21 Aug 2026 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331394; cv=none; b=F9E1XjyFZLdWBqjcnxFNceGjFKDYbCeDKtb6DK3TK4pQUjfWXfSwgX+ZTgd5+TTpr8Y1rCJOramVYrhwcOSU/mE0VGwr3BdWw3I2AKhC9+T3hx3Th40FkZIbaTsmE84bt6GFqVBWN1Y3gz2FovlH8JkJbynmS9v91ED5rEtbj+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331394; c=relaxed/simple;
	bh=1VJrhM6rFC7EbfomiawKNjSdR9+WgFXfwlzPwDScouw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pPdLZxEcG74abMZyFRgfldX5/T1nGBC0FuywKFwjexCJaSaQ5DV0cHyvJwua6NpW/SRZ/2batDftFiK+LGFfr3vTAUJRS+7xIzku2hROc3HfNaONjGvCQFp7fsOxNtOhj6l2DOfEG5c/hSpotK2aGXB6RUVPh9qPhIQrJ/6z7N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HME5CV05; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HME5CV05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4650F1F000E9;
	Fri, 21 Aug 2026 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787331393;
	bh=LU6lUdJZu7Xg+V0AStShUedGkhyFT7zl6U/m5ST954I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=HME5CV05j3WUvoBpTjWHslotu8f4QngXMecLV3FIXhDaHKL8rEQ4G3tslTU9pBmi0
	 SUKYZZD7nhxBsmQkgrIPz7qfuM1XCX4pD1pzjQKGjRMR+jB+YkNFHSTgVd6injzPqI
	 VFUCYkLJX7k19RDilHMO17u5Lo9P8eyPFEUblt9FbWwGfqrP3fkM5ecWGLVzXd3dNi
	 2HHEmsM0t3q9y4xFuTAxNxnBX1kTXy1w6niI9548pdrTnYFEVzTSJP4FGyeIxlJwR3
	 6f0ft4r788F4bH//lLFcgrT/ymc7wsEW1KFdca6RMGbkYXagNtyxj8feYj3B5lpuW8
	 3OBosucenbYrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AD1380AA76;
	Fri, 21 Aug 2026 16:55:44 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aoh0QXTIQbgDjAB_@carbonx1>
References: <aoh0QXTIQbgDjAB_@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <aoh0QXTIQbgDjAB_@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.3-rc1
X-PR-Tracked-Commit-Id: d463633d63e6aa10384683bf39971a4b00780c56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 531ed942bb0df04f6747983fecdedce76a22d07f
Message-Id: <178733134265.1393585.15591611200509777280.pr-tracker-bot@kernel.org>
Date: Fri, 21 Aug 2026 16:55:42 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Aug 2026 17:52:33 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/531ed942bb0df04f6747983fecdedce76a22d07f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
