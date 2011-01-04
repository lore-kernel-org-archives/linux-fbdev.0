From: Alex Buell <alex.buell@munted.org.uk>
Date: Tue, 04 Jan 2011 15:57:07 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <1294156627.17576.21.camel@lithium>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294086801.17576.14.camel@lithium>
	 <20110103.123939.02282416.davem@davemloft.net>
	 <1294090573.17576.16.camel@lithium>
	 <20110103.143625.193710368.davem@davemloft.net>
In-Reply-To: <20110103.143625.193710368.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2011-01-03 at 14:36 -0800, David Miller wrote:
> From: Alex Buell <alex.buell@munted.org.uk>
> Date: Mon, 03 Jan 2011 21:36:13 +0000
> 
> > Those are 32 bit addresses, so I suppose I should be getting the base
> > address for the registers accesses from region 1, right? 
> 
> Yes, and pre-computed addresses exist in pci_region_start(pdev, 1).

Do you have any tips for reducing the amount of reboots I have to do
whenever I try loading the s3fb module after changing code? 
-- 
Tactical Nuclear Kittens
