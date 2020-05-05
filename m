From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 05 May 2020 15:07:45 +0000
Subject: Re: [PATCH] omapfb: don't annotate dss_conv_list as __initdata
Message-Id: <CAK8P3a01jV71_EzaCkaZgG51vnJ+x1c192dZ9efEKTawF6noDQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200505140407.373983-1-arnd@arndb.de>
 <CANpmjNNw6M9Gqj6WGTHH4Cegu8roTVu5x6Vqs_tCBxX3gPwL4A@mail.gmail.com>
In-Reply-To: <CANpmjNNw6M9Gqj6WGTHH4Cegu8roTVu5x6Vqs_tCBxX3gPwL4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marco Elver <elver@google.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Alexios Zavras <alexios.zavras@intel.com>, Will Deacon <will@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, Enrico Weigelt <info@metux.net>, Allison Randal <allison@lohutok.net>

On Tue, May 5, 2020 at 4:12 PM 'Marco Elver' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
> On Tue, 5 May 2020 at 16:04, Arnd Bergmann <arnd@arndb.de> wrote:
> > With the kcsan changes, __read_once_size() is not inlined, but
> > clang can decide to emit a version that hardcodes the address, which
> > in turn triggers a warning for dss_conv_list being __initdata but
> > __read_once_size() not being __init:
> >
> > WARNING: modpost: vmlinux.o(.text+0x6e4d7a): Section mismatch in
> > reference from the function __read_once_size() to the variable
> > .init.data:dss_conv_list
> > The function __read_once_size() references
> > the variable __initdata dss_conv_list.
> > This is often because __read_once_size lacks a __initdata
> > annotation or the annotation of dss_conv_list is wrong.
> >
> > This is clearly a false positive warning, but it's hard to tell
> > who is to blame for it. Work around it by removing the __initdata
> > annotation, wasting the space of two pointers in return for getting
> > rid of the warning.
> >
> > Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrastructure")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> [+Cc Will]
>
> I think Will is working on a series that completely overhauls
> READ_ONCE/WRITE_ONCE, also getting rid of __read_once_size() in the
> process, which would make this patch redundant. If we can live with
> this warning until the new READ_ONCE/WRITE_ONCE gets merged, we can
> probably keep things as-is for now.

Ok, let's drop this one for now.

        Arnd
