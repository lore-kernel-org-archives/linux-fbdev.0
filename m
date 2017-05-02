From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 02 May 2017 11:24:40 +0000
Subject: Re: [PATCH v2] video: fbdev: udlfb: Fix buffer on stack
Message-Id: <26682216.dMGF8KnooD@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Monday, April 24, 2017 11:13:49 AM Maksim Salau wrote:
> Allocate buffers on HEAP instead of STACK for local array
> that is to be sent using usb_control_msg().
> 
> Signed-off-by: Maksim Salau <maksim.salau@gmail.com>

Patch queued for 4.12, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

