From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Mar 2011 06:54:05 +0000
Subject: Re: [PATCH] unicore32 framebuffer driver fix: make videomemory kmalloc-ed and floatable
Message-Id: <201103300854.05366.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <019701cbee1e$c4e2d260$4ea87720$@mprc.pku.edu.cn> <201103291642.49555.arnd@arndb.de> <01ca01cbee7b$4f790370$ee6b0a50$@mprc.pku.edu.cn>
In-Reply-To: <01ca01cbee7b$4f790370$ee6b0a50$@mprc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: 'Paul Mundt' <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 30 March 2011 03:39:26 Guan Xuetao wrote:
> > How does this work? UNIFB_MEMSIZE seems to be 4 MB, much more than the
> > maximum of 128 KB that kmalloc can allocate.
> > 
> > Shouldn't this use get_free_pages() instead of kmalloc?
> > 
> 
> When using SLUB allocator, if required memory size  is larger
> than 2*PAGE_SIZE, kmalloc_large is called,
> and eventually __get_free_pages will  be called.
> So,  it would be the same as __get_free_pages.

Ok, I see. It's probably still better to use __get_free_pages directly,
because it's possible to select a different allocator that does not
do this itself.

	Arnd
