From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 01 Aug 2016 09:13:18 +0000
Subject: Re: [PATCH v3 09/12] gpu: ipu-v3: Add Video Deinterlacer unit
Message-Id: <1470042798.3025.16.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1469994147-17549-1-git-send-email-steve_longerbeam@mentor.com>
 <1469994147-17549-10-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1469994147-17549-10-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <slongerbeam@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com

Am Sonntag, den 31.07.2016, 12:42 -0700 schrieb Steve Longerbeam:
> Adds the Video Deinterlacer (VDIC) unit.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> 
> ---
> 
> v3:
> - renamed and exported ipu_vdi_set_top_field_man() to
>   ipu_vdi_set_field_order(). Args include std and field to determine
>   correct field order.
> - exported ipu_vdi_set_motion().
> - ipu_vdi_setup() does not need to call ipu_vdi_set_top_field_man() or
>   ipu_vdi_set_motion(), since latter are exported. This simplifies args.
> - removed ipu_vdi_toggle_top_field_man().
> - removed ipu_vdi_set_src().
[...]
> --- /dev/null
> +++ b/drivers/gpu/ipu-v3/ipu-vdi.c
> @@ -0,0 +1,254 @@
> +/*
> + * Copyright (C) 2012-2016 Mentor Graphics Inc.
> + * Copyright (C) 2005-2009 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> + * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + * for more details.
> + */
> +#include <linux/export.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <uapi/linux/v4l2-mediabus.h>

Please remove the unused headers. I think you can remove all but
export.h, types.h, errno.h, and io.h.
Other than that, the patch now looks fine to me.

regards
Philipp

