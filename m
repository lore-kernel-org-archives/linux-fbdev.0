From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 09 Nov 2017 15:45:52 +0000
Subject: Re: [PATCH] video/fbdev/dnfb: Use common error handling code in dnfb_probe()
Message-Id: <10508179.6F5ylYl9eO@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171105144325epcas2p2768d40aa015f0c2e9254b38d8f0f0eb9@epcas2p2.samsung.com>
 <af7afaa3-5467-32c3-9e80-a6c9eb220205@users.sourceforge.net>
In-Reply-To: <af7afaa3-5467-32c3-9e80-a6c9eb220205@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org

On Sunday, November 05, 2017 03:43:05 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 5 Nov 2017 14:54:52 +0100
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

