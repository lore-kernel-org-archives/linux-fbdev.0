From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 26 Apr 2018 10:10:43 +0000
Subject: Re: [PATCH 2/2] video: fbdev-MMP: Improve a size determination in path_init()
Message-Id: <2229029.HUmMdrHkAV@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <e2c5fe9e-8e01-7fef-a243-ff5d063787b0@users.sourceforge.net>
 <CGME20171126204359epcas2p46af86788c6717a9d1392cd693f524987@epcas2p4.samsung.com>
 <293fb9cb-3020-bded-b1bd-67bbb2820aa2@users.sourceforge.net>
In-Reply-To: <293fb9cb-3020-bded-b1bd-67bbb2820aa2@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org

On Sunday, November 26, 2017 09:43:52 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Nov 2017 21:21:33 +0100
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

