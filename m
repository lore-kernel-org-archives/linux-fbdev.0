From: Timur Tabi <timur@freescale.com>
Date: Thu, 16 Dec 2010 16:47:53 +0000
Subject: Re: [PATCH v4 5/5] fsl-diu-fb: Support setting display mode using EDID
Message-Id: <AANLkTin-TL5_TKnyHYtZdixosfqpkPNoarSTC+K4tTUb@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279893639-24333-1-git-send-email-agust@denx.de>
	<1279893639-24333-6-git-send-email-agust@denx.de>
In-Reply-To: <1279893639-24333-6-git-send-email-agust-ynQEQJNshbs@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

On Fri, Jul 23, 2010 at 9:00 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Adds support for encoding display mode information
> in the device tree using verbatim EDID block.
>
> If the EDID entry in the DIU node is present, the
> driver will build mode database using EDID data
> and allow setting the display modes from this database.
> Otherwise display mode will be set using mode
> entries from driver's internal database as usual.
>
> This patch also updates device tree bindings.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Acked-by: Timur Tabi <timur@freescale.com>
> Cc: devicetree-discuss@lists.ozlabs.org

Anatolij,

I know this patch is old, but I'm now getting back to working on the
DIU driver.  One question I have: why are you reading the EDID data
from the device tree?  Why not just read it directly from the device
using I2C?  Who is supposed to put the EDID data into the device tree
in the first place?

-- 
Timur Tabi
Linux kernel developer at Freescale
