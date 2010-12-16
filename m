From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 16 Dec 2010 17:06:59 +0000
Subject: Re: [PATCH v4 5/5] fsl-diu-fb: Support setting display mode using EDID
Message-Id: <AANLkTinOf__X0p3_5G90KkYS9PXpB2j0_06MFhFcZzqO@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279893639-24333-1-git-send-email-agust@denx.de>
	<1279893639-24333-6-git-send-email-agust@denx.de>
	<AANLkTin-TL5_TKnyHYtZdixosfqpkPNoarSTC+K4tTUb@mail.gmail.com>
	<AANLkTi=NwY_gcBXeKXeGX-qist3tMQ4EWqj3twYGfeWD@mail.gmail.com>
	<4D0A446E.5020600@freescale.com>
In-Reply-To: <4D0A446E.5020600-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

On Thu, Dec 16, 2010 at 9:55 AM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>> This is for devices which don't have an i2c edid channel.
>
> So are we expecting board-specific code in U-Boot to add the data to the device
> tree?

No.  It is a static property of the board/machine.  It is expected it
to be encoded into the board's .dts file.

g.
