From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [FB PATCH] cfbimgblt isn't 64-bit clean
Date: Sun, 29 Dec 2002 01:16:25 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0212290027590.14098-100000@phoenix.infradead.org>
References: <20021227151843.A3108@twiddle.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021227151843.A3108@twiddle.net>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Henderson <rth@twiddle.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> The text is written as if it's thinking about handling 64-bit
> unsigned long, but it doesn't.  The tables that map bits to
> pixels are completely unprepared for this.
> 
> I thought about widening the tables, but I thought they'd get
> unreasonably large.  There's no reason not to go ahead and 
> handle this 32-bits at a time.

I thought the tables would come back to haunt us. The only reason the 
tables where introduced was for speed enhancements. I reason the code is 
extra complex was so you could pass 64 bits of data across the bus. I 
still like to see that happen still. What do you think?
