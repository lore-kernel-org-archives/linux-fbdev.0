From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
Date: Tue, 3 Dec 2002 14:01:06 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0212031400420.10097-100000@maxwell.earthlink.net>
References: <1038948479.1040.34.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1038948479.1040.34.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> > I question whether thats something that belongs anywhere near the
> > kernel. Ben Pfaff wrote a fine library for vga16 hackery (BOGL) and it
> > combines very nicely with the fb driver.
> I kinda agree with this.  Most fb apps use mmap to access the
> framebuffer, so it's almost impossible to fake a linear framebuffer from
> a planar one.

Okay. Then that idea is scrapped.
