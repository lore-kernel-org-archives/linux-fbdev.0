From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Tue, 21 Apr 2015 20:57:16 +0000
Subject: Re: [PATCH v3 2/3] IB/qib: use arch_phys_wc_add()
Message-Id: <20150421205716.GA474@obsidianresearch.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429648676-17755-1-git-send-email-mcgrof@do-not-panic.com>
 <1429648676-17755-3-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429648676-17755-3-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

On Tue, Apr 21, 2015 at 01:37:55PM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> This driver already makes use of ioremap_wc() on PIO buffers,
> so convert it to use arch_phys_wc_add().

This is probably OK, but I think you should also remove the qib_wc_pat
module parameter.

Jason
