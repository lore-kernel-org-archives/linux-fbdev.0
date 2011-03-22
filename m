From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 22 Mar 2011 20:58:09 +0000
Subject: Re: [PATCH v6 0/6] powerpc, 52xx: add charon board support
Message-Id: <AANLkTi=Da06s2WeA0+9fshBV2ME-ADHPBWxZ5iL6rM_T@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de> <1300782452-528-1-git-send-email-hs@denx.de>
In-Reply-To: <1300782452-528-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Heiko Schocher <hs@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, Wolfram Sang <w.sang@pengutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org, Ben Dooks <ben@simtec.co.uk>, Vincent Sanders <vince@simtec.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, Wolfgang Denk <wd@denx.de>, Paul Mundt <lethal@linux-sh.org>

On Tue, Mar 22, 2011 at 2:27 AM, Heiko Schocher <hs@denx.de> wrote:
> cc: Wolfram Sang <w.sang@pengutronix.de>
> cc: Grant Likely <grant.likely@secretlab.ca>
> cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> cc: linux-fbdev@vger.kernel.org
> cc: devicetree-discuss@ozlabs.org
> cc: Ben Dooks <ben@simtec.co.uk>
> cc: Vincent Sanders <vince@simtec.co.uk>
> cc: Samuel Ortiz <sameo@linux.intel.com>
> cc: linux-kernel@vger.kernel.org
> cc: Randy Dunlap <rdunlap@xenotime.net>
> cc: Wolfgang Denk <wd@denx.de>
> cc: Paul Mundt <lethal@linux-sh.org>
>
> changes since v5:
> - repost complete patchseries, as Paul Mundt suggested
> - rebased against current head
> - add Acked-by from Samuel Ortiz (MFD parts)
> =A0http://www.spinics.net/lists/linux-fbdev/msg02550.html
> =A0http://linux.derkeiler.com/Mailing-Lists/Kernel/2011-01/msg11798.html
>
> =A0and Benjamin Herrenschmidt (DTS parts)
> =A0http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-February/088279.ht=
ml
> - removed patch
> =A0"powerpc, mpc5200: update mpc5200_defconfig to fit for charon board."
> =A0therefore added
> =A0"powerpc, tqm5200: update tqm5200_defconfig to fit for charon board."

Why?  As Wolfram mentioned, I'd rather see mpc5200 defconfig used.
Eventually I'd like to remove tqm5200_defconfig

I'll look through the rest of the patches soon.

g.
