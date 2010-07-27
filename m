From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Tue, 27 Jul 2010 14:53:36 +0000
Subject: Re: fbmem: VM_IO set, but not propagated.
Message-Id: <20100727145336.GA4611@phenom.dumpdata.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100722213128.GA27012@phenom.dumpdata.com>
In-Reply-To: <20100722213128.GA27012@phenom.dumpdata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Jul 26, 2010 at 03:38:12PM -0700, Andrew Morton wrote:
> On Thu, 22 Jul 2010 17:31:28 -0400
> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
> 
> > This bug was found when Linux kernel was running under Xen.
> > In that scenario, any page that has VM_IO flag to it, means that it
> > MUST be a MMIO/VRAM backend memory , _not_ System RAM. That is what the
> > fbmem.c does: sets VM_IO, ioremaps the region - everything is peachy.
> > 
> > Well, not exactly. The vm_page_prot does not get the relevant
> > PTE flags set (_PAGE_IOMAP) which under Xen is a death-kneel to pages
> > that are referencing real physical devices but don't have that flag set.
> > 
> > Here is the patch:
> > 
> > Author: Daniel De Graaf <dgdegra@tycho.nsa.gov>
> > Date:   Wed Jul 21 16:52:46 2010 -0400
> > 
> >     fb: propagate VM_IO to VMA.
> >     
> >     When we setup up the VMA flags for the mmap flag and we end up using
> >     the fallback mmap functionality we set the vma->vm_flags |= VM_IO.
> >     However we neglect to propagate the flag to the vma->vm_page_prot.
> >     
> >     This patch fixes this.
> >     
> >     Tested-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> >     Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > 
> 
> Confused.  We have From:Konrad and Author:Daniel and no signoff from Daniel.

So Daniel came up with the original fix, I've came to him and suggested
that perhaps we should use the vm_get_page_prot, and he agreed.

Since I've kept the patch in my branch of "Xen-KMS/DRM/TTM-fixes" I
figured I should post the patch upstream and hence I signed off on it.

> 
> I've committed the patch assuming that Daniel was the author, but
> didn't sign off the patch.  Your signoff is sufficient for merging

Yes. He is the author. Let me refer back to my notes but I figured
if the patch has an Author: set there was no need for an extra S-o-b?


> purposes.
> 
> But maybe I was wrong.
> 
> 
> I'm also assuming that we can merge this into 2.6.36 and not backport
> it into -stable.  But maybe I'm wrong about that too!  Talk to me.

No need to backport it.
