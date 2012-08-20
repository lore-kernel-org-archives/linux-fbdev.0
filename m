From: =?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?= <gcembed@gmail.com>
Date: Mon, 20 Aug 2012 16:21:16 +0000
Subject: Re: i.MX27 SLCDC driver
Message-Id: <503263FC.8040901@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <502DEDCD.9050303@gmail.com>
 <CAKGA1bmuUxiHbkF0n+bOx81EBQujuhu+piDsfHSVo2LejoPmcw@mail.gmail.com>
In-Reply-To: <CAKGA1bmuUxiHbkF0n+bOx81EBQujuhu+piDsfHSVo2LejoPmcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello
On 08/20/2012 05:21 PM, Matt Sealey wrote:
> On Fri, Aug 17, 2012 at 2:07 AM, Ga=C3=ABtan Carlier <gcembed@gmail.com> =
wrote:
>> Hello,
>> I would like to write the driver for SmartLCD controller of i.MX27. This
>> kind of interface needs a LCD with an embedded graphic controller partia=
lly
>> controlled by GPIO. I want to link it with an OLED DD12832.
>>
>> How have I to write this driver : One driver for SLCDC and one driver for
>> DD12832 ? How to link them together ?
>>
>> Maybe use similar philosophy than soc-camera ?
>
> Please use DRM if you can. That way your SLCDC controller is a "crtc"
> and your OLED panel is a combination "encoder" and "connector". The
> DRM subsystem isn't by far the best solution since it is designed
> around PCI-class graphics cards and the split is intended for those
> and not for more tightly-knit LCDC+display combinations, but it does
> split things the way you're thinking and with a little extra code it
> will do exactly what you want if a little less efficient than your
> attached driver.
>
> I was sure Sascha had a driver for this already;
> http://git.pengutronix.de/?p=3Dimx/linux-2.6.git;a=3Dcommit;h=C333f47fa18=
5edfd1c9d889fc8af040dd557b02c
> - it should not be too hard to add your panel and the specific gpio
> control as an encoder/connector. Maybe with a user this can actually
> go upstream.
>
Thanks a lot for your advises. I will study this code.
Regards,
Ga=C3=ABtan Carlier.
