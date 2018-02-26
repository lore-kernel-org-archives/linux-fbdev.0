From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 26 Feb 2018 14:05:53 +0000
Subject: Re: v4.16-rc0: missing includes in framebuffers break N900 compilation
Message-Id: <46d9fddf-7e6d-b157-0745-6366ccd57a41@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180226130007.GA5634@amd>
In-Reply-To: <20180226130007.GA5634@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, arvind.yadav.cs@gmail.com, b.zolnierkie@samsung.com

v4.16-rc1 has a fix (b9058afcd6c7).

 Tomi

On 26/02/18 15:00, Pavel Machek wrote:
> I needed this to get -rc0 to compile.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> index 48c6500..990f1c9 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> @@ -38,6 +38,7 @@
>  #include <linux/regmap.h>
>  #include <linux/of.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/suspend.h>
>  #include <linux/component.h>
>  
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> index 9a13c35..4862b12 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> @@ -12,6 +12,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> +#include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <video/omapfb_dss.h>
>  
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
> index eac3665..39014e2 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
> @@ -15,6 +15,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> +#include <linux/seq_file.h>
>  #include <linux/clk.h>
>  
>  #include <video/omapfb_dss.h>
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
> index 705373e..e93e7a7 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
> @@ -15,6 +15,7 @@
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <video/omapfb_dss.h>
> +#include <linux/seq_file.h>
>  
>  #include "dss.h"
>  #include "hdmi.h"
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
