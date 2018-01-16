From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 16 Jan 2018 15:34:44 +0000
Subject: Re: [PATCH v4 2/2] video: udlfb: Switch from the pr_*() to the dev_*() logging functions
Message-Id: <7055295.rpNZXCjrgc@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180115170131.GB20134@lenoch>
In-Reply-To: <20180115170131.GB20134@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Monday, January 15, 2018 06:01:31 PM Ladislav Michl wrote:
> Use dev_err() and dev_info() instead of pr_err() and pr_info().
> USB device is used as argument to dev_*() functions for probe
> and urb manipulation, FB device for framebuffer related info.
> 
> Also noisy device probe output was partly removed as idVendor,
> idProduct, name and serial are already printed by usb core,
> and partly turned into debug output.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Patch queued for 4.16, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

