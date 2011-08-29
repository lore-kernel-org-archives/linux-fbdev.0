From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 29 Aug 2011 00:39:06 +0000
Subject: Re: [PATCH/RFC v2 3/3] fbdev: sh_mobile_lcdc: Support FOURCC-based
Message-Id: <CANqRtoSozX5cPs1c2eqy=mcNi_qzVaVYb9Xmmgv8OOJRdUwWqg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313746626-23845-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1313746626-23845-4-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1313746626-23845-4-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org

On Fri, Aug 19, 2011 at 6:37 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> =A0arch/arm/mach-shmobile/board-ag5evm.c =A0 | =A0 =A02 +-
> =A0arch/arm/mach-shmobile/board-ap4evb.c =A0 | =A0 =A04 +-
> =A0arch/arm/mach-shmobile/board-mackerel.c | =A0 =A04 +-
> =A0drivers/video/sh_mobile_lcdcfb.c =A0 =A0 =A0 =A0| =A0342 +++++++++++++=
+++++++-----------
> =A0include/video/sh_mobile_lcdc.h =A0 =A0 =A0 =A0 =A0| =A0 =A04 +-
> =A05 files changed, 230 insertions(+), 126 deletions(-)

Hi Laurent, thanks for the patch!

Since you're changing the LCDC platform data please make sure you also
update the 5 boards using the LCDC under arch/sh.

Thanks,

/ magnus
