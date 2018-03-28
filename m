From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 13:36:15 +0000
Subject: Re: [PATCH v2 2/2] video/fbdev/stifb: Delete an error message for a failed memory allocation in stif
Message-Id: <1633440.9F4sjlxLYt@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7dcd32b6-9691-14a1-29cf-3a746ef5adfc@users.sourceforge.net>
 <889131fe-199c-3bef-0781-00761b807426@users.sourceforge.net>
 <f92f41b1-d4fa-4ffa-8c19-af4eb0d2d8cf@users.sourceforge.net>
 <CGME20180328133621epcas2p2865976351cf3dc28ac258d2c9530ffcd@epcas2p2.samsung.com>
In-Reply-To: <f92f41b1-d4fa-4ffa-8c19-af4eb0d2d8cf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, kernel-janitors@vger.kernel.org, "James E. J.
 Bottomley" <jejb@parisc-linux.org>, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, Rolf Eike Beer <eike-kernel@sf-tec.de>

On Sunday, January 07, 2018 12:58:47 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 7 Jan 2018 12:34:22 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

