From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 26 Apr 2018 10:22:48 +0000
Subject: Re: [PATCH 2/3] video: omap: Improve a size determination in omapfb_do_probe()
Message-Id: <6664625.Vrlhroeaex@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1e17c727-884d-5745-2726-48dd3a53c32f@users.sourceforge.net>
 <CGME20171126174230epcas2p263bbe1e8888487b01b51550c24b5c0d4@epcas2p2.samsung.com>
 <3e367b91-a7ae-fc2e-f145-d62cfee14c77@users.sourceforge.net>
In-Reply-To: <3e367b91-a7ae-fc2e-f145-d62cfee14c77@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

On Sunday, November 26, 2017 06:42:23 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Nov 2017 18:16:20 +0100
> 
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

