Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9486E64AA4;
	Mon, 17 Aug 2026 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985839; cv=none; b=jq0XJryY813mBQidXCbsbP4C7JlNMBymhmo3F2oYIsPjm3/b96ik2SsHf3XiaRLu3S9+DdvkoGBkhK1eg9JkqhFmV0UwEHE6udJw0/8X9NQtXz3fs+La6Jaa/OhPwfR1GdyDly4ADqMeu3HTuDgLHY0KGItqODclmMLWVW5Eo+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985839; c=relaxed/simple;
	bh=m0WYkPzsy+yFZDxNBbum2csXhcStKDqzw2krKbqI+q0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oXWqZgPbvd5Xp80h3oHFoAPqjyMtHKm92FZyR3nd6qXEGy2dNtVwMpCBpivN4hmTnP952MW4Xg6dMD3p4vxxRMQStzz+4nQDAIqriaQsEDhkKiIf9Rd6A60TOOATEhXkTWauSksQ7A+vwHktLFPUm+r0cqrd1J690CZrGDLZsS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 6E3D39200C0; Mon, 17 Aug 2026 18:57:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 6A8FD9200BB;
	Mon, 17 Aug 2026 17:57:16 +0100 (BST)
Date: Mon, 17 Aug 2026 17:57:16 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Randy Dunlap <rdunlap@infradead.org>
cc: linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>, 
    linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 02/03] fbdev: maxine: elide an unused function
In-Reply-To: <20260813232934.2718291-3-rdunlap@infradead.org>
Message-ID: <alpine.DEB.2.21.2608171757050.14132@angie.orcam.me.uk>
References: <20260813232934.2718291-1-rdunlap@infradead.org> <20260813232934.2718291-3-rdunlap@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 13 Aug 2026, Randy Dunlap wrote:

> maxinefb_ims332_read_register() is not used, but since it describes a
> hardware interface, leave it in the source file as documentation
> and surround it inside an #if 0/#endif block.

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej
