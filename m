From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 13 Feb 2015 12:03:19 +0000
Subject: Re: [PATCH 1/2]Trivial patch: to solve indentation warnings in amba-clcd.c driver
Message-Id: <20150213120319.GX8656@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150213112125.GA25078@linuxteamdev.amer.dell.com>
 <20150213113515.GW8656@n2100.arm.linux.org.uk>
 <1423828796.2795.7.camel@perches.com>
In-Reply-To: <1423828796.2795.7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Parmeshwr Prasad <parmeshwr_prasad@dell.com>, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, trivial@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 13, 2015 at 03:59:56AM -0800, Joe Perches wrote:
> Perhaps this could be better as:
> 
> 	fb->fb.fix.smem_start > 		 of_translate_address(memory,
> 				      of_get_address(memory, 0, &size, NULL));
> 
> But sometimes using multiple statements instead of
> embedding function calls as arguments can be simpler
> and more intelligible for the reader.
> 
> 	__be32 addr;
> 
> 	...
> 
> 	addr = of_get_address(memory, 0, &size, NULL);
> 	fb->fb.fix.smem_start = of_translate_address(memory, addr);

Yes, that would be a better solution, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
