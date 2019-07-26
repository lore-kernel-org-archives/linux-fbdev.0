From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 26 Jul 2019 14:42:07 +0000
Subject: Re: [PATCH 0/4] video: of: display_timing: Adjust err printing of of_get_display_timing()
Message-Id: <3fe0fa09-5e7f-158e-7551-e15f5c05ddc0@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190722182439.44844-1-dianders@chromium.org>
        <CGME20190723084201epcas2p49dff78d4666e1451303afcf8163b2061@epcas2p4.samsung.com>
        <20190723083847.GA32268@ravnborg.org>
In-Reply-To: <20190723083847.GA32268@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>, Douglas Anderson <dianders@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, linux-fbdev@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Russell King <linux@armlinux.org.uk>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>


Hi,

On 7/23/19 10:38 AM, Sam Ravnborg wrote:
> Hi Dough.
> 
> On Mon, Jul 22, 2019 at 11:24:35AM -0700, Douglas Anderson wrote:
>> As reported by Sam Ravnborg [1], after commit b8a2948fa2b3
>> ("drm/panel: simple: Add ability to override typical timing") we now
>> see a pointless error message printed on every boot for many systems.
>> Let's fix that by adjusting who is responsible for printing error
>> messages when of_get_display_timing() is used.
>>
>> Most certainly we can bikeshed the topic about whether this is the
>> right fix or we should instead add logic to panel_simple_probe() to
>> avoid calling of_get_display_timing() in the case where there is no
>> "panel-timing" sub-node.  If there is consensus that I should move the
>> fix to panel_simple_probe() I'm happy to spin this series.  In that
>> case we probably should _remove_ the extra prints that were already
>> present in the other two callers of of_get_display_timing().
>>
>> While at it, fix a missing of_node_put() found by code inspection.
>>
>> NOTE: amba-clcd and panel-lvds were only compile-tested.
>>
>> [1] https://lkml.kernel.org/r/20190721093815.GA4375@ravnborg.org
>>
>>
>> Douglas Anderson (4):
>>   video: of: display_timing: Add of_node_put() in
>>     of_get_display_timing()
>>   video: of: display_timing: Don't yell if no timing node is present
>>   drm: panel-lvds: Spout an error if of_get_display_timing() gives an
>>     error
>>   video: amba-clcd: Spout an error if of_get_display_timing() gives an
>>     error
> 
> Series looks good - thanks.
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> You could consider silencing display_timing as the last patch, but thats
> a very small detail.
> 
> How do we apply these fixes - to drm-misc-next? Bartlomiej?
> 
> No need to go in via drm-misc-fixes as the offending commit is only in
> drm-misc-next.
I've merged the whole series to drm-misc-next, thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
