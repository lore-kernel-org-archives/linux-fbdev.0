From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 01 Dec 2017 08:13:24 +0000
Subject: Re: [PATCH v3 4/4] DTS: Pandora: fix panel compatibility string
Message-Id: <6ca5f2ea-e725-9a9e-ac02-e16beca4a1a0@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1511884135.git.hns@goldelico.com>
 <b6001c7b7fb98e7a3ad4c712084fea9dae9e6b27.1511884135.git.hns@goldelico.com>
 <20171128160437.GD28152@atomide.com>
 <ADAFBBA4-6AC4-4EC4-AB0E-98B59718E12E@goldelico.com>
 <20171128161834.GE28152@atomide.com>
 <4EE1E298-6461-48FF-977C-958DD16AD83A@goldelico.com>
 <20171130152430.GM28152@atomide.com> <20171130220633.imkfyeiqtftnw4j4@earth>
In-Reply-To: <20171130220633.imkfyeiqtftnw4j4@earth>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 01/12/17 00:06, Sebastian Reichel wrote:

>>>> How about let's call it a "typo fix" then? :)
>>>
>>> Well, it is not really a typo.
>>
>> Well what if the stable people pick it into earlier stable series
>> based on the word fix in the subject? That has happened before.
>>
>> I suggest you update the dts patches to use wording like
>> "update compatible to use new naming" or something similar.
> 
> Patch 4/4 is a Fix and should be applied to stable trees. "omapdss,"
> prefix was never supposed to be in the DTS files, is not supposed to
> be in there now and will break some time in the future.
> 
> Explanation: The early init of omapdss adds the prefix at runtime,
> so that the binding can use generic properties and the kernel can
> use omapdss specific drivers until the generic ones can be used

This is true, but the extra "omapdss" does not cause any issues at the
moment, and the time when it causes issues is still many kernel versions
in the future.

But, yes, thinking about this, I agree, it's better to pick this one
separately as a fix (after rebasing it on top of current maineline so
that it doesn't depend on the toppoly name change), and leaving the
toppoly->tpo change as a cleanup.

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
