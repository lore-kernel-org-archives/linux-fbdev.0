From: David Miller <davem@davemloft.net>
Date: Mon, 05 Aug 2013 01:51:46 +0000
Subject: Re: [PATCH] fbdev: suppress warning when assigning vga-save/restore base
Message-Id: <20130804.185146.1621476659301936865.davem@davemloft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375637141-2878-1-git-send-email-dh.herrmann@gmail.com>
	<51FE907A.2090201@zytor.com>
In-Reply-To: <51FE907A.2090201@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hpa@zytor.com
Cc: dh.herrmann@gmail.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, santiago@crfreenet.org

From: "H. Peter Anvin" <hpa@zytor.com>
Date: Sun, 04 Aug 2013 10:33:46 -0700

> Anyone who can dig backwards and summarize?  In other words:
> 
> Where in the current code do we stuff a physical address in a pointer,
> or a virtual address into a non-pointer?

The VGA register accessors try to accomodate iomem and ioport
accesses.

If they are given a non-NULL iomem pointer 'regbase' they use
iomem accesses, otherwise they do direct ISA port poking.

And yes the drivers in question are making some brash assumptions.
I suspect they should be using ioremap() or similar.
