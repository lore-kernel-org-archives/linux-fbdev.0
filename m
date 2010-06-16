From: Anatolij Gustschin <agust@denx.de>
Date: Wed, 16 Jun 2010 07:38:05 +0000
Subject: Re: [PATCH 0/5] Rework MPC5121 DIU support (for 2.6.35)
Message-Id: <20100616093805.3a8df747@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<y2med82fe3e1004291839m92dea081o6a46dc307e07c4ad@mail.gmail.com>
	<20100601113801.5b0ff773@wker>
	<AANLkTims596hCnLgN5Po6nS1bRFxKywEDlBA4mlreciV@mail.gmail.com>
In-Reply-To: <AANLkTims596hCnLgN5Po6nS1bRFxKywEDlBA4mlreciV-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wd-ynQEQJNshbs@public.gmane.org, dzu-ynQEQJNshbs@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org

Hi Timur,

On Fri, 4 Jun 2010 10:46:28 -0500
Timur Tabi <timur@freescale.com> wrote:

> On Tue, Jun 1, 2010 at 4:38 AM, Anatolij Gustschin <agust@denx.de> wrote:
> 
> > Could you please test these patches on MPC8610 HPCD? I think these
> > changes won't break that platform. The patches apply cleanly on
> > 2.6.35-rc1.
> 
> I'll try to get to them as soon as I can.

Any chance this could be done soon? I'd like to include the MPC5121e DIU
support in 2.6.36 since it is currently broken in mainline and the patches
provide the fix.

Thanks,
Anatolij
