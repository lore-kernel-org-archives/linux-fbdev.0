From: Stefan Agner <stefan@agner.ch>
Date: Thu, 12 Jul 2018 13:46:33 +0000
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Message-Id: <ce461f1f192de0648feb2db148edf60b@agner.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
 <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
 <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
 <638457fd-85da-8fec-d146-517c43f71813@denx.de>
 <b3fa74c5110b45e5992920485749869ab1f7ebce.camel@nxp.com>
 <6995fa4b-47a9-887b-5e4f-4284ca6a2c79@gmail.com>
 <fd22085f646d97f66cff5b7f22785500@agner.ch>
 <6fdba55b-0be6-9e28-d87a-43d876a1fd09@denx.de>
 <617c0a7e9132b929877b8cbcf116b1ea@agner.ch>
 <7f40f34a401ced78703b1a151d9f5fe4ed8c209f.camel@nxp.com>
In-Reply-To: <7f40f34a401ced78703b1a151d9f5fe4ed8c209f.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: marex@denx.de, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, marcofrk@gmail.com, shawnguo@kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, marek.vasut@gmail.com, dl-linux-imx <linux-imx@nxp.com>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org

On 12.07.2018 15:03, Leonard Crestez wrote:
> On Thu, 2018-07-12 at 11:21 +0200, Stefan Agner wrote:
>> On 10.07.2018 11:11, Marek Vasut wrote:
>> > On 07/10/2018 11:06 AM, Stefan Agner wrote:
>> > > This is one of the situation where states quo is kinda the worst
>> > > situation.
>> > >
>> > > Currently imx_v6_v7_defconfig and mxs_defconfig actually still uses
>> > > CONFIG_FB_MXS.
>> > >
>> > > I understand that you'd rather prefer to move forward. I suggest we do
>> > > it in steps.
>> > >
>> > > In 4.19:
>> > >
>> > > - Change DRM driver.name to mxsfb-drm so we avoid conflicts for now
>> >
>> > But this will break mesa if it depends on mxsfb name for ie. etnaviv
>> > binding.
>>
>> Does it? grep -r -e mxsfb in libdrm and mesa master returns nothing.
>>
>> There is also .name in struct drm_driver, which is already set to
>> mxsfb-drm... Is that the one exposed to user space?
> 
> Running etnaviv+x11 with a renamed mxsfb driver works fine on imx6sx-
> sdb.
> 
> Tools like modetest already need -M mxsfb-drm, the drm_driver.name
> seems to be what matters.

Ok, almost thought so, thanks for the confirmation! So we should be
good.

> 
>> - Remove CONFIG_FB_MXS from imx_v6_v7_defconfig/mxs_defconfig now, and
>> only enable CONFIG_DRM_MXSFB=y
> 
> If one of the drivers is renamed then they can coexist: since the
> bindings are distinct one driver will return a probe error and the
> other will bind successfully. This can even be adjusted so that it
> doesn't even print ugly scary errors.
> 
> This can last until somebody implements support for old bindings in the
> drm driver and then FB_MXS can just be deleted.

Yeah I guess that is what Marek don't want because it promotes using
FB_MXS for longer than needed.

I don't care as much since we anyway use the MXSFB DRM driver. However,
what I really dislike is that a kernel compiled with both drivers
currently leads to MXSFB DRM being unusable (because fbdev gets probed
first). I feel removing the MXS_FB is rather harsh, so I *really* would
love to see the MXSFB DRM driver renamed.

--
Stefan
