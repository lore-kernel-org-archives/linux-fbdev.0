Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E557175A81;
	Sat, 13 Jun 2026 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781337266; cv=none; b=jRCHTHM89rczHNcxVzTG6hvxAfAZoIaVc+eN6CKM6ekM33Xfu9+auo5gLRlqxhk/JrejlNlbvyJaAiqdZVOLbao+q9UOJxZLvPKIGva6Uqk6Badf3m5poTOwdkzUtkCPbzCq2ne7rJametpRyDU0uaxpkk9b3w8G2hOp0fX9CK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781337266; c=relaxed/simple;
	bh=I7TM6p7Jd+LMycfsbvG9o53bN+61uM7hWmSeH706uGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNCqJ9FkpmZfMZWU3/c4jDhfFIQ8IA8uxTonui3S+qsO10IjQglg8OaFF1nVJ7ZVtOngoGtyEHMHS9BXu3hcwwdxP+rQNXW5yV9vfuRSeFjvPIiqr/iJdbHmtNlZRL/eyOqFV0InDzZkDfIjYehL3+Z9kJuvjSiQcsqAYlx//r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t1JQej0W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t1JQej0W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jKr6D0QomrXndRUM0kTG+EY+S4tjgLHhIqD9NsgnK+8=; b=t1JQej0WP+uA8ctP2eqhWVi1Is
	LeuVqI1nI9iXHR4N/INYtri+j+tIdmlqT4EkBrOU3Ce1Em93h+QmJJbRKjwrY5demAueHPaxODGZR
	cYJ8Kz2w+JQ05eZcbqQGQhCSMyq2adyC36CpTQ+s4EzOGjaG492rjErQubowflSnI2xE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wYJC4-007RtV-20; Sat, 13 Jun 2026 09:54:16 +0200
Date: Sat, 13 Jun 2026 09:54:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gabriel Ramos Barbosa Mota <maguraa53@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, deller@gmx.de,
	fero@drama.obuda.kando.hu, netdev@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: net and video: remove legacy 16-bit and non-x86
 hardware drivers
Message-ID: <d66c7e93-b39a-4e79-b047-528e094b51d6@lunn.ch>
References: <20260613033138.601841-1-maguraa53@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613033138.601841-1-maguraa53@gmail.com>

You need to commit message to justify why these should be removed.

Also, please remove each driver one by one, so that if there are
users, it is easier to revert.

Please also look at the discussion about these MAC drivers over the
last couple of months. We discussed removing some of them, but they
still have users, and one of them gained a new Maintainer.

    Andrew

---
pw-bot: cr
