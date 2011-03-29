From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 29 Mar 2011 14:42:49 +0000
Subject: Re: [PATCH] unicore32 framebuffer driver fix: make videomemory kmalloc-ed and floatable
Message-Id: <201103291642.49555.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <019701cbee1e$c4e2d260$4ea87720$@mprc.pku.edu.cn>
In-Reply-To: <019701cbee1e$c4e2d260$4ea87720$@mprc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tuesday 29 March 2011, Guan Xuetao wrote:
> 
> 1. make videomemory kmalloc-ed in fb-puv3.c
> 2. remove resource reservation for old fixed UNIGFX_MMAP & UVC_MMAP space
> 3. remove unused PKUNTIY_UNIGFX_MMAP_BASE, PKUNITY_UNIGFX_MMAP_SIZE,
>         PKUNITY_UVC_MMAP_BASE, PKUNITY_UVC_MMAP_SIZE and KUSER_UNIGFX_BASE
> 4. remove unused header linux/vmalloc.h in fb-puv3.c
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

How does this work? UNIFB_MEMSIZE seems to be 4 MB, much more than the
maximum of 128 KB that kmalloc can allocate.

Shouldn't this use get_free_pages() instead of kmalloc?

	Arnd
