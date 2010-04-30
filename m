From: Timur Tabi <timur.tabi@gmail.com>
Date: Fri, 30 Apr 2010 01:39:02 +0000
Subject: Re: [PATCH 0/5] Rework MPC5121 DIU support (for 2.6.35)
Message-Id: <y2med82fe3e1004291839m92dea081o6a46dc307e07c4ad@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
In-Reply-To: <1272584978-19063-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org, yorksun@freescale.com

On Thu, Apr 29, 2010 at 6:49 PM, Anatolij Gustschin <agust@denx.de> wrote:
> This patch series rework DIU support patches submitted
> previously. Comments to the previos patch series have
> been addressed, not related changes are dropped and some
> changes are split out to separate patches to simplify
> review. Furthermore a patch has been added to support
> setting display mode using EDID block in the device tree.

Have you tested these changes on an MPC8610 HPCD?  If not, do you
think your changes will break that platform?

I have an 8610 in-house, but I'm currently working on another issue on
that board, so I can't test these patches for you just yet.

-- 
Timur Tabi
Linux kernel developer at Freescale
