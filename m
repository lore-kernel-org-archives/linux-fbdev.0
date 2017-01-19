From: Rob Herring <robh@kernel.org>
Date: Thu, 19 Jan 2017 16:22:54 +0000
Subject: Re: [PATCH v2 4/5] fbdev/ssd1307fb: add support to enable VBAT
Message-Id: <CAL_JsqLnuni0UVy9bDY9Jw6knVozdNT68gFYYfPwqoT-8h2vQw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1484303628.git.jsarha@ti.com> <214ae9ca86009148f233be71a3606917f3150dcd.1484303628.git.jsarha@ti.com>
 <20170118223310.kxbgq47v7cl33ls3@rob-hp-laptop> <754f3644-a157-bb90-1494-aba4fc1264f8@ti.com>
 <CAL_JsqLjTa2SWP_cNU9AV4tRZLDcjJsUV7pUvy=4UhQix7ZjQQ@mail.gmail.com> <c0372d48-b538-64ce-f187-0502a9a4a00e@ti.com>
In-Reply-To: <c0372d48-b538-64ce-f187-0502a9a4a00e-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

On Thu, Jan 19, 2017 at 9:08 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 19/01/17 17:03, Rob Herring wrote:
>
>>>> According to the datasheet, SSD1307 has 2 supplies: Vdd and Vcc
>>>>
>>>> I don't see any mention of a charge pump, so that must be an external
>>>> component.
>>>
>>> VBAT is for SSD1306. Perhaps the DT doc should mention it.
>>
>> Datasheet says VBAT is reserved, connect to Vdd. I would just describe
>> Vdd and Vcc in that case.
>
> I'm no HW guy, but as far as I understand, you can wire it up two ways.
> One has VBAT connected to VDD. The other one has VBAT connected to
> external supply. See "Figure 1 : Application Example of SSD1306Z with
> charge bump".

I should have kept reading...

So either Vdd and Vbat supplies or Vdd and Vcc supplies are valid and
the former only applies to 1306.

Rob
