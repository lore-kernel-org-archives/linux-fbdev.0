From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [FB PATCH]
Date: Sat, 28 Dec 2002 18:19:39 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0212281819070.5974-100000@phoenix.infradead.org>
References: <20021227155451.A3942@twiddle.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021227155451.A3942@twiddle.net>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Henderson <rth@twiddle.net>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>


> > Strange, it's defined in drivers/video/fbmem.c in my copy of 2.5.53.
> 
> Ah.  It's not exported, so fbcon as a module fails.
> Not sure how I missed it with a grep...

That problem is fixed already in the latest BK tree. I will push today the 
most recent fixes.
