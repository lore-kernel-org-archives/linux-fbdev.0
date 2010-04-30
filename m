From: Anatolij Gustschin <agust@denx.de>
Date: Fri, 30 Apr 2010 07:41:21 +0000
Subject: Re: [PATCH 0/5] Rework MPC5121 DIU support (for 2.6.35)
Message-Id: <20100430094121.6618234d@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<y2med82fe3e1004291839m92dea081o6a46dc307e07c4ad@mail.gmail.com>
In-Reply-To: <y2med82fe3e1004291839m92dea081o6a46dc307e07c4ad@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur.tabi@gmail.com>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org, yorksun@freescale.com

On Thu, 29 Apr 2010 20:39:02 -0500
Timur Tabi <timur.tabi@gmail.com> wrote:

> On Thu, Apr 29, 2010 at 6:49 PM, Anatolij Gustschin <agust@denx.de> wrote:
> > This patch series rework DIU support patches submitted
> > previously. Comments to the previos patch series have
> > been addressed, not related changes are dropped and some
> > changes are split out to separate patches to simplify
> > review. Furthermore a patch has been added to support
> > setting display mode using EDID block in the device tree.
> 
> Have you tested these changes on an MPC8610 HPCD?  If not, do you
> think your changes will break that platform?

I've compile tested these changes using 86xx/mpc8610_hpcd_defconfig.
Unfortunately I don't have an MPC8610 HPCD and can not test it
more, but I don't think these patches will break that platform. 

Anatolij
