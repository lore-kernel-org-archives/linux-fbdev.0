Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7F7466B5D;
	Mon, 17 Aug 2026 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986591; cv=none; b=hJPvky35sbD7nzAbPEk9TVlSnnsFOBHpKQPjsfXHpcUlXZ5o11vRLZbKyf+HnrijlzxtX4LZNzDchdI3kNdOPam8bRpzyZEvYLevA/pWd0LDgr1/4DERgJ2fjdslUPKXKbydac/tdzDv0JNna0eIXAnmMT1FtthxZ2EBY2Orafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986591; c=relaxed/simple;
	bh=ANbXTd6hns5XZw6/gvajBgrg0MaadoANLjiZA9X/ltY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Mfx3Wo1FayocY4Jule+ZO7H2+8gPQMNiDMXBgZf95BIYtopTEL6ELPS7+5wYyXJeCsDg4MD7htL+pNe852Ia8pwe1asuG6GO6GLoKTh/GGMAwVYcTB6h5MDvzWTcsxoYfTfyeaOe2UzDHwDF8lyicTG/aIJB5d9A8hFsJmcqMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id ECE559200B3; Mon, 17 Aug 2026 19:09:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id E9C8192009D;
	Mon, 17 Aug 2026 18:09:47 +0100 (BST)
Date: Mon, 17 Aug 2026 18:09:47 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Randy Dunlap <rdunlap@infradead.org>
cc: linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>, 
    linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbdev: maxine: use MODULE_LICENSE() unconditionally
In-Reply-To: <20260814184234.3013510-1-rdunlap@infradead.org>
Message-ID: <alpine.DEB.2.21.2608171800240.14132@angie.orcam.me.uk>
References: <20260814184234.3013510-1-rdunlap@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 14 Aug 2026, Randy Dunlap wrote:

> This driver cannot be built as a loadable module so testing for
> "#ifdef MODULE" is not appropriate here.
> Also, MODULE_LICENSE() is always available.

 It might best be reordered to the end of file, cf. pmagb-b-fb.c, though 
I'm not sure if we want to be pedantic enough to do it with a separate 
change.  Anyway:

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

 NB making the driver modular ought to be trivial once this has become a 
platform device; I have converted all the TURBOchannel drivers already.  
I have hesitated poking at this one without a live specimen though.

  Maciej
