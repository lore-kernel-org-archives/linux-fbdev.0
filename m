From: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Date: Tue, 21 Apr 2015 20:59:41 +0000
Subject: RE: [PATCH v3 2/3] IB/qib: use arch_phys_wc_add()
Message-Id: <32E1700B9017364D9B60AED9960492BC256FB8E2@fmsmsx120.amr.corp.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429648676-17755-1-git-send-email-mcgrof@do-not-panic.com>
 <1429648676-17755-3-git-send-email-mcgrof@do-not-panic.com>
 <20150421205716.GA474@obsidianresearch.com>
In-Reply-To: <20150421205716.GA474@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

> > This driver already makes use of ioremap_wc() on PIO buffers, so
> > convert it to use arch_phys_wc_add().
> 
> This is probably OK, but I think you should also remove the qib_wc_pat module
> parameter.
> 
> Jason

Revise based on Jason's request and I will do some testing.

Mike
