From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 10 Nov 2017 15:33:38 +0000
Subject: Re: [PATCH] video: fbdev: Convert timers to use timer_setup()
Message-Id: <1971713.1U12EbtSlg@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171024152032epcas3p4976e268e33d58750b7c09380e857bba0@epcas3p4.samsung.com>
 <15752127.NCT7iFVURk@amdc3058>
 <CAGXu5jJHWHunEVKi-YUybMH+CnfOsaCgYoyO3zODG+GCKwB02A@mail.gmail.com>
In-Reply-To: <CAGXu5jJHWHunEVKi-YUybMH+CnfOsaCgYoyO3zODG+GCKwB02A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook@chromium.org>
Cc: linux-fbdev@vger.kernel.org, David Lechner <david@lechnology.com>, "Gustavo A. R.
 Silva" <gustavo@embeddedor.com>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-omap@vger.kernel.org, Jean Delvare <jdelvare@suse.de>

On Thursday, November 09, 2017 10:40:13 AM Kees Cook wrote:
> On Thu, Nov 9, 2017 at 9:08 AM, Bartlomiej Zolnierkiewicz

[...]

> > [ Please compile these timer changes with PXA3XX_GCU_DEBUG and
> >   PXA3XX_GCU_DEBUG_TIMER defined. ]
> 
> Hm, these appear to be manual knobs? What do you think about wiring
> these up to a Kconfig so build tests for things like "make
> allmodconfig" would enable it? This would allow for much greater build
> coverage.

This is a good idea, care to send a patch?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

