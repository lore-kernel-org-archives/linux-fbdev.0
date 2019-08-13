From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 13 Aug 2019 13:40:00 +0000
Subject: Re: [PATCH 09/16] fbdev: remove w90x900/nuc900 platform drivers
Message-Id: <CAK8P3a0=5rmWw1vvKX3evVbpk-3Z204QZ3x-DaMs_5e9Kg-YAQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190809202749.742267-1-arnd@arndb.de>
 <CGME20190809202857epcas2p14ab10d8ce2e50647671ab8c0ded385a8@epcas2p1.samsung.com>
 <20190809202749.742267-10-arnd@arndb.de>
 <cc732000-a147-bec2-1082-7bf58ee8f309@samsung.com>
In-Reply-To: <cc732000-a147-bec2-1082-7bf58ee8f309@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: soc@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Tue, Aug 13, 2019 at 3:30 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> On 8/9/19 10:27 PM, Arnd Bergmann wrote:
> > The ARM w90x900 platform is getting removed, so this driver is obsolete.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>
> BTW there is a very minor issue with internal bisectability of
> this patch series (non-issue in reality because it affects only
> configs with ARCH_W90X900=y and such are now gone, just FYI):
>
> arch/arm/mach-w90x900/dev.c (which stays in tree until patch #16
> ("ARM: remove w90x900 platform") uses include/linux/platform_data/
> files removed in patches #7 (spi), #9 (fbdev) and #10 (keyboard).

Ah right, I actually planned to change that originally but forgot.
As you say, it's not a huge issue except for building randconfig or
nuc900_defconfig.

       Arnd
