Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A4564AA4;
	Mon, 17 Aug 2026 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985829; cv=none; b=tk9OdwrhfnDreZo3OvtDnR5w/JVBWZyoifY6NJy53pH956SnNFR237AOlxLv8Kb/qzfSre/EO6kc2kW/2aA6AeDEfnr8hBq4/Q9QvFg0tzfmWXF+R8VQ/yx0fvk0g/oa8NweMXVanDD5KmpgwcyMFXAG+4eOz56N/RHr3gRUNbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985829; c=relaxed/simple;
	bh=GFOGTnhZHgvQe4DabpQYn7wg7hTbUQqYQ3ici+phaME=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BMoqivh6Eg7zLPiy6sjg+fSofV7WjmBwAgexD36m4jnkH90nkfXyMTCKk8Ug/jkSEYFqnnR5YFDTpKjLcJnHoER+AbiIJCpUjUvHeLOrRE0CL3X44qqy+nsydxwFPbCLWN+D0K9mMRF6FJLfsMJn6VN1t07DWAufdOMEGBH5uM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 4B9589200C0; Mon, 17 Aug 2026 18:56:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 448929200BB;
	Mon, 17 Aug 2026 17:56:59 +0100 (BST)
Date: Mon, 17 Aug 2026 17:56:59 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Randy Dunlap <rdunlap@infradead.org>
cc: linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>, 
    linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 01/03] fbdev: maxine: make functions static
In-Reply-To: <20260813232934.2718291-2-rdunlap@infradead.org>
Message-ID: <alpine.DEB.2.21.2608171756000.14132@angie.orcam.me.uk>
References: <20260813232934.2718291-1-rdunlap@infradead.org> <20260813232934.2718291-2-rdunlap@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 13 Aug 2026, Randy Dunlap wrote:

> Make 3 functions static so that they don't need to be declared in a
> header file.

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej
