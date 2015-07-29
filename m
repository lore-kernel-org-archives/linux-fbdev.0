From: Wei Liu <wei.liu2@citrix.com>
Date: Wed, 29 Jul 2015 11:39:01 +0000
Subject: Re: [Xen-devel] [PATCH 4/8] xen: Use the correctly the Xen memory terminologies
Message-Id: <20150729113901.GB7962@zion.uk.xensource.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
 <1438095769-2560-5-git-send-email-julien.grall@citrix.com>
 <20150729101323.GW5111@zion.uk.xensource.com> <55B8BA9A.8000502@citrix.com>
In-Reply-To: <55B8BA9A.8000502@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 29, 2015 at 12:35:54PM +0100, Julien Grall wrote:
> Hi Wei,
> 
> On 29/07/15 11:13, Wei Liu wrote:
> > On Tue, Jul 28, 2015 at 04:02:45PM +0100, Julien Grall wrote:
> > [...]
> >> diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
> >> index 7d50711..3b7b7c3 100644
> >> --- a/drivers/net/xen-netback/netback.c
> >> +++ b/drivers/net/xen-netback/netback.c
> >> @@ -314,7 +314,7 @@ static void xenvif_gop_frag_copy(struct xenvif_queue *queue, struct sk_buff *skb
> >>  		} else {
> >>  			copy_gop->source.domid = DOMID_SELF;
> >>  			copy_gop->source.u.gmfn > >> -				virt_to_mfn(page_address(page));
> >> +				virt_to_gfn(page_address(page));
> >>  		}
> >>  		copy_gop->source.offset = offset;
> >>  
> >> @@ -1284,7 +1284,7 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
> >>  		queue->tx_copy_ops[*copy_ops].source.offset = txreq.offset;
> >>  
> >>  		queue->tx_copy_ops[*copy_ops].dest.u.gmfn > >> -			virt_to_mfn(skb->data);
> >> +			virt_to_gfn(skb->data);
> >>  		queue->tx_copy_ops[*copy_ops].dest.domid = DOMID_SELF;
> >>  		queue->tx_copy_ops[*copy_ops].dest.offset > >>  			offset_in_page(skb->data);
> > 
> > Reviewed-by: Wei Liu <wei.liu2@citrix.com>
> > 
> > One possible improvement is to change gmfn in copy_gop to gfn as well.
> > But that's outside of netback code.
> 
> The structure gnttab_copy is part of the hypervisor interface. Is it
> fine to differ on the naming between Xen and Linux?
> 
> Or maybe we could do the change in the public headers in Xen repo too.
> Is it fine to do field renaming in public headers?
> 

Oh well. Never mind then. I mistook that structure as internal to Linux.

Wei.

> Regards,
> 
> -- 
> Julien Grall
