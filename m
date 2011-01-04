From: David Miller <davem@davemloft.net>
Date: Tue, 04 Jan 2011 20:19:58 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <20110104.121958.232738534.davem@davemloft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294156627.17576.21.camel@lithium>
	<20110104.092637.226761806.davem@davemloft.net>
	<1294171877.17576.24.camel@lithium>
In-Reply-To: <1294171877.17576.24.camel@lithium>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alex.buell@munted.org.uk
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Alex Buell <alex.buell@munted.org.uk>
Date: Tue, 04 Jan 2011 20:11:17 +0000

> I'm already doing that. In the instances where it results in a crash and
> reboots are impossible, dropping into the OpenPROM results in a total
> system freeze, cannot type anything in, this means a big red switch
> time. Solaris didn't have this problem. Any ideas why Linux does this to
> the OpenPROM? 

First of all, the machine dies because those illegal I/O accesses
generate an unrecoverable asynchronous memory error, we cannot recover
from it so we have to panic the entire machine.

Secondly, the keyboard doesn't work because I never implemented the
monstrous amount of code necessary to allow USB keyboard to work with
OpenPROM after booting up.

You have to essentially reset the entire USB host controller, unload
all of the pending queued URBs in the host controller, put it into a
quiescent state, and then asynchronously process all USB keyboard
device events via USB host controller polling implemented via OpenPROM
backcalls into the kernel, and from there feed the characters to
OpenPROM so it can see the keypresses.  Upon return from OpenPROM you
have to reload all of the unloaded URBs back onto the USB host
controller queues so the kernel can use USB again.

I never considered this enormous amount of work worth doing, the
payback is just too small.
