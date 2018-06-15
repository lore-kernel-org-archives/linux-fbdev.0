From: Marek Vasut <marex@denx.de>
Date: Fri, 15 Jun 2018 21:36:58 +0000
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Message-Id: <638457fd-85da-8fec-d146-517c43f71813@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
 <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
 <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
In-Reply-To: <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Leonard Crestez <leonard.crestez@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "stefan@agner.ch" <stefan@agner.ch>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "marcofrk@gmail.com" <marcofrk@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>

On 06/15/2018 10:58 PM, Leonard Crestez wrote:
> On Fri, 2018-06-15 at 16:47 -0300, Fabio Estevam wrote:
> 
>> On Fri, Jun 15, 2018 at 4:43 PM, Leonard Crestez
>> <leonard.crestez@nxp.com> wrote:
>>> The FBDEV driver uses the same name and both can't be registered at the
>>> same time. Fix this by renaming the drm driver to mxsfb-drm
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>
>> Stefan sent the same patch a few days ago:
>> http://www.spinics.net/lists/dri-devel/msg179489.html
> 
> In that thread there is a proposal for removing the old fbdev/mxsfb
> driver entirely.
> 
> That would break old DTBs, isn't this generally considered bad? Also,
> are we sure the removal of fbdev/mxsfb wouldn't lose any features?
> 
> What my series does is make both drivers work with the same kernel
> image and turns the choice into a board-level dtb decision. Supporting
> everything at once seems desirable to me and it allows for a very
> smooth upgrade path.

Having two drivers in the kernel with different set of bugs is always bad.

> The old driver could be removed later, after all users are converted.

Both drivers were in for long enough already. And let's be realistic,
how many MX23/MX28 users of old DTs with new kernels are there who
cannot update the DT as well ?

IMO keeping the old FBDEV driver in is just an excuse to postpone the
long overdue DT update and I dislike that. Update any remaining DTs and
nuke the FBDEV driver already.

-- 
Best regards,
Marek Vasut
