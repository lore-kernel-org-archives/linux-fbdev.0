From: Timur Tabi <timur@freescale.com>
Date: Thu, 16 Dec 2010 16:55:10 +0000
Subject: Re: [PATCH v4 5/5] fsl-diu-fb: Support setting display mode using
Message-Id: <4D0A446E.5020600@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279893639-24333-1-git-send-email-agust@denx.de>
	<1279893639-24333-6-git-send-email-agust@denx.de>
	<AANLkTin-TL5_TKnyHYtZdixosfqpkPNoarSTC+K4tTUb@mail.gmail.com>
	<AANLkTi=NwY_gcBXeKXeGX-qist3tMQ4EWqj3twYGfeWD@mail.gmail.com>
In-Reply-To: <AANLkTi=NwY_gcBXeKXeGX-qist3tMQ4EWqj3twYGfeWD@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, Anatolij Gustschin <agust@denx.de>, devicetree-discuss@lists.ozlabs.org

Grant Likely wrote:
> This is for devices which don't have an i2c edid channel.

So are we expecting board-specific code in U-Boot to add the data to the device
tree?

-- 
Timur Tabi
Linux kernel developer at Freescale

