From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 18 Oct 2012 15:11:29 +0000
Subject: Re: [PATCH 1/2] video: Add support for the Solomon SSD1307 OLED Controller
Message-Id: <50801C21.2060207@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348158800-23039-1-git-send-email-maxime.ripard@free-electrons.com>
 <1348158800-23039-2-git-send-email-maxime.ripard@free-electrons.com>
 <505C73D1.7030800@free-electrons.com> <50618242.2070302@free-electrons.com>
 <50761BB0.3080507@gmx.de>
In-Reply-To: <50761BB0.3080507@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Florian,

Le 11/10/2012 03:06, Florian Tobias Schandinat a =E9crit :
> Hi Maxime,
>=20
> On 09/25/2012 10:06 AM, Maxime Ripard wrote:
>> Hello Florian,
>>
>> Le 21/09/2012 16:04, Maxime Ripard a =E9crit :
>>> Le 20/09/2012 18:33, Maxime Ripard a =E9crit :
>>>> This patch adds support for the Solomon SSD1307 OLED
>>>> controller found on the Crystalfontz CFA10036 board.
>>>>
>>>> This controller can drive a display with a resolution up
>>>> to 128x39 and can operate over I2C or SPI.
>>>>
>>>> The current driver has only been tested on the CFA-10036,
>>>> that is using this controller over I2C to driver a 96x16
>>>> OLED screen.
>>>>
>>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>>> Cc: Brian Lilly <brian@crystalfontz.com>
>>>
>>> Would you consider merging this patch or review it?
>>> It has been around for quite some time now and has not received any
>>> comments for at least the 2 last versions, so I guess there is not much
>>> left holding it back (unless, of course, if you have some comments to
>>> address), and I really would like to have it in 3.7.
>>
>> I guess we missed the 3.7 merge here. That's no big deal, but I sent the
>> patch series on a regular basis, starting 07/17 (sent new versions on
>> 07/31, 08/23, 09/05 and 09/20), addressed all the issues that were
>> raised, and never got any feedback from you, either positive or
>> negative. The patches affecting the MX28 device trees have already been
>> merged by Shawn Guo into its tree, so only the driver and the bindings
>> remain to be merged. So I'm kind of lost on what should I do here?
>>
>> Is it because I have an obviously broken driver or you don't have enough
>> time, or you don't want to merge drivers for such type of low resolution
>> controllers, or any other reason?
>=20
> I don't see any reason to not support low resolutions, might be a nice
> status monitor for embedded devices.
> It's not your fault. It's just that for the past two months writing my
> thesis reduced my free time (and hence the time that I could potentially
> use for reviewing patches) to approximately zero. While I managed to get
> some smaller patches done, there really wasn't any time to process the
> 3-4 completely new things pending and some scarier patches which touch
> the core infrastructure.
> I think that it should be better soon, at least my thesis is now done,
> but I also have to fix up the rest of my life that was neglected while
> writing, including my paid jobs.

Ok, that's fine :)

How do you want to proceed? To you want me to resend the patchset, or
you will review this one when you will have some time?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
