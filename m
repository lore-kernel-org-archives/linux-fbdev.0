From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Dreamcast framebuffer updates.
Date: Sat, 17 May 2003 17:09:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030517220912.GA16800@linux-sh.org>
References: <20030517215102.A21395@infradead.org> <Pine.LNX.4.44.0305172159090.21274-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305172159090.21274-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, May 17, 2003 at 09:59:35PM +0100, James Simmons wrote:
> > >  #ifdef CONFIG_MTRR
> > > -  #include <asm/mtrr.h>
> > > +#include <asm/mtrr.h>
> > >  #endif
> > 
> > how can CONFIG_MTRR ever be set for sh?
> 
> Paul ???   Is it possible? 
> 
No, its not possible. Things were originally written with generic pvr2
hardware in mind (including PVR2 PCI boards like the Neon 250).
Unfortunately I don't have any of that hardware, so these days its all
SH specific. As such, the MTRR stuff can be removed without any
problems.
