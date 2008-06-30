From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fsl-diu-fb: Update Freescale DIU
 driver to use page_alloc_exact()
Date: Mon, 30 Jun 2008 13:24:26 -0700
Message-ID: <20080630132426.a89c32b0.akpm@linux-foundation.org>
References: <1214325853-26150-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDPvV-0008SA-Qt for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 13:24:41 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KDPvU-0007cV-GK
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 13:24:41 -0700
In-Reply-To: <1214325853-26150-1-git-send-email-timur@freescale.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, 24 Jun 2008 11:44:13 -0500
Timur Tabi <timur@freescale.com> wrote:

> Update the Freescale DIU driver to use page_alloc_exact() to allocate a
> DMA buffer.  This also eliminates the rheap-based memory allocator.  We
> can do this now because commit 6ccf61f9 allows us to allocate 8MB physically-
> contiguous memory blocks.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> My other patch, "Add alloc_pages_exact() and free_pages_exact()", must be
> applied first, otherwise drivers/video/fsl-diu-fb.c will not compile.
> 
>  drivers/video/fsl-diu-fb.c |   59 +++++++++++++++----------------------------
>  1 files changed, 21 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index 0a27853..d15d265 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -279,58 +279,41 @@ static struct diu_hw dr = {
>  
>  static struct diu_pool pool;
>  
> -/*	To allocate memory for framebuffer. First try __get_free_pages(). If it
> - *	fails, try rh_alloc. The reason is __get_free_pages() cannot allocate
> - *	very large memory (more than 4MB). We don't want to allocate all memory
> - *	in rheap since small memory allocation/deallocation will fragment the
> - *	rheap and make the furture large allocation fail.
> +/**
> + * fsl_diu_alloc - allocate memory for the DIU
> + * @size: number of bytes to allocate
> + * @param: returned physical address of memory
> + *
> + * This function allocates a physically-contiguous block of memory.
>   */
> -
> -void *fsl_diu_alloc(unsigned long size, phys_addr_t *phys)
> +static void *fsl_diu_alloc(size_t size, phys_addr_t *phys)
>  {
>  	void *virt;
>  
> -	pr_debug("size=%lu\n", size);
> +	pr_debug("size=%u\n", size);

Nope, this will generate warnings on some architectures.

The way to print a size_t is with %zu or %zd.  I guess the latter is for
ssize_t.


> -	virt = (void *)__get_free_pages(GFP_DMA | __GFP_ZERO, get_order(size));
> +	virt = alloc_pages_exact(size, GFP_DMA | __GFP_ZERO);
>  	if (virt) {
>  		*phys = virt_to_phys(virt);
> -		pr_debug("virt %p, phys=%llx\n", virt, (uint64_t) *phys);
> -		return virt;
> -	}
> -	if (!diu_ops.diu_mem) {
> -		printk(KERN_INFO "%s: no diu_mem."
> -			" To reserve more memory, put 'diufb=15M' "
> -			"in the command line\n", __func__);
> -		return NULL;
> -	}
> -
> -	virt = (void *)rh_alloc(&diu_ops.diu_rh_info, size, "DIU");
> -	if (virt) {
> -		*phys = virt_to_bus(virt);
> -		memset(virt, 0, size);
> +		pr_debug("virt=%p, phys=%llx\n", virt, (uint64_t) *phys);

This is also incorrect.  We cannot pass u64 or uint64_t into printk at
all.  We do not know what type the architectures uses to implement
them.  It should be cast to a known type.  In this case `unsigned long
long'.



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
