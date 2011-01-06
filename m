From: Alex Buell <alex.buell@munted.org.uk>
Date: Thu, 06 Jan 2011 23:34:28 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <1294356868.24378.26.camel@lithium>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110106204240.GA6361@electric-eye.fr.zoreil.com>
	 <1294347036.24378.13.camel@lithium> <1294352651.24378.17.camel@lithium>
	 <20110106.142906.226774601.davem@davemloft.net>
In-Reply-To: <20110106.142906.226774601.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: romieu@fr.zoreil.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2011-01-06 at 14:29 -0800, David Miller wrote:
> You have to initialize par->state.vgabase in the s3fb driver to the
> VGA area iomem pointer you calculated at boot time.

I just had a look through the svgalib.c. It makes a lot of calls to
vgastate with the NULL parameter for the vga iobase, I guess that's
definitely why it's crashing the driver. 

Also, svga.h has inline functions that needs modifying. Looks like a big
change to let it work with the vga iobase or NULL. Perhaps just passing
the par->state.vgabase into those functions could make it work. Usually
this gets initialised as zero at boot or driver load so the default
could be NULL anyway for those drivers that assume it is located at 0. 
-- 
Tactical Nuclear Kittens
