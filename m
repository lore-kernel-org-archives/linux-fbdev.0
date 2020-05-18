From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 May 2020 07:51:43 +0000
Subject: Re: [linux-next:master 6172/9662] drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse: sparse: incorrec
Message-Id: <CAK8P3a3JsqShYvB_0tc6j5QtrXRcgrgTtWnT8fbsO5x0tJZBsg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, May 18, 2020 at 8:56 AM kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   bdecf38f228bcca73b31ada98b5b7ba1215eb9c9
> commit: bbd7ffdbef6888459f301c5889f3b14ada38b913 [6172/9662] clk: Allow the common clk framework to be selectable
> config: ia64-randconfig-s001-20200518 (attached as .config)
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-193-gb8fad4bc-dirty
>         git checkout bbd7ffdbef6888459f301c5889f3b14ada38b913
>         # save the attached .config to linux build tree
>         make C=1 ARCH=ia64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>
>    drivers/video/fbdev/atmel_lcdfb.c:354:27: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected char [noderef] <asn:2> *screen_base @@    got n:2> *screen_base @@
>    drivers/video/fbdev/atmel_lcdfb.c:354:27: sparse:    expected char [noderef] <asn:2> *screen_base
>    drivers/video/fbdev/atmel_lcdfb.c:354:27: sparse:    got void *
> >> drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void * @@    got char [noderef] <asvoid * @@
> >> drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse:    expected void *
>    drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse:    got char [noderef] <asn:2> *screen_base
>    drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse: sparse: incorrect type in argument 3 (different address spaces) @@    expected void *cpu_addr @@    got char [noderef] <asvoid *cpu_addr @@
>    drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:    expected void *cpu_addr
>    drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:    got char [noderef] <asn:2> *screen_base
>    drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse: sparse: incorrect type in argument 3 (different address spaces) @@    expected void *cpu_addr @@    got char [noderef] <asvoid *cpu_addr @@
>    drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:    expected void *cpu_addr
>    drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:    got char [noderef] <asn:2> *screen_base

This is an old bug, valid but harmless. The same thing happens in a number
of fbdev drivers, but it may be hard to motivate someone to fix them all.

       Arnd
