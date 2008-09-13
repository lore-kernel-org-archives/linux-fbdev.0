From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] pxafb: frame buffer overlay support for PXA27x.
Date: Sat, 13 Sep 2008 11:20:33 +0100
Message-ID: <20080913102033.GB24437@flint.arm.linux.org.uk>
References: <1221034056-16587-1-git-send-email-giometti@enneenne.com> <1221034056-16587-2-git-send-email-giometti@enneenne.com> <20080913030540.48341eae.akpm@linux-foundation.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758671AbYIMKVm@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080913030540.48341eae.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>, Eric Miao <eric.miao@marvell.com>, linux-kernel@vger.kernel.org, Rodolfo Giometti <giometti@linux.it>, linux-fbdev-devel@lists.sourceforge.net

On Sat, Sep 13, 2008 at 03:05:40AM -0700, Andrew Morton wrote:
> > +static int overlay1fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
> > +{
> > +	struct overlayfb_info *fbi = (struct overlayfb_info *) info;
> > +	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
> >
> > +	if (off < info->fix.smem_len) {
> > +		vma->vm_pgoff += fbi->video_offset / PAGE_SIZE;
> > +		return dma_mmap_writecombine(o1_to_basefb(fbi)->dev, vma,
> > +					     fbi->map_cpu, fbi->map_dma,
> > +					     fbi->map_size);
> > +	}
> > +	return -EINVAL;
> > +}
> 
> No need to set VM_IO or VM_RESERVED, etc?

That's covered by dma_mmap_writecombine -> remap_pfn_range:

        vma->vm_flags |= VM_IO | VM_RESERVED | VM_PFNMAP;
