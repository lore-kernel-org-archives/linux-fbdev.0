From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fb.h header fix.
Date: Wed, 04 Feb 2004 15:13:34 +1100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1075867994.1747.1.camel@gaston>
References: <Pine.LNX.4.44.0402040109570.11656-100000@phoenix.infradead.org>
	 <20040203180352.364da230.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040203180352.364da230.akpm@osdl.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>, torvalds@transmeta.com, Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2004-02-04 at 13:03, Andrew Morton wrote:
> James Simmons <jsimmons@infradead.org> wrote:
> >
> > The XFree86 fbdev server build breaks with the current fb.h. This patch 
> >  fixes that.
> 
> The previous version of this patch caused the ppc64 build to fail.  Did
> that get addressed?

Not yet, it's a ppc64 bug, I haven't had time to fix it, for some
reason, ppc64 doesn't have readq/writeq nor __raw_ IO accessors.

Ben.
