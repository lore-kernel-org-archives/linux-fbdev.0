From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] FBDEV 2.6.0-test7 updates.
Date: Fri, 17 Oct 2003 18:25:11 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0310171824190.966-100000@phoenix.infradead.org>
References: <1066389516.4777.231.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1066389516.4777.231.camel@gaston>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> > drivers/video/radeonfb.c still exists, while the build system now uses the one
> > in drivers/video/aty?
> 
> I haven't checked what James did here. In my tree, I was careful to keep
> both old and new drivers available via 2 separate CONFIG options. 

The BK tree doesn't have the new radeon driver. I placed the new radeon 
driver into the patch so people coudl test it.
