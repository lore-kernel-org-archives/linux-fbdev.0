From: Alex Buell <alex.buell@munted.org.uk>
Date: Tue, 04 Jan 2011 20:11:17 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <1294171877.17576.24.camel@lithium>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294090573.17576.16.camel@lithium>
	 <20110103.143625.193710368.davem@davemloft.net>
	 <1294156627.17576.21.camel@lithium>
	 <20110104.092637.226761806.davem@davemloft.net>
In-Reply-To: <20110104.092637.226761806.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2011-01-04 at 09:26 -0800, David Miller wrote:
> From: Alex Buell <alex.buell@munted.org.uk>
> Date: Tue, 04 Jan 2011 15:57:07 +0000
> 
> > On Mon, 2011-01-03 at 14:36 -0800, David Miller wrote:
> >> From: Alex Buell <alex.buell@munted.org.uk>
> >> Date: Mon, 03 Jan 2011 21:36:13 +0000
> >> 
> >> > Those are 32 bit addresses, so I suppose I should be getting the base
> >> > address for the registers accesses from region 1, right? 
> >> 
> >> Yes, and pre-computed addresses exist in pci_region_start(pdev, 1).
> > 
> > Do you have any tips for reducing the amount of reboots I have to do
> > whenever I try loading the s3fb module after changing code? 
> 
> You should build s3fb as a module, block it from auto-loading in
> /etc/modules.conf, and then load it explicitly by hand as you
> make changes and recompile.

I'm already doing that. In the instances where it results in a crash and
reboots are impossible, dropping into the OpenPROM results in a total
system freeze, cannot type anything in, this means a big red switch
time. Solaris didn't have this problem. Any ideas why Linux does this to
the OpenPROM? 
-- 
Tactical Nuclear Kittens
