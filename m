From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: Re: [Linux-fbdev-devel] Re: monochrome display fix.
Date: Tue, 27 Jan 2004 08:40:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040127074035.GF1315@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.LNX.4.44.0401262212140.5445-100000@phoenix.infradead.org> <Pine.LNX.4.58.0401261446560.2313@home.osdl.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401261446560.2313@home.osdl.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Linus Torvalds wrote:
> 
> 
> On Mon, 26 Jan 2004, James Simmons wrote:
> > 
> > [CONSOLE] Don't let a monochrome display stomp all over the console color 
> > values.
> 
> Why is this ugly patch required? If something can't do color, why does it 
> care about "color" in the first place?

Because it stores some text attributes in that place.

> We've never needed this patch 
> before, it looks like something broke somewhere _else_ that causes this
> to be relevant.

It was always broken. This went unnoticed, apparently nobody tried to use
a kernel which supports mono and colour framebuffers at the same time.


Thiemo
