From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Mon, 28 Oct 2019 19:24:45 +0000
Subject: Re: [PATCH 08/46] ARM: pxa: move regs-lcd.h into driver
Message-Id: <87zhhkn05e.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191018154052.1276506-1-arnd@arndb.de>
        <20191018154201.1276638-8-arnd@arndb.de>
In-Reply-To: <20191018154201.1276638-8-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 18 Oct 2019 17:41:23 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> Only the pxafb driver uses this header, so move it into the
> same directory. The SMART_* macros are required by some
> platform data definitions and can go into the
> linux/platform_data/video-pxafb.h header.
>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
