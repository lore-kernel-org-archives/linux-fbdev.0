From: Rob Herring <robh@kernel.org>
Date: Fri, 10 Apr 2020 17:33:24 +0000
Subject: Re: [PATCH v2 2/2] powerpc: Remove Xilinx PPC405/PPC440 support
Message-Id: <20200410173324.GA28512@bogus>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1585575111.git.michal.simek@xilinx.com>
 <9c3e02ffa9812c6f046708b45932d40f33e8817a.1585575111.git.michal.simek@xilinx.com>
In-Reply-To: <9c3e02ffa9812c6f046708b45932d40f33e8817a.1585575111.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <michal.simek@xilinx.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, "Desnes A. Nunes do Rosario" <desnesn@linux.ibm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Paul Mackerras <paulus@samba.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Sasha Levin <sashal@kernel.org>, sfr@canb.auug.org.au, Jonathan Corbet <corbet@lwn.net>, maz@kernel.org, Masahiro Yamada <masahiroy@kernel.org>, YueHaibing <yuehaibing@huawei.com>, Krzysztof Kozlowski <krzk@kernel.org>, Allison Randal <allison@lohutok.net>, Matt Porter <mporter@kernel.crashing.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>, git@xilinx.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Christophe Leroy <christophe.leroy@c-s.fr>, monstr@monstr.eu, Wei Hu <weh@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Enrico Weigelt <info@metux.net>, "David S. Miller" <davem@davemloft.net>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

On Mon, Mar 30, 2020 at 03:32:17PM +0200, Michal Simek wrote:
> The latest Xilinx design tools called ISE and EDK has been released in
> October 2013. New tool doesn't support any PPC405/PPC440 new designs.
> These platforms are no longer supported and tested.
> 
> PowerPC 405/440 port is orphan from 2013 by
> commit cdeb89943bfc ("MAINTAINERS: Fix incorrect status tag") and
> commit 19624236cce1 ("MAINTAINERS: Update Grant's email address and maintainership")
> that's why it is time to remove the support fot these platforms.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> 
> Changes in v2:
> - Based on my chat with Arnd I removed arch/powerpc/xmon/ changes done in
>   v1 to keep them the same as before. (kbuild reported some issues with it
>   too)
> 
>  Documentation/devicetree/bindings/xilinx.txt | 143 ------

Acked-by: Rob Herring <robh@kernel.org>

>  Documentation/powerpc/bootwrapper.rst        |  28 +-
>  MAINTAINERS                                  |   6 -
>  arch/powerpc/Kconfig.debug                   |   2 +-
>  arch/powerpc/boot/Makefile                   |   7 +-
>  arch/powerpc/boot/dts/Makefile               |   1 -
>  arch/powerpc/boot/dts/virtex440-ml507.dts    | 406 ----------------
>  arch/powerpc/boot/dts/virtex440-ml510.dts    | 466 -------------------
>  arch/powerpc/boot/ops.h                      |   1 -
>  arch/powerpc/boot/serial.c                   |   5 -
>  arch/powerpc/boot/uartlite.c                 |  79 ----
>  arch/powerpc/boot/virtex.c                   |  97 ----
>  arch/powerpc/boot/virtex405-head.S           |  31 --
>  arch/powerpc/boot/wrapper                    |   8 -
>  arch/powerpc/configs/40x/virtex_defconfig    |  75 ---
>  arch/powerpc/configs/44x/virtex5_defconfig   |  74 ---
>  arch/powerpc/configs/ppc40x_defconfig        |   8 -
>  arch/powerpc/configs/ppc44x_defconfig        |   8 -
>  arch/powerpc/include/asm/xilinx_intc.h       |  16 -
>  arch/powerpc/include/asm/xilinx_pci.h        |  21 -
>  arch/powerpc/kernel/cputable.c               |  39 --
>  arch/powerpc/platforms/40x/Kconfig           |  31 --
>  arch/powerpc/platforms/40x/Makefile          |   1 -
>  arch/powerpc/platforms/40x/virtex.c          |  54 ---
>  arch/powerpc/platforms/44x/Kconfig           |  37 --
>  arch/powerpc/platforms/44x/Makefile          |   2 -
>  arch/powerpc/platforms/44x/virtex.c          |  60 ---
>  arch/powerpc/platforms/44x/virtex_ml510.c    |  30 --
>  arch/powerpc/platforms/Kconfig               |   4 -
>  arch/powerpc/sysdev/Makefile                 |   2 -
>  arch/powerpc/sysdev/xilinx_intc.c            |  88 ----
>  arch/powerpc/sysdev/xilinx_pci.c             | 132 ------
>  drivers/char/Kconfig                         |   2 +-
>  drivers/video/fbdev/Kconfig                  |   2 +-
>  34 files changed, 7 insertions(+), 1959 deletions(-)
