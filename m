From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Tue, 11 Jun 2019 08:21:14 +0000
Subject: Re: [PATCH 5/8] drivers: media: coda: fix warning same module names
Message-Id: <221c8ef8-7adc-4383-93c9-9031dca590f0@xs4all.nl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190606094722.23816-1-anders.roxell@linaro.org>
 <d6b79ee0-07c6-ad81-16b0-8cf929cc214d@xs4all.nl>
 <CADYN=9KY5=FzrkC7MKj9QnG-eM1NVuL00w8Xv4yU2r05rhr7WQ@mail.gmail.com>
 <c2ff2c77-5c14-4bc4-f59c-7012d272ec76@thinci.com>
 <1560240943.13886.1.camel@pengutronix.de>
In-Reply-To: <1560240943.13886.1.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <p.zabel@pengutronix.de>, Matt Redfearn <matt.redfearn@thinci.com>, Anders Roxell <anders.roxell@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "marex@denx.de" <marex@denx.de>, "stefan@agner.ch" <stefan@agner.ch>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "a.hajda@samsung.com" <a.hajda@samsung.com>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, David Miller <davem@davemloft.net>, Networking <netdev@vger.kernel.org>, Linux

On 6/11/19 10:15 AM, Philipp Zabel wrote:
> Hi,
> 
> On Mon, 2019-06-10 at 13:14 +0000, Matt Redfearn wrote:
>>
>> On 10/06/2019 14:03, Anders Roxell wrote:
>>> On Thu, 6 Jun 2019 at 12:13, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>>>
>>>> On 6/6/19 11:47 AM, Anders Roxell wrote:
>>>>> When building with CONFIG_VIDEO_CODA and CONFIG_CODA_FS enabled as
>>>>> loadable modules, we see the following warning:
>>>>>
>>>>> warning: same module names found:
>>>>>    fs/coda/coda.ko
>>>>>    drivers/media/platform/coda/coda.ko
>>>>>
>>>>> Rework so media coda matches the config fragment. Leaving CODA_FS as is
>>>>> since thats a well known module.
>>>>>
>>>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>>>> ---
>>>>>   drivers/media/platform/coda/Makefile | 4 ++--
>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/media/platform/coda/Makefile b/drivers/media/platform/coda/Makefile
>>>>> index 54e9a73a92ab..588e6bf7c190 100644
>>>>> --- a/drivers/media/platform/coda/Makefile
>>>>> +++ b/drivers/media/platform/coda/Makefile
>>>>> @@ -1,6 +1,6 @@
>>>>>   # SPDX-License-Identifier: GPL-2.0-only
>>>>>
>>>>> -coda-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg2.o coda-mpeg4.o coda-jpeg.o
>>>>> +video-coda-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg2.o coda-mpeg4.o coda-jpeg.o
>>>>>
>>>>> -obj-$(CONFIG_VIDEO_CODA) += coda.o
>>>>> +obj-$(CONFIG_VIDEO_CODA) += video-coda.o
>>>>
>>>> How about imx-coda? video-coda suggests it is part of the video subsystem,
>>>> which it isn't.
>>>
>>> I'll resend a v2 shortly with imx-coda instead.
> 
> I'd be in favor of calling it "coda-vpu" instead.

Fine by me!

> 
>> What about other vendor SoCs implementing the Coda IP block which are 
>> not an imx? I'd prefer a more generic name - maybe media-coda.
> 
> Right, this driver can be used on other SoCs [1].

Good point.

Regards,

	Hans

> 
> [1] https://www.mail-archive.com/linux-media@vger.kernel.org/msg146498.html
> 
> regards
> Philipp
> 
