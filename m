From: James Simmons <jsimmons@infradead.org>
Subject: Fbdev 2.5.49 BK fixes.
Date: Tue, 26 Nov 2002 23:22:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0211262306070.30451-100000@phoenix.infradead.org>
References: <20021122100215.GA4998@pazke.ipt>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021122100215.GA4998@pazke.ipt>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Panin <pazke@orbita1.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > Hm. Strange. It should work. Can you get serial console working? 
> 
> Forgot to mention, I've seen message:
> 	fbcon_setup: No support for fontwidth 8
> in /var/log/dmesg. 
> 
> I found this printk() in fbcon_setup(), but i can't even imagine 
> why it happens.

Perfect. I found the problem and I'm about to commit to BK. I posted the 
latest patch against 2.5.49 at

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

> I understand this situation perfectly, looks like it's almost common for
> developers working in "not so importatnt for servers" subsystems :(

:-( Some day that attitude will change.

P.S

    Several drivers have been ported but not all. NVIDIA is still broken 
but I will fix it tonight.
