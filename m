From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: Virtual framebuffer driver - mmap problem
Date: Thu, 9 Sep 2004 08:31:21 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409090831.21966.adaplas@hotpop.com>
References: <77e82a3f0409080651732d891e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5Cq4-0007NJ-ET
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 17:31:00 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C5Cq3-00070L-Kl
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 17:31:00 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id AE69A81306D
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  9 Sep 2004 00:30:52 +0000 (UTC)
In-Reply-To: <77e82a3f0409080651732d891e@mail.gmail.com>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Shivappa Kushtagi <kushtagi@gmail.com>

On Wednesday 08 September 2004 21:51, Shivappa Kushtagi wrote:
> == You cannot mmap() the video memory of vfb.
>
> ==  Why don"t you use vesafb?
>
> As I had mentioned in my earlier post, I wanted to use virtual
> framebuffer to simulate the display of my target device (say some PDA
> with size 320*480 ).  With vesafb, I will not be able to change the
> resolution ( fbset fails telling,  invalid argument )
>
>
> Is there any other framebuffer based methods to simulate a display ?
>

There are 2 problems with vfb.c that makes mmap fail:

1. uses vmalloc to allocate framebuffer memory
2. has its own fb_mmap hook which always return -EINVAL

If you want to really use vfb.c, you can try to modify vfb.c so it behaves
like a normal, mmappable framebuffer.

A. First you need to change the framebuffer allocation method: Do not use
vmalloc, since it doesn't give you linear memory.  Instead use
__get_free_pages.

videomemorysize = PAGE_SIZE << order;

So if PAGE_SIZE is 4096, to allocate 8192 bytes, use order = 1. Note that
there is an upper limit to order, so keep videomemorysize small.

videomemory = __get_free_pages(GFP_KERNEL, order)

B. Advertise the framebuffer to userspace:

In 2.6:
info->fix.smem_len = videomemorysize;
info->fix.smem_start = virt_to_phys(videomemory) & PAGE_MASK;

In 2.4, you can do the same, but do it in vfb_encode_fix().

C. Finally, create your own vfb_mmap() function. The important thing with
this version of mmap is the use of the VM_RESERVED flag when dealing with
system RAM.  This flag is not necessary for actual framebuffers. You can
copy the fb_mmap function in fbmem.c and modify it for vfb.  For 2.6, you
can use the example below.

Tony

static int vfb_mmap(struct fb_info *info, struct file *file,
		    struct vm_area_struct *vma)
{
	unsigned long off;
#if !defined(__sparc__) || defined(__sparc_v9__)
	unsigned long start;
	u32 len;
#endif

	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
		return -EINVAL;
	off = vma->vm_pgoff << PAGE_SHIFT;

#if defined(__sparc__) && !defined(__sparc_v9__)
	/* Should never get here, all fb drivers should have their own
	   mmap routines */
	return -EINVAL;
#else
	/* !sparc32... */
	lock_kernel();

	/* frame buffer memory */
	start = info->fix.smem_start;
	len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.smem_len);
	if (off >= len) {
		/* memory mapped io */
		off -= len;
		if (info->var.accel_flags) {
			unlock_kernel();
			return -EINVAL;
		}
		start = info->fix.mmio_start;
		len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.mmio_len);
	}
	unlock_kernel();
	start &= PAGE_MASK;
	if ((vma->vm_end - vma->vm_start + off) > len)
		return -EINVAL;
	off += start;
	vma->vm_pgoff = off >> PAGE_SHIFT;
	/* This is an IO map - tell maydump to skip this VMA */
	vma->vm_flags |= VM_IO | VM_RESERVED;
#if defined(__sparc_v9__)
	vma->vm_flags |= (VM_SHM | VM_LOCKED);
	if (io_remap_page_range(vma, vma->vm_start, off,
				vma->vm_end - vma->vm_start, vma->vm_page_prot, 0))
		return -EAGAIN;
#else
#if defined(__mc68000__)
#if defined(CONFIG_SUN3)
	pgprot_val(vma->vm_page_prot) |= SUN3_PAGE_NOCACHE;
#elif defined(CONFIG_MMU)
	if (CPU_IS_020_OR_030)
		pgprot_val(vma->vm_page_prot) |= _PAGE_NOCACHE030;
	if (CPU_IS_040_OR_060) {
		pgprot_val(vma->vm_page_prot) &= _CACHEMASK040;
		/* Use no-cache mode, serialized */
		pgprot_val(vma->vm_page_prot) |= _PAGE_NOCACHE_S;
	}
#endif
#elif defined(__powerpc__)
	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
#elif defined(__alpha__)
	/* Caching is off in the I/O space quadrant by design.  */
#elif defined(__i386__) || defined(__x86_64__)
	if (boot_cpu_data.x86 > 3)
		pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
#elif defined(__mips__)
	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
#elif defined(__hppa__)
	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
#elif defined(__ia64__) || defined(__arm__) || defined(__sh__)
	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
#else
#warning What do we have to do here??
#endif
	if (io_remap_page_range(vma, vma->vm_start, off,
			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
		return -EAGAIN;
#endif /* !__sparc_v9__ */
	return 0;
#endif /* !sparc32 */
}





-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
