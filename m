From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 17 Jan 2017 23:29:11 +0000
Subject: Re: [PATCH] fbdev: ssd1307fb: allow reset-gpios is missing
Message-Id: <CAHp75VejkJ7g5ZiZvadgUx2rf4fUkxR67Z+Yn6wVwgG_RAwUPQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170117042658.QtsSkpPN@smtp3o.mail.yandex.net> <20170117074013.iqzfuoc3ys27347y@lukather>
In-Reply-To: <20170117074013.iqzfuoc3ys27347y@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Icenowy Zheng <icenowy@aosc.xyz>, David Airlie <airlied@linux.ie>, linux-fbdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>

On Tue, Jan 17, 2017 at 9:40 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Jan 16, 2017 at 05:50:21PM +0800, Icenowy Zheng wrote:
>>
>> 2017年1月16日 16:02于 Maxime Ripard <maxime.ripard@free-electrons.com>写道：
>> >
>> > On Sun, Jan 15, 2017 at 07:21:46PM +0800, Icenowy Zheng wrote:
>> > > Currently some SSD1306 OLED modules are sold without a reset pin (only
>> > > VCC, GND, SCK, SDA four pins).
>> > >
>> > > Add support for missing reset-gpios property.
>> > >
>> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> >
>> > Unfortunately, a similar patch has been sent a couple of times
>> > already:
>> > https://www.spinics.net/lists/devicetree/msg158330.html
>>
>> Why is it never merged?
>
> It was sent 4 days ago...
>
> And since you didn't have the right maintainers in the cc list, yours
> didn't have a chance to be merged either.
>
>> There are really boards that needs this function.
>
> Then  you can accelerate its inclusion by reviewing it.

Perhaps someone eventually adds drivers/reset/reset-gpio.c and uses
devm_get_reset_optional_exclusive() instead?


-- 
With Best Regards,
Andy Shevchenko
