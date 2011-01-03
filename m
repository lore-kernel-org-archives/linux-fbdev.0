From: David Miller <davem@davemloft.net>
Date: Mon, 03 Jan 2011 19:43:01 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <20110103.114301.102556157.davem@davemloft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294072336.17576.7.camel@lithium>
	<20110103.105827.112602895.davem@davemloft.net>
	<1294083541.17576.11.camel@lithium>
In-Reply-To: <1294083541.17576.11.camel@lithium>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alex.buell@munted.org.uk
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Alex Buell <alex.buell@munted.org.uk>
Date: Mon, 03 Jan 2011 19:39:01 +0000

> Secondly, is Linux fully capable of handling different graphic cards
> simultaneously? For example, plug in a pair of monitors and have
> consoles on both with disparate graphic cards i.e. XVR-500 and S3ViRGE
> etc? 

Technically I don't think it can do it currently.  Maybe just for
kernel message logging, but not for actual login consoles.

One TTY device is marked as the "console" and that's where all
tty[0-9]+ devices get instantiated upon.
