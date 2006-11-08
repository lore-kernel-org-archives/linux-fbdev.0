From: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] nvidiafb: fix unreachable code in nv10GetConfig
Date: Wed, 8 Nov 2006 16:04:22 -0600
Message-ID: <20061108220422.GL17028@localdomain>
References: <20061108195511.GK17028@localdomain> <20061108121311.29dd0bda.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965843AbWKHWE3@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061108121311.29dd0bda.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Andrew Morton wrote:
> On Wed, 8 Nov 2006 13:55:11 -0600
> Nathan Lynch <ntl@pobox.com> wrote:
> 
> > Fix binary/logical operator typo which leads to unreachable code.
> > Noticed while looking at other issues; I don't have the relevant
> > hardware to test this.
> > 
> > 
> > Signed-off-by: Nathan Lynch <ntl@pobox.com>
> > 
> > --- linux-2.6-powerpc.git.orig/drivers/video/nvidia/nv_setup.c
> > +++ linux-2.6-powerpc.git/drivers/video/nvidia/nv_setup.c
> > @@ -262,7 +262,7 @@ static void nv10GetConfig(struct nvidia_
> >  #endif
> >  
> >  	dev = pci_find_slot(0, 1);
> > -	if ((par->Chipset && 0xffff) == 0x01a0) {
> > +	if ((par->Chipset & 0xffff) == 0x01a0) {
> >  		int amt = 0;
> >  
> >  		pci_read_config_dword(dev, 0x7c, &amt);
> 
> That looks like a pretty significant bug.  It'll cause the kernel to
> potentially map the wrong amount of memory for all cards except the
> NV_ARCH_04 type.  Has been there for over a year though.  hmm..

Did some searching, and assuming that chipset == PCI device id
(dubious?), I think the bug would affect only some integrated GeForce2
cards, which are somewhat old.

It looks to me like the other devices handled by nv10GetConfig would
still be handled as intended, but I'm not familiar with this code.
