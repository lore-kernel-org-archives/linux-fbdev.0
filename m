From: Christoph Hellwig <hch@lst.de>
Date: Wed, 03 Apr 2019 15:35:52 +0000
Subject: Re: remove NULL struct device support in the DMA API
Message-Id: <20190403153552.GA26129@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190321225235.30648-1-hch@lst.de>
In-Reply-To: <20190321225235.30648-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Any comments on the remaining patches?  I'd like to give this series
a couple weeks of soaking in linux-next before the end of the merge
window, so reviews would be apprciated.

On Thu, Mar 21, 2019 at 03:52:28PM -0700, Christoph Hellwig wrote:
> We still have a few drivers which pass a NULL struct device pointer
> to DMA API functions, which generally is a bad idea as the API
> implementations rely on the device not only for ops selection, but
> also the dma mask and various other attributes, and many implementations
> have been broken for NULL device support for a while.
> 
> This series removes the few remaning users that weren't picked up in
> the last merge window and then removes core support for this "feature".
> 
> A git tree is also available at:
> 
>     git://git.infradead.org/users/hch/misc.git dma-remove-NULL-dev-support
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-remove-NULL-dev-support
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
