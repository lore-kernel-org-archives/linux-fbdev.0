From: Belisko Marek <marek.belisko@gmail.com>
Date: Tue, 05 Nov 2013 07:24:08 +0000
Subject: Re: [PATCH 0/3] omapdss: venc: Add support for bypass and acbias.
Message-Id: <CAAfyv34j+YhEjtHyf7zg5oBoCV5ROEXow8VV0PQNHLTF5uDZJg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381784555-18344-1-git-send-email-marek@goldelico.com>
In-Reply-To: <1381784555-18344-1-git-send-email-marek@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

ping.

On Mon, Oct 14, 2013 at 11:02 PM, Marek Belisko <marek@goldelico.com> wrote:
> This patches is adding bypass and acbias functionality to omapdss venc driver.
> In first patch we export updatin bypass and acbias in devconf1 register. Next patch
> add handling for updating in venc driver and last patch add driver for opa362 which
> is used on gta04 board and set bypass + acbias.
Is there a chance to get this series to 3.13? Thanks.
>
> Marek Belisko (3):
>   arm: omap2: Export devconf1 bypass and acbias.
>   video: venc: Add new callback and handling for bypass and acbias
>     setup.
>   omapdss: Add OPA362 analog video amplifier driver.
>
>  arch/arm/mach-omap2/Makefile                       |   2 +
>  arch/arm/mach-omap2/control.h                      |   2 +
>  arch/arm/mach-omap2/omap3-tvout.c                  |  36 +++
>  drivers/video/omap2/displays-new/Kconfig           |   6 +
>  drivers/video/omap2/displays-new/Makefile          |   1 +
>  .../video/omap2/displays-new/amplifier-opa362.c    | 294 +++++++++++++++++++++
>  drivers/video/omap2/dss/venc.c                     |  21 ++
>  include/linux/omap-tvout.h                         |  14 +
>  include/video/omap-panel-data.h                    |  17 ++
>  include/video/omapdss.h                            |   2 +
>  10 files changed, 395 insertions(+)
>  create mode 100644 arch/arm/mach-omap2/omap3-tvout.c
>  create mode 100644 drivers/video/omap2/displays-new/amplifier-opa362.c
>  create mode 100644 include/linux/omap-tvout.h
>
> --
> 1.8.1.2
>

Marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
