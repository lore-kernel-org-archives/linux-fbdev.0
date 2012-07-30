From: Ralf Baechle <ralf@linux-mips.org>
Date: Mon, 30 Jul 2012 13:34:47 +0000
Subject: Re: [PATCH] Fix newport con crashes
Message-Id: <20120730133447.GA29993@linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120730105416.DBB961D1CF@solo.franken.de>
In-Reply-To: <20120730105416.DBB961D1CF@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, FlorianSchandinat@gmx.de

On Mon, Jul 30, 2012 at 12:54:16PM +0200, Thomas Bogendoerfer wrote:

> Because of commit e84de0c61905030a0fe66b7210b6f1bb7c3e1eab
> [MIPS: GIO bus support for SGI IP22/28] newport con is now taking over
> console from dummy con, therefore it's necessary to resize the VC to
> the correct size to avoid crashes and garbage on console
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

I've applied your patch to master and the affected -stable branches of the
lmo git tree.

Florian, since this is a driver specific to certain MIPS platforms I'd like
to merge it through the MIPS tree with your ack, if that's ok?

Thanks folks,

  Ralf
