From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] Re: atyfb in 2.5.51
Date: Wed, 11 Dec 2002 07:46:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0212110745500.2617-100000@maxwell.earthlink.net>
References: <1039610834.1084.106.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1039610834.1084.106.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Before, most drivers just unconditionally refresh the hardware at every
> switch  during set_var(). I've been pointing this out for a long time
> now, do we unconditionally do a check_var()/set_par() after every
> console switch, or do we rely on fbdev and X cooperating with each
> other? Or better, maybe fbcon has a way of knowing if the switch came
> from  Xfree86.

My next project is to fix this issue. I will be working on that today.
