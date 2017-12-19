From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 19 Dec 2017 10:49:01 +0000
Subject: Re: [PATCH v4 1/2] DTS: GTA04: improve panel compatibility string
Message-Id: <e52a086f-6748-0e5e-f9b5-d4532c34d215@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1512114082.git.hns@goldelico.com>
 <280160905017f67c91b96bf38ea9b6094ec277c3.1512114082.git.hns@goldelico.com>
 <20171211152203.GH24344@atomide.com>
In-Reply-To: <20171211152203.GH24344@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tony Lindgren <tony@atomide.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 11/12/17 17:22, Tony Lindgren wrote:
> * H. Nikolaus Schaller <hns@goldelico.com> [171201 07:44]:
>> Official vendor string is now "tpo" and not "toppoly".
>>
>> Requires patch "omapdrm: panel: fix compatible vendor string for td028ttec1"
>> so that the driver understands both.
> 
> Tomi, so what's the plan with the dependency patch, is that for v4.16
> or for the v4.15-rc cycle?

The dependency patch for this one is queued for v4.16 (I just sent a 
pull request today). I could pick this one up (if you give an ack) if I 
send another DRM pull request, but I probably don't have anything else 
to send so most likely I won't pick this up for v4.16.

The patch 2/2 in the series doesn't have dependencies and can be applied 
as a fix for 4.15, or for 4.16.

Neither of these are critical, as things work fine without these patches.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. 
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
