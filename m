From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 09 Nov 2017 13:49:46 +0000
Subject: Re: [PATCH] video: udlfb: Fix read EDID timeout
Message-Id: <2766267.J9nXlqQIcI@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171102110216.fw4gqa6zkhsofl3o@lenoch>
In-Reply-To: <20171102110216.fw4gqa6zkhsofl3o@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thursday, November 02, 2017 12:02:16 PM Ladislav Michl wrote:
> While usb_control_msg function expects timeout in miliseconds, a value
> of HZ is used. Replace it with USB_CTRL_GET_TIMEOUT and also fix error
> message which looks like:
> udlfb: Read EDID byte 78 failed err ffffff92
> as error is either negative errno or number of bytes transferred use %d
> format specifier.
> 
> Retuned EDID is in second byte, so return error when less than two bytes
> are received.
> 
> Fixes: 18dffdf8913a ("staging: udlfb: enhance EDID and mode handling support")
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

