From: Anatolij Gustschin <agust@denx.de>
Date: Tue, 01 Jun 2010 09:38:01 +0000
Subject: Re: [PATCH 0/5] Rework MPC5121 DIU support (for 2.6.35)
Message-Id: <20100601113801.5b0ff773@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<y2med82fe3e1004291839m92dea081o6a46dc307e07c4ad@mail.gmail.com>
In-Reply-To: <y2med82fe3e1004291839m92dea081o6a46dc307e07c4ad-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur.tabi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wd-ynQEQJNshbs@public.gmane.org, dzu-ynQEQJNshbs@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org

Hi Timur,

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
> 
> I have an 8610 in-house, but I'm currently working on another issue on
> that board, so I can't test these patches for you just yet.

Could you please test these patches on MPC8610 HPCD? I think these
changes won't break that platform. The patches apply cleanly on
2.6.35-rc1.

Thanks,
Anatolij
