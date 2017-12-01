From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 01 Dec 2017 10:01:23 +0000
Subject: Re: [PATCH v3 4/4] DTS: Pandora: fix panel compatibility string
Message-Id: <a27001ba-5ffd-365d-93e3-06fd1a2e01c2@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1511884135.git.hns@goldelico.com>
 <b6001c7b7fb98e7a3ad4c712084fea9dae9e6b27.1511884135.git.hns@goldelico.com>
 <20171128160437.GD28152@atomide.com>
 <ADAFBBA4-6AC4-4EC4-AB0E-98B59718E12E@goldelico.com>
 <20171128161834.GE28152@atomide.com>
 <4EE1E298-6461-48FF-977C-958DD16AD83A@goldelico.com>
 <20171130152430.GM28152@atomide.com> <20171130220633.imkfyeiqtftnw4j4@earth>
 <6ca5f2ea-e725-9a9e-ac02-e16beca4a1a0@ti.com>
 <0324FA0E-F06A-41F1-84AD-5BC72F6B6BFF@goldelico.com>
In-Reply-To: <0324FA0E-F06A-41F1-84AD-5BC72F6B6BFF@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Julia Lawall <Julia.Lawall@lip6.fr>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 01/12/17 11:48, H. Nikolaus Schaller wrote:

> Just a note: there is no toppoly->tpo change for *this* panel and
> Pandora board. Just omapdss removal.
> 
> The GTA04 needs a toppoly->tpo change but no omapdss, removal.
> 
> So they solve different problems and are independent of each other.
> 
> GTA04: change vendor string
> Pandora: remove omapdss, prefix

Oh, right, I totally missed that. I thought they were changes to the
same file...

In that case, Tony, can you pick this one as a fix? I'll pick the
toppoly->tpo patch and merge via drm tree, if you give the ack.

For this:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
