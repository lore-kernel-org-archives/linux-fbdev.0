From: Alex Buell <alex.buell@munted.org.uk>
Date: Tue, 04 Jan 2011 20:38:22 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <1294173502.17576.26.camel@lithium>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294156627.17576.21.camel@lithium>
	 <20110104.092637.226761806.davem@davemloft.net>
	 <1294171877.17576.24.camel@lithium>
	 <20110104.121958.232738534.davem@davemloft.net>
In-Reply-To: <20110104.121958.232738534.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2011-01-04 at 12:19 -0800, David Miller wrote:

> First of all, the machine dies because those illegal I/O accesses
> generate an unrecoverable asynchronous memory error, we cannot recover
> from it so we have to panic the entire machine.
> 
> Secondly, the keyboard doesn't work because I never implemented the
> monstrous amount of code necessary to allow USB keyboard to work with
> OpenPROM after booting up.
> 
> You have to essentially reset the entire USB host controller, unload
> all of the pending queued URBs in the host controller, put it into a
> quiescent state, and then asynchronously process all USB keyboard
> device events via USB host controller polling implemented via OpenPROM
> backcalls into the kernel, and from there feed the characters to
> OpenPROM so it can see the keypresses.  Upon return from OpenPROM you
> have to reload all of the unloaded URBs back onto the USB host
> controller queues so the kernel can use USB again.
> 
> I never considered this enormous amount of work worth doing, the
> payback is just too small.

Thank you for that explanation, it's much appreciated.
-- 
Tactical Nuclear Kittens
