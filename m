From: Haojian Zhuang <haojian.zhuang@gmail.com>
Date: Thu, 17 Jan 2013 08:55:22 +0000
Subject: Re: [PATCH v5 0/8] video: mmp display subsystem
Message-Id: <CAN1soZxJGkgBzvM378oQ2rAOhPSBD9boNRNTtvbAccDL5egL=g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358410826-2557-1-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1358410826-2557-1-git-send-email-zzhu3@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Jan 17, 2013 at 4:20 PM, Zhou Zhu <zzhu3@marvell.com> wrote:
> Hi,
>
> This series added support for display controller in
> Marvell "mmp" series processors.
> It also contains patches to enable display panel on
> TTC_DKB board.
>
> v5: rebased to 3.8RC3 and support common clock tree.
> v4: added patches to enable display panel on TTC_DKB
> board.
> v3: registered lcd spi control as a spi master and
> panel driver operations moved to standard spi bus
> interface.
> v2: removed change-id and blank lines.
>
> Thanks,
> -Zhou
>
> Guoqing Li (1):
>   video: mmp display controller support
>
> Lisa Du (1):
>   video: mmp: add tpo hvga panel supported
>
> Zhou Zhu (6):
>   video: mmp display subsystem
>   video: mmp fb support
>   video: mmpdisp: add spi port in display controller
>   ARM: mmp: added device for display controller
>   ARM: mmp: enable display in ttc_dkb
>   ARM: mmp: add display and fb support in pxa910 defconfig
>
Acked for all patches.

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
