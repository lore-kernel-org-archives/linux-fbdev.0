From: Anatolij Gustschin <agust@denx.de>
Date: Wed, 16 Jun 2010 20:00:08 +0000
Subject: Re: [PATCH 0/5] Rework MPC5121 DIU support (for 2.6.35)
Message-Id: <20100616220008.459dbc0b@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<y2med82fe3e1004291839m92dea081o6a46dc307e07c4ad@mail.gmail.com>
	<20100601113801.5b0ff773@wker>
	<AANLkTims596hCnLgN5Po6nS1bRFxKywEDlBA4mlreciV@mail.gmail.com>
	<20100616093805.3a8df747@wker> <4C18F0E4.90309@freescale.com>
	<20100616174714.74a2e110@mw.dip.t-dialin.net>
	<4C18FB3F.4020705@freescale.com>
In-Reply-To: <4C18FB3F.4020705-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org

On Wed, 16 Jun 2010 11:26:39 -0500
Timur Tabi <timur@freescale.com> wrote:

> Anatolij Gustschin wrote:
> > On Wed, 16 Jun 2010 10:42:28 -0500
> > Timur Tabi <timur@freescale.com> wrote:
> > 
> >> Anatolij Gustschin wrote:
> >>
> >>> Any chance this could be done soon? I'd like to include the
> >>> MPC5121e DIU support in 2.6.36 since it is currently broken in
> >>> mainline and the patches provide the fix.
> >>
> >> Ok, I'll try it today.
> > 
> > Thanks!
> 
> I tried to build this, but it wouldn't compile, and then I realized I also
> need the 11 patches of the set "Update support for MPC512x".  Unfortunately,
> I don't have this set in my inbox.

Please use Linus' tree, v2.6.35-rc3. The 5 patches from this series
apply cleanly on top of it and 86xx/mpc8610_hpcd_defconfig builds
here. I've tested them on mpc5121e based board but I don't have
MPC8610 HPCD and can't test on it.

> Can you email me, perhaps in one tarball, all of the patches I need?

I've send you these 5 patches, same patches have been posted to the list.

Thanks four your help,
Anatolij
