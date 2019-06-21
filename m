From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 21 Jun 2019 14:22:07 +0000
Subject: Re: [PATCH] video: fbdev: pvr2fb: fix compile-testing as module
Message-Id: <CAK8P3a3=5iMx4UEi6pX6AGGsZWHzyiMQRNnUHuA4peZbGQRQZw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190617124822epcas2p2c93d6cec3b60d08d85f228945d5c7623@epcas2p2.samsung.com>
 <20190617124758.1252449-1-arnd@arndb.de> <3ee91294-044d-9bcd-0c4c-3365c0c97604@samsung.com>
In-Reply-To: <3ee91294-044d-9bcd-0c4c-3365c0c97604@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Mike Marshall <hubcap@omnibond.com>, YueHaibing <yuehaibing@huawei.com>, Ira Weiny <ira.weiny@intel.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Jun 21, 2019 at 1:15 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> On 6/17/19 2:47 PM, Arnd Bergmann wrote:
> > Building an allmodconfig kernel now produces a harmless warning:
> >
> > drivers/video/fbdev/pvr2fb.c:726:12: error: unused function 'pvr2_get_param_val' [-Werror,-Wunused-function]
> >
> > Shut this up the same way as we do for other unused functions
> > in the same file, using the __maybe_unused attribute.
> >
> > Fixes: 0f5a5712ad1e ("video: fbdev: pvr2fb: add COMPILE_TEST support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks but I've fixed it already by adding #ifndef MODULE (since other
> functions in the same file using __maybe_unused depend on either PCI or
> SH_DREAMCAST I've preferred not to use this attribute):
>
> https://marc.info/?l=linux-fbdev&m6050904010778&w=2

Ok, dropping my patch from the local queue, your version is obviously
correct as well.

      Arnd
