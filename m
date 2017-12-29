From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Dec 2017 18:23:39 +0000
Subject: Re: [0/2] video: ssd1307fb: Adjustments for ssd1307fb_probe()
Message-Id: <f5dd0d53-2014-a967-03c3-05ff8a1cc05d@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171125160425epcas5p43b2d94fbcc74745017c4c91ff08de685@epcas5p4.samsung.com>
 <9433118e-4c2b-db31-7064-df692a99c1b2@users.sourceforge.net>
 <2091464.qzRHS0Wsad@amdc3058>
In-Reply-To: <2091464.qzRHS0Wsad@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Arnd Bergmann <arnd@arndb.de>, Bastian Stender <bst@pengutronix.de>, Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

>>   Delete an error message for a failed memory allocation
> 
> This patch removes the information about the device for which the allocation fails.

How do you think about to take another look if a Linux allocation failure report
could be sufficient in this use case?


>>   Improve a size determination
> 
> This patch depends on the earlier patch (which is not being merged)

Partly, yes.


> so please re-base it if you want it to be applied.

Would you dare to reduce any context lines for this update step so that
such a small adjustment will still work?

Regards,
Markus
