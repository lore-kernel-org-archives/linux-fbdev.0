From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 09 Jan 2019 11:11:46 +0000
Subject: Re: [PATCH v6 02/12] gpu: ipu-csi: Swap fields according to input/output field types
Message-Id: <1547032306.4160.0.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190109001551.16113-1-slongerbeam@gmail.com>
         <20190109001551.16113-3-slongerbeam@gmail.com>
In-Reply-To: <20190109001551.16113-3-slongerbeam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <slongerbeam@gmail.com>, linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:DRM DRIVERS FOR FREESCALE IMX" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>

On Tue, 2019-01-08 at 16:15 -0800, Steve Longerbeam wrote:
> The function ipu_csi_init_interface() was inverting the F-bit for
> NTSC case, in the CCIR_CODE_1/2 registers. The result being that
> for NTSC bottom-top field order, the CSI would swap fields and
> capture in top-bottom order.
> 
> Instead, base field swap on the field order of the input to the CSI,
> and the field order of the requested output. If the input/output
> fields are sequential but different, swap fields, otherwise do
> not swap. This requires passing both the input and output mbus
> frame formats to ipu_csi_init_interface().
> 
> Move this code to a new private function ipu_csi_set_bt_interlaced_codes()
> that programs the CCIR_CODE_1/2 registers for interlaced BT.656 (and
> possibly interlaced BT.1120 in the future).
> 
> When detecting input video standard from the input frame width/height,
> make sure to double height if input field type is alternate, since
> in that case input height only includes lines for one field.
> 
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Also
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
to be merged via the media tree

regards
Philipp
