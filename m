From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Feb 2018 15:14:38 +0000
Subject: Re: [PATCH 0/3] console: Expand dummy functions for CFI
Message-Id: <2698133.VOZeH6rfJt@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180227000432epcas2p1408299421426381f05a548283953b064@epcas2p1.samsung.com>
 <1519689860-7421-1-git-send-email-keescook@chromium.org>
 <1712993.EvPlpO244k@amdc3058>
In-Reply-To: <1712993.EvPlpO244k@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Kees Cook <keescook@chromium.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Winischhofer <thomas@winischhofer.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sami Tolvanen <samitolvanen@google.com>

On Wednesday, February 28, 2018 04:09:47 PM Bartlomiej Zolnierkiewicz wrote:
> On Monday, February 26, 2018 04:04:17 PM Kees Cook wrote:
> > This is a small series that cleans up struct consw a bit and
> > prepares it for Control Flow Integrity checking (i.e. Clang's
> > -fsanitize=CFi).
>=20
> for drivers/video/ parts:
>=20
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

also I'll be happy to merge all patches through fbdev tree
(if Greg is fine with it and ACKs drivers/usb/ parts)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

