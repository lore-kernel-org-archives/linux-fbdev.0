From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 13 Feb 2015 13:36:18 +0000
Subject: Re: [PATCH 2/2]Trivial patch: to solve indentation warnings in amba-clcd.c driver
Message-Id: <20150213133618.GZ8656@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150213112125.GA25078@linuxteamdev.amer.dell.com>
 <20150213113515.GW8656@n2100.arm.linux.org.uk>
 <1423828796.2795.7.camel@perches.com>
 <20150213132805.GA1296@linuxteamdev.amer.dell.com>
In-Reply-To: <20150213132805.GA1296@linuxteamdev.amer.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Parmeshwr Prasad <parmeshwr_prasad@dell.com>
Cc: Joe Perches <joe@perches.com>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "trivial@kernel.org" <trivial@kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Feb 13, 2015 at 08:28:10AM -0500, Parmeshwr Prasad wrote:
> 
> This is second patch in series.
> In driver in_atomic we should not use to check if code is unning in IRQ.
> clcdfb_sleep() function is used to give some delay between operation.
> I have used schedule_timeout() function for same amount of delay.

Frankly, this patch is a mess.  It seems to contain unrelated changes.

Please always review your own patches before you send them - this will
allow you to catch such errors before you post them publically.

The change to clcdfb_sleep() is wrong in any case - you will end up
calling schedule_timeout() from illegal contexts (eg, when the
framebuffer gets blanked/unblanked.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
