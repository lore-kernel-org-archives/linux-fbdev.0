From: Rob Herring <robh@kernel.org>
Date: Wed, 30 Dec 2015 14:44:27 +0000
Subject: Re: [PATCH v2 1/3] devicetree/bindings: add reset-gpios and vcc-supply for panel-dpi
Message-Id: <CAL_JsqLEO9Z3kL4WEOS0_vhAHAWGKOLq1ZLse5cSU_zhwH5QBw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1450610002-10531-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1450610002-10531-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <20151229205458.GA31241@rob-hp-laptop> <CAMuHMdUJPUeyhtM3=S4dOgevpnyd0TgkJy7QchPewO4KOxsWvA@mail.gmail.com>
In-Reply-To: <CAMuHMdUJPUeyhtM3=S4dOgevpnyd0TgkJy7QchPewO4KOxsWvA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, Dec 30, 2015 at 4:29 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Dec 29, 2015 at 9:54 PM, Rob Herring <robh@kernel.org> wrote:
>> On Sun, Dec 20, 2015 at 12:13:20PM +0100, Uwe Kleine-König wrote:
>>> Some displays have a reset input and/or need a regulator to function
>>> properly. Allow to specify them for panel-dpi devices.
>>>
>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>> ---
>>>  Documentation/devicetree/bindings/display/panel/panel-dpi.txt | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/panel/panel-dpi.txt b/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
>>> index 216c894d4f99..b52ac52757df 100644
>>> --- a/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
>>> +++ b/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
>>> @@ -7,6 +7,8 @@ Required properties:
>>>  Optional properties:
>>>  - label: a symbolic name for the panel
>>>  - enable-gpios: panel enable gpio
>>> +- reset-gpios: GPIO to control the RESET pin
>>
>> The problem with this in a generic binding is what if the panel has
>> ordering requirements like enable gpio has to be inactive when reset
>> is deasserted?
>>
>>> +- vcc-supply: phandle of regulator that will be used to enable power to the display
>>
>> What if there are 2 supplies?
>
> So it should be "vcc-supplies". Most properties containing phandles use plural
> naming, even if Linux supports a single phandle only (e.g. "power-domains").
> You also may want to add an optional "vcc-supply-names" property to
> differentiate.

True, but the regulator binding is an exception and we don't do that
with it. The prefix is the name and other supplies are not going to be
called Vcc.

Rob
