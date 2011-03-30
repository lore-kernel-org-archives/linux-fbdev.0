From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Mar 2011 10:55:18 +0000
Subject: Re: [PATCH] unicore32 framebuffer driver fix: make videomemory kmalloc-ed and floatable
Message-Id: <201103301255.18551.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <019701cbee1e$c4e2d260$4ea87720$@mprc.pku.edu.cn> <201103300854.05366.arnd@arndb.de> <01ea01cbeeb6$99bb5240$cd31f6c0$@mprc.pku.edu.cn>
In-Reply-To: <01ea01cbeeb6$99bb5240$cd31f6c0$@mprc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: 'Paul Mundt' <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 30 March 2011, Guan Xuetao wrote:
> Is it appropriate to using __get_free_pages in framebuffer driver?

Yes, it is appropriate, and it is also more efficient than using
kmalloc.

> And both SLAB and SLUB allocators support 4MB request.

Ok, I did not know that, but I see now how the maximum size is computed.
The limit was 128 KB for a long time, but has apparently changed.

	Arnd
