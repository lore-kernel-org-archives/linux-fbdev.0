From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ppc32: uninorth-agp suspend support
Date: Tue, 1 Mar 2005 22:23:47 +0100
Message-ID: <20050301212347.GB2129@elf.ucw.cz>
References: <1109651140.7669.17.camel@gaston>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1109651140.7669.17.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi!

> (This is for -mm, to be merged along with the aty128fb and radeonfb
> related patches).
> 
> This patch adds suspend/resume support to the Apple UniNorth AGP bridge
> to make sure AGP is properly disabled when the machine goes to sleep.
> Without this, the r300 based laptops will fail to wakeup from sleep when
> using the new experimental r300 DRI driver. It should also improve
> reliablility in general with other chips.

> --- linux-work.orig/drivers/char/agp/uninorth-agp.c	2005-03-01 13:53:32.000000000 +1100
> +++ linux-work/drivers/char/agp/uninorth-agp.c	2005-03-01 14:36:54.000000000 +1100
> @@ -155,6 +161,56 @@
>  	uninorth_tlbflush(NULL);
>  }
>  
> +#ifdef CONFIG_PM
> +static int agp_uninorth_suspend(struct pci_dev *pdev, u32 state)

pm_message_t state, please.

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
