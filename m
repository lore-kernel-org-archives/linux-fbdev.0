Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94424A14
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Dec 2023 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KndCDJnu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFCBC433C7;
	Wed, 13 Dec 2023 11:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702467732;
	bh=1vE/zzbxSADW+upL7QWLplgWH0pgOZiq9dOEA6CmitU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KndCDJnulYRqiJ3doUao0vYtq17Ji+F+E3huOFCgEVjKCQSusaPJF6sGxezj+zB03
	 v57qlCpx5XoJbBrwuUcXCcqQRYv5bg8uZsdipbsSbYJ44xo4OzWJijSeH7gW4oyIPE
	 Uf1jIuIJRSvegnP04aUIVL2CqE5aJM2G2Ezhix4QsrMB0vpSjAOO53YhyTJ2v3neSQ
	 Klnk2TLdXhozpsA0payECkTpCtkUnkv0BdrHCwLiNoosRAc1V7I5J0h3um5wk/1a1A
	 BLTAK/kiBegGEYOdv7yz3a4GgCeHCW6sHwXdIB6QXDIRlAtR+ZMRpkCB8X1cMZCXyi
	 Yuf2szvDw7sqA==
Date: Wed, 13 Dec 2023 11:42:07 +0000
From: Lee Jones <lee@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fbdev@vger.kernel.org, linux-mtd@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>, Andy Lowe <alowe@mvista.com>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Alan Hourihane <alanh@fairlite.co.uk>
Subject: Re: [PATCH 1/2] fbdev: Remove support for Carillo Ranch driver
Message-ID: <20231213114207.GJ111411@google.com>
References: <20231208224703.1603264-1-willy@infradead.org>
 <1f800b42-03a2-452e-b2a3-912250936413@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f800b42-03a2-452e-b2a3-912250936413@gmx.de>

On Tue, 12 Dec 2023, Helge Deller wrote:

> On 12/8/23 23:47, Matthew Wilcox (Oracle) wrote:
> > As far as anybody can tell, this product never shipped.  If it did,
> > it shipped in 2007 and nobody has access to one any more.  Remove the
> > fbdev driver and the backlight driver.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >   drivers/video/backlight/Kconfig           |    7 -
> >   drivers/video/backlight/Makefile          |    1 -
> >   drivers/video/backlight/cr_bllcd.c        |  264 -----
> >   drivers/video/fbdev/Kconfig               |   15 -
> >   drivers/video/fbdev/Makefile              |    1 -
> >   drivers/video/fbdev/vermilion/Makefile    |    6 -
> >   drivers/video/fbdev/vermilion/cr_pll.c    |  195 ----
> >   drivers/video/fbdev/vermilion/vermilion.c | 1175 ---------------------
> >   drivers/video/fbdev/vermilion/vermilion.h |  245 -----
> >   9 files changed, 1909 deletions(-)
> >   delete mode 100644 drivers/video/backlight/cr_bllcd.c
> >   delete mode 100644 drivers/video/fbdev/vermilion/Makefile
> >   delete mode 100644 drivers/video/fbdev/vermilion/cr_pll.c
> >   delete mode 100644 drivers/video/fbdev/vermilion/vermilion.c
> >   delete mode 100644 drivers/video/fbdev/vermilion/vermilion.h
> 
> I've applied this patch to the fbdev git tree.
> It touches the backlight tree, so I hope it's ok for backlight people?

Better to ask for forgiveness than permission it seems! :)

-- 
Lee Jones [李琼斯]
