From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Date: Thu, 06 Aug 2015 14:20:09 +0000
Subject: Re: [Xen-devel] [PATCH v2 4/8] xen: Use the correctly the Xen memory terminologies
Message-Id: <alpine.DEB.2.02.1508061520010.11337@kaball.uk.xensource.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438711972-18752-1-git-send-email-julien.grall@citrix.com>
 <1438711972-18752-5-git-send-email-julien.grall@citrix.com>
 <55C33E4E.4050704@citrix.com>
 <alpine.DEB.2.02.1508061205190.11337@kaball.uk.xensource.com>
 <55C34250.3040801@citrix.com>
In-Reply-To: <55C34250.3040801@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 6 Aug 2015, Julien Grall wrote:
> On 06/08/15 12:06, Stefano Stabellini wrote:
> > On Thu, 6 Aug 2015, Julien Grall wrote:
> >> Hi,
> >>
> >>
> >> On 04/08/15 19:12, Julien Grall wrote:
> >>> diff --git a/include/xen/page.h b/include/xen/page.h
> >>> index c5ed20b..e7e1425 100644
> >>> --- a/include/xen/page.h
> >>> +++ b/include/xen/page.h
> >>> @@ -3,9 +3,9 @@
> >>>  
> >>>  #include <asm/xen/page.h>
> >>>  
> >>> -static inline unsigned long page_to_mfn(struct page *page)
> >>> +static inline unsigned long page_to_gfn(struct page *page)
> >>>  {
> >>> -	return pfn_to_mfn(page_to_pfn(page));
> >>> +	return pfn_to_gfn(page_to_pfn(page));
> >>>  }
> >>
> >> I've just noticed that there is a function gfn_to_page used for KVM.
> >>
> >> Maybe I should rename page_to_gfn to xen_page_to_gfn to avoid confusion
> >> with KVM one?
> > 
> > Yeah, prepending xen would help to avoid namespace pollution.
> 
> Will do. May I keep your Reviewed-by for this mechanical change?

Yes

