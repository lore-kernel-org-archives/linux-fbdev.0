From: =?UTF-8?B?R2llZHJpdXMgU3RhdGtldmnEjWl1cw==?=  <giedrius.statkevicius@gmail.com>
Date: Sun, 08 Mar 2015 12:40:03 +0000
Subject: Re: [PATCH 1/4] staging: sm750fb: wrong type for print
Message-Id: <54FC4323.3010909@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425817886-14387-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425817886-14387-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2015.03.08 14:31, Sudip Mukherjee wrote:
> mention correct format specifier while printing
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
> 
> this patch will give checkpatch warnings about use of printk.
> this patch was mainly to fix the build warnings. printk will be
> converted to pr_* and dev_* in a later patch.
> 
>  drivers/staging/sm750fb/sm750.c    | 24 ++++++++++++------------
>  drivers/staging/sm750fb/sm750.h    |  8 ++++----
>  drivers/staging/sm750fb/sm750_hw.c |  4 ++--
>  3 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 520c69e..753869e 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -530,20 +530,20 @@ static int lynxfb_ops_mmap(struct fb_info * info, struct vm_area_struct * vma)
>  	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
>  		return -EINVAL;
>  	off = vma->vm_pgoff << PAGE_SHIFT;
> -	printk("lynxfb mmap pgoff: %x\n", vma->vm_pgoff);
> -	printk("lynxfb mmap off 1: %x\n", off);
> +	printk("lynxfb mmap pgoff: %lx\n", vma->vm_pgoff);
> +	printk("lynxfb mmap off 1: %lx\n", off);
>  	
>  	/* frame buffer memory */
>  	start = info->fix.smem_start;
>  	len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.smem_len);
>  	
> -	printk("lynxfb mmap start 1: %x\n", start);
> +	printk("lynxfb mmap start 1: %lx\n", start);
>  	printk("lynxfb mmap len 1: %x\n", len);
>  	
>  	if (off >= len) {
>  		/* memory mapped io */
>  		off -= len;
> -		printk("lynxfb mmap off 2: %x\n", off);
> +		printk("lynxfb mmap off 2: %lx\n", off);
>  		if (info->var.accel_flags) {
>  			printk("lynxfb mmap accel flags true");
>  			return -EINVAL;
> @@ -551,28 +551,28 @@ static int lynxfb_ops_mmap(struct fb_info * info, struct vm_area_struct * vma)
>  		start = info->fix.mmio_start;
>  		len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.mmio_len);
>  		
> -		printk("lynxfb mmap start 2: %x\n", start);
> +		printk("lynxfb mmap start 2: %lx\n", start);
>  		printk("lynxfb mmap len 2: %x\n", len);
>  	}
>  	start &= PAGE_MASK;
> -	printk("lynxfb mmap start 3: %x\n", start);
> -	printk("lynxfb mmap vm start: %x\n", vma->vm_start);
> -	printk("lynxfb mmap vm end: %x\n", vma->vm_end);
> +	printk("lynxfb mmap start 3: %lx\n", start);
> +	printk("lynxfb mmap vm start: %lx\n", vma->vm_start);
> +	printk("lynxfb mmap vm end: %lx\n", vma->vm_end);
>  	printk("lynxfb mmap len: %x\n", len);
> -	printk("lynxfb mmap off: %x\n", off);
> +	printk("lynxfb mmap off: %lx\n", off);
>  	if ((vma->vm_end - vma->vm_start + off) > len)
>  	{
>  		return -EINVAL;
>  	}
>  	off += start;
> -	printk("lynxfb mmap off 3: %x\n", off);
> +	printk("lynxfb mmap off 3: %lx\n", off);
>  	vma->vm_pgoff = off >> PAGE_SHIFT;
>  	/* This is an IO map - tell maydump to skip this VMA */
>  	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
>  	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
>  	fb_pgprotect(file, vma, off);
> -	printk("lynxfb mmap off 4: %x\n", off);
> -	printk("lynxfb mmap pgprot: %x\n", vma->vm_page_prot);
> +	printk("lynxfb mmap off 4: %lx\n", off);
> +	printk("lynxfb mmap pgprot: %lx\n", (unsigned long) pgprot_val(vma->vm_page_prot));
>  	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
>  			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
>  		return -EAGAIN;
> diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
> index 711676c..2ab7b74 100644
> --- a/drivers/staging/sm750fb/sm750.h
> +++ b/drivers/staging/sm750fb/sm750.h
> @@ -59,10 +59,10 @@ struct lynx_share{
>  		}mtrr;
>  #endif
>  	/* all smi graphic adaptor got below attributes */
> -	resource_size_t vidmem_start;
> -	resource_size_t vidreg_start;
> -	resource_size_t vidmem_size;
> -	resource_size_t vidreg_size;
> +	unsigned long vidmem_start;
> +	unsigned long vidreg_start;
> +	unsigned long vidmem_size;
> +	unsigned long vidreg_size;

Have you checked other places where these are used? resource_size_t can
be either u64 or u32 depending on if CONFIG_PHYS_ADDR_T_64BIT is
#defined. Are you sure you aren't losing information when results of
functions are being assigned to this? Maybe there should be a function
similar to printk that changes between %u and %llu depending on whether
that is defined?

-- 
Thanks,
Giedrius
