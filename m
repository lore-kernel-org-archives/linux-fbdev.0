From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [RFC][PATCH][FBDEV]: Setting fbcon's windows
 size
Date: Sat, 11 Jan 2003 00:00:13 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0301102359340.6594-100000@phoenix.infradead.org>
References: <1042213013.932.13.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1042213013.932.13.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>


> Hopefully it's the final installment for the GTF implementation.
> 
> The fb_get_mode() function checks for a bit in 'flags' (FB_IGNOREMON) so
> it will generate GTF timings regardless of the validity of
> info->monspecs.  This way, drivers can still use GTF even if they don't
> have the operational limits of the monitor.  They'll just decide what is
> a practical safe limit.

Applied. 
