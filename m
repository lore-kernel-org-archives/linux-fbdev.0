From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 29 Dec 2017 18:10:22 +0000
Subject: Re: [PATCH 0/2] video: ssd1307fb: Adjustments for ssd1307fb_probe()
Message-Id: <2091464.qzRHS0Wsad@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171125160425epcas5p43b2d94fbcc74745017c4c91ff08de685@epcas5p4.samsung.com>
 <9433118e-4c2b-db31-7064-df692a99c1b2@users.sourceforge.net>
In-Reply-To: <9433118e-4c2b-db31-7064-df692a99c1b2@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, Bastian Stender <bst@pengutronix.de>

On Saturday, November 25, 2017 05:04:02 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 25 Nov 2017 16:56:46 +0100
> 
> Two update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>   Delete an error message for a failed memory allocation

This patch removes the information about the device for which the allocation
fails.

>   Improve a size determination

This patch depends on the earlier patch (which is not being merged) so please
re-base it if you want it to be applied.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

