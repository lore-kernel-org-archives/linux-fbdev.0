From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 16 Aug 2010 21:06:34 +0000
Subject: Re: [PATCH] [RFC] cyber2000fb: avoid palette corruption at higher
Message-Id: <20100816210634.GB10119@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201008162209.56902.linux@rainbow-software.org>
In-Reply-To: <201008162209.56902.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Mon, Aug 16, 2010 at 10:09:54PM +0200, Ondrej Zary wrote:
> When 1280x1024@75Hz mode is set, console palette is not set properly -
> sometimes the background is white, sometimes yellow and text colors are also
> messed up. This does not happen at 1280x1024@60Hz and below.

I'm not going to have much time to look at your patches, and I
definitely want to test them on the NetWinder to make sure we
don't regress the primary platform that this driver is supporting.

I should have more time to look at them in September.
