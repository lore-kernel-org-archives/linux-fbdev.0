Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3883ED3CA;
	Thu, 13 Aug 2026 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644993; cv=none; b=rIqRcltVKPTcr20XlYmizDdOiAcTIK/62s0ZeE/BlXC8VnhwcBx9jCj1mivfbXHlQdKVrENRjNcjU/hZkCEzHNBbB2PAatm0AvGCXxQ9OsVzVGk6Om6qt0+X4rPn1oFA+K+tbah874JTVsR7fB6rEHr97KvRtKuS7AGgrqHXaYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644993; c=relaxed/simple;
	bh=VK5/3TBcSJDGtsbM+e9PJMUAcTKL0MykzmzlirfD1uk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sTZpcw8MtK2XG+b/cBvYvhvxMqluFcRqCuRRnmjXt0QiDAGcSYfBr3/rAmZIiBEqfJhXBlVIUNv//99nv4wEk9gdNH26aeT6RZDIbyb/DhhLG5uCoQtr7ck0te/Bb0KWTsofxjuRxLdRGScL0FQlkxyfBrq4xaNErbx61Fyu4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 965C792009C; Thu, 13 Aug 2026 20:16:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8FD1992009B;
	Thu, 13 Aug 2026 19:16:30 +0100 (BST)
Date: Thu, 13 Aug 2026 19:16:30 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Helge Deller <deller@gmx.de>
cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
    linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org
Subject: Re: [RFC PATCH] fbdev: maxinefb: fix build issues
In-Reply-To: <81ac11ee-772e-4024-b9e9-6a925344052c@gmx.de>
Message-ID: <alpine.DEB.2.21.2608131914280.48788@angie.orcam.me.uk>
References: <20260809234810.982500-1-rdunlap@infradead.org> <81ac11ee-772e-4024-b9e9-6a925344052c@gmx.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 13 Aug 2026, Helge Deller wrote:

> > This is all ancient source code from the beginning of git time.
> > Now builds cleanly on 32-bit and 64-bit MACH_DECSTATION.
> > 
> I've added the various comments from the mail thread to the
> patch and applied the patch as-is for now.

 Given the statement of the problem as per the quotation above I don't 
think there was a need to fast-track it without giving me a chance to 
chime in.

  Maciej
