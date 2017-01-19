From: Rob Herring <robh@kernel.org>
Date: Thu, 19 Jan 2017 15:03:34 +0000
Subject: Re: [PATCH v2 4/5] fbdev/ssd1307fb: add support to enable VBAT
Message-Id: <CAL_JsqLjTa2SWP_cNU9AV4tRZLDcjJsUV7pUvy=4UhQix7ZjQQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1484303628.git.jsarha@ti.com> <214ae9ca86009148f233be71a3606917f3150dcd.1484303628.git.jsarha@ti.com>
 <20170118223310.kxbgq47v7cl33ls3@rob-hp-laptop> <754f3644-a157-bb90-1494-aba4fc1264f8@ti.com>
In-Reply-To: <754f3644-a157-bb90-1494-aba4fc1264f8-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

On Thu, Jan 19, 2017 at 7:15 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 19/01/17 00:33, Rob Herring wrote:
>> On Fri, Jan 13, 2017 at 12:35:48PM +0200, Jyri Sarha wrote:
>>> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>>
>>> SSD1306 needs VBAT when it is wired in charge pump configuration. This
>>> patch adds support to the driver to enable VBAT regulator at init time.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> Reviewed-by: Roger Quadros <rogerq@ti.com>
>>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>>> ---
>>>  .../devicetree/bindings/display/ssd1307fb.txt        |  1 +
>>>  drivers/video/fbdev/ssd1307fb.c                      | 20 +++++++++++++++++++-
>>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
>>> index 6617df6..209d931 100644
>>> --- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
>>> +++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
>>> @@ -16,6 +16,7 @@ Required properties:
>>>  Optional properties:
>>>    - reset-gpios: The GPIO used to reset the OLED display, if available. See
>>>                   Documentation/devicetree/bindings/gpio/gpio.txt for details.
>>> +  - vbat-supply: The supply for VBAT
>>
>> According to the datasheet, SSD1307 has 2 supplies: Vdd and Vcc
>>
>> I don't see any mention of a charge pump, so that must be an external
>> component.
>
> VBAT is for SSD1306. Perhaps the DT doc should mention it.

Datasheet says VBAT is reserved, connect to Vdd. I would just describe
Vdd and Vcc in that case.

Rob
