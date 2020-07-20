From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 20 Jul 2020 19:27:25 +0000
Subject: Re: [PATCH] video: fbdev: pvr2fb: initialize variables
Message-Id: <CAK8P3a15yTNgDrLWB4mhTJfjLjxjexbGg4Har4S1Q9uUfCBgFw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200720191845.20115-1-trix@redhat.com>
In-Reply-To: <20200720191845.20115-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trix@redhat.com
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, John Hubbard <jhubbard@nvidia.com>, Sam Ravnborg <sam@ravnborg.org>

On Mon, Jul 20, 2020 at 9:19 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> clang static analysis reports this repesentative error
>
> pvr2fb.c:1049:2: warning: 1st function call argument
>   is an uninitialized value [core.CallAndMessage]
>         if (*cable_arg)
>         ^~~~~~~~~~~~~~~
>
> Problem is that cable_arg depends on the input loop to
> set the cable_arg[0].  If it does not, then some random
> value from the stack is used.
>
> A similar problem exists for output_arg.
>
> So initialize cable_arg and output_arg.

Adding a zero-initialization is almost never the correct way to
deal with these warnings, so one has to be careful doing this.

I checked this file, and your patch is absolutely correct here. ;-)

> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
