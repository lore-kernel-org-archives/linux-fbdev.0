From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 08 Oct 2018 10:41:11 +0000
Subject: Re: [PATCH v2 1/1] atmel_lcdfb: support native-mode display-timings
Message-Id: <20181008104113eucas1p2b13ae804576bf7bcb25ecee9d85f5514~bnAwFQAp51046810468eucas1p2e@eucas1p2.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180825182327epcas2p288809a2555ca2a8dc85bf05d713cce09@epcas2p2.samsung.com>
 <20180825182320.GA3285@ravnborg.org>
In-Reply-To: <20180825182320.GA3285@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 08/25/2018 08:23 PM, Sam Ravnborg wrote:
> When a device tree set a display-timing using native-mode
> then according to the bindings doc this should:
> 
>     native-mode:
>     The native mode for the display, in case multiple
>     modes are provided.
>     When omitted, assume the first node is the native.
> 
> The atmel_lcdfb used the last timing subnode and did not
> respect the timing mode specified with native-mode.
> 
> Introduce use of of_get_videomode() which allowed
> a nice simplification of the code while also
> added support for native-mode.
> 
> As a nice side-effect this fixes a memory leak where the
> data used for timings and the display_np was not freed.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
