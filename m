From: Timur Tabi <timur@freescale.com>
Date: Thu, 16 Dec 2010 17:28:24 +0000
Subject: Re: [PATCH v4 5/5] fsl-diu-fb: Support setting display mode using
Message-Id: <4D0A4C38.3010105@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279893639-24333-1-git-send-email-agust@denx.de>
	<1279893639-24333-6-git-send-email-agust@denx.de>
	<AANLkTin-TL5_TKnyHYtZdixosfqpkPNoarSTC+K4tTUb@mail.gmail.com>
	<AANLkTi=NwY_gcBXeKXeGX-qist3tMQ4EWqj3twYGfeWD@mail.gmail.com>
	<4D0A446E.5020600@freescale.com>
	<AANLkTinOf__X0p3_5G90KkYS9PXpB2j0_06MFhFcZzqO@mail.gmail.com>
In-Reply-To: <AANLkTinOf__X0p3_5G90KkYS9PXpB2j0_06MFhFcZzqO@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, Anatolij Gustschin <agust@denx.de>, devicetree-discuss@lists.ozlabs.org

Grant Likely wrote:
> No.  It is a static property of the board/machine.  It is expected it
> to be encoded into the board's .dts file.

Ok, but that only makes sense if the monitor is hard-wired to the board itself.
 If a user can attach any monitor he wants, then the EDID data can't be known at
compile time.

I guess it's no different than using hard-coded memory controller programming
instead of SPD.  You can safely avoid SPD only if the DDR chips are soldered on
the board.

It looks like I need to add board-specific EDID reading to the DIU driver.

-- 
Timur Tabi
Linux kernel developer at Freescale

