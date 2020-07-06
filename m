From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 06 Jul 2020 06:02:44 +0000
Subject: Re: [PATCH] omapfb: dss: Fix max fclk divider for omap36xx
Message-Id: <bda1606f-b12c-3356-15ce-489fc2441737@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200630182636.439015-1-aford173@gmail.com>
 <b9052a12-af5a-c1b9-5b86-907eac470cf8@ti.com>
 <20200703193648.GA373653@ravnborg.org>
In-Reply-To: <20200703193648.GA373653@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>

Hi,

On 03/07/2020 22:36, Sam Ravnborg wrote:
> Hi Tomi.
> 
> On Fri, Jul 03, 2020 at 10:17:29AM +0300, Tomi Valkeinen wrote:
>> On 30/06/2020 21:26, Adam Ford wrote:
>>> The drm/omap driver was fixed to correct an issue where using a
>>> divider of 32 breaks the DSS despite the TRM stating 32 is a valid
>>> number.  Through experimentation, it appears that 31 works, and
>>> it is consistent with the value used by the drm/omap driver.
>>>
>>> This patch fixes the divider for fbdev driver instead of the drm.
>>>
>>> Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")
>>>
>>> Cc: <stable@vger.kernel.org> #4.9+
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>> ---
>>> Linux 4.4 will need a similar patch, but it doesn't apply cleanly.
>>>
>>> The DRM version of this same fix is:
>>> e2c4ed148cf3 ("drm/omap: fix max fclk divider for omap36xx")
>>>
>>>
>>> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
>>> index 7252d22dd117..bfc5c4c5a26a 100644
>>> --- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
>>> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
>>> @@ -833,7 +833,7 @@ static const struct dss_features omap34xx_dss_feats = {
>>>    };
>>>    static const struct dss_features omap3630_dss_feats = {
>>> -	.fck_div_max		=	32,
>>> +	.fck_div_max		=	31,
>>>    	.dss_fck_multiplier	=	1,
>>>    	.parent_clk_name	=	"dpll4_ck",
>>>    	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
>>>
>>
>> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Will you apply to drm-misc?

This is for fbdev, so I presume Bartlomiej will pick this one.

> Note  following output from "dim fixes":
> $ dim fixes f76ee892a99e
> Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Jason Yan <yanaijie@huawei.com>
> Cc: "Andrew F. Davis" <afd@ti.com>
> Cc: YueHaibing <yuehaibing@huawei.com>
> Cc: <stable@vger.kernel.org> # v4.5+
> 
> Here it says the fix is valid from v4.5 onwards.

Hmm... Adam, you marked the fix to apply to v4.9+, and then you said 
v4.4 needs a new patch (that's before the big copy/rename). Did you 
check the versions between 4.4 and 4.9? I would guess this one applies 
to v4.5+.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
