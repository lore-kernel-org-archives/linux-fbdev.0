From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 26 Jul 2010 22:38:12 +0000
Subject: Re: fbmem: VM_IO set, but not propagated.
Message-Id: <20100726153812.3dbcd2bd.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100722213128.GA27012@phenom.dumpdata.com>
In-Reply-To: <20100722213128.GA27012@phenom.dumpdata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 22 Jul 2010 17:31:28 -0400
Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:

> This bug was found when Linux kernel was running under Xen.
> In that scenario, any page that has VM_IO flag to it, means that it
> MUST be a MMIO/VRAM backend memory , _not_ System RAM. That is what the
> fbmem.c does: sets VM_IO, ioremaps the region - everything is peachy.
> 
> Well, not exactly. The vm_page_prot does not get the relevant
> PTE flags set (_PAGE_IOMAP) which under Xen is a death-kneel to pages
> that are referencing real physical devices but don't have that flag set.
> 
> Here is the patch:
> 
> Author: Daniel De Graaf <dgdegra@tycho.nsa.gov>
> Date:   Wed Jul 21 16:52:46 2010 -0400
> 
>     fb: propagate VM_IO to VMA.
>     
>     When we setup up the VMA flags for the mmap flag and we end up using
>     the fallback mmap functionality we set the vma->vm_flags |= VM_IO.
>     However we neglect to propagate the flag to the vma->vm_page_prot.
>     
>     This patch fixes this.
>     
>     Tested-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
>     Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 

Confused.  We have From:Konrad and Author:Daniel and no signoff from Daniel.

I've committed the patch assuming that Daniel was the author, but
didn't sign off the patch.  Your signoff is sufficient for merging
purposes.

But maybe I was wrong.


I'm also assuming that we can merge this into 2.6.36 and not backport
it into -stable.  But maybe I'm wrong about that too!  Talk to me.

