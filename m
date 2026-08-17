Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212633EEAC2;
	Mon, 17 Aug 2026 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985862; cv=none; b=mgj85C88HH1EqKS7JkmHKS+/M7uwRLiSUFrHJ7ykVWiPDXedqAQL/j71rapGRsiv1SXMwmcHtIHC1wfvyYpdlb4yrGyn2ik0QSxjv5R4jNxwv+3fRvNjXZItT5uAvC8b/F24CU8E/X7+vw7NCAkPq69u/OyVWNUu9ohaJpzYDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985862; c=relaxed/simple;
	bh=yI+GfrqesxzTvXQ2ETrJMIWHhCwHf7NVjM4+8dgzJcg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mAthZuL8K63Fl0eabKhdMiE4tnhbZvE6E7u53Hn+Cvj9hGLzmm2sNifJlJYiCjq+FgUCIjpPTJugv2ckxzWMAJ+9B9UkXK7NNOYMiHV2+LsD4Vk4rHyGgS5osGQvHnrDXRtHuGWOMkqvjFwEMRdoLcYAY+W5QXUb5sBpyEaOrE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 66FC49200C0; Mon, 17 Aug 2026 18:57:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 5FEE29200BB;
	Mon, 17 Aug 2026 17:57:39 +0100 (BST)
Date: Mon, 17 Aug 2026 17:57:39 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Randy Dunlap <rdunlap@infradead.org>
cc: linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>, 
    linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 03/03] fbdev: maxine: fix 64-bit build error
In-Reply-To: <20260813232934.2718291-4-rdunlap@infradead.org>
Message-ID: <alpine.DEB.2.21.2608171757200.14132@angie.orcam.me.uk>
References: <20260813232934.2718291-1-rdunlap@infradead.org> <20260813232934.2718291-4-rdunlap@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 13 Aug 2026, Randy Dunlap wrote:

> The KSEG1ADDR() macro is only defined for non-64BIT builds.
> Use the CKSEG1ADDR() macro instead.

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej
