From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: monochrome display fix.
Date: Mon, 26 Jan 2004 14:48:54 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.58.0401261446560.2313@home.osdl.org>
References: <Pine.LNX.4.44.0401262212140.5445-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401262212140.5445-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



On Mon, 26 Jan 2004, James Simmons wrote:
> 
> [CONSOLE] Don't let a monochrome display stomp all over the console color 
> values.

Why is this ugly patch required? If something can't do color, why does it 
care about "color" in the first place? We've never needed this patch 
before, it looks like something broke somewhere _else_ that causes this
to be relevant.

		Linus
