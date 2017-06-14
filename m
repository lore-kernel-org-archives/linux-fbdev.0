From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 14 Jun 2017 15:44:07 +0000
Subject: Re: [PATCH] uvesafb: Fix continuation printks without KERN_LEVEL to pr_cont, neatening
Message-Id: <4462877.IlSixkH9uk@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170612170554epcas2p2495044e271060f3496db97dc6f31da4c@epcas2p2.samsung.com>
        <c6cbf28b5763bb945d1f55b72f2b79a7772b9966.1497287034.git.joe@perches.com>
In-Reply-To: <c6cbf28b5763bb945d1f55b72f2b79a7772b9966.1497287034.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Michal Januszewski <spock@gentoo.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, June 12, 2017 10:05:45 AM Joe Perches wrote:
> Linus recently broke the printk without KERN_CONT behavior.
> Fix it for uvesafb.
> 
> While there, convert printk(KERN_<LEVEL> to pr_<level>.
> Add pr_fmt and remove the embedded prefixes.
> 
> Miscellanea:
> 
> o Coalesce formats and realign arguments
> o Add a missing space to a format when coalescing.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Patch queued for 4.13, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

