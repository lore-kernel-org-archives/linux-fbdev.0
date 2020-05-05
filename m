From: Marco Elver <elver@google.com>
Date: Tue, 05 May 2020 14:12:30 +0000
Subject: Re: [PATCH] omapfb: don't annotate dss_conv_list as __initdata
Message-Id: <CANpmjNNw6M9Gqj6WGTHH4Cegu8roTVu5x6Vqs_tCBxX3gPwL4A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200505140407.373983-1-arnd@arndb.de>
In-Reply-To: <20200505140407.373983-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Alexios Zavras <alexios.zavras@intel.com>, Will Deacon <will@kernel.org>, clang-built-linux@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Enrico Weigelt <info@metux.net>, Allison Randal <allison@lohutok.net>

On Tue, 5 May 2020 at 16:04, Arnd Bergmann <arnd@arndb.de> wrote:
>
> With the kcsan changes, __read_once_size() is not inlined, but
> clang can decide to emit a version that hardcodes the address, which
> in turn triggers a warning for dss_conv_list being __initdata but
> __read_once_size() not being __init:
>
> WARNING: modpost: vmlinux.o(.text+0x6e4d7a): Section mismatch in
> reference from the function __read_once_size() to the variable
> .init.data:dss_conv_list
> The function __read_once_size() references
> the variable __initdata dss_conv_list.
> This is often because __read_once_size lacks a __initdata
> annotation or the annotation of dss_conv_list is wrong.
>
> This is clearly a false positive warning, but it's hard to tell
> who is to blame for it. Work around it by removing the __initdata
> annotation, wasting the space of two pointers in return for getting
> rid of the warning.
>
> Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrastructure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[+Cc Will]

I think Will is working on a series that completely overhauls
READ_ONCE/WRITE_ONCE, also getting rid of __read_once_size() in the
process, which would make this patch redundant. If we can live with
this warning until the new READ_ONCE/WRITE_ONCE gets merged, we can
probably keep things as-is for now.

Thanks,
-- Marco

> ---
>  drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
> index 0ae0cab252d3..29fdff9c95f6 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
> @@ -19,7 +19,7 @@
>  #include <linux/slab.h>
>  #include <linux/list.h>
>
> -static struct list_head dss_conv_list __initdata;
> +static struct list_head dss_conv_list;
>
>  static const char prefix[] __initconst = "omapdss,";
>
> --
> 2.26.0
>
