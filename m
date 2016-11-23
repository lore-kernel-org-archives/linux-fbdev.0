From: Drew Fustini <drew@pdp7.com>
Date: Wed, 23 Nov 2016 20:12:28 +0000
Subject: Re: [RFC PATCH 3/3] staging: remove fbtft
Message-Id: <CAEf4M_DjhEgx9UtT73FoNUuHPjDmjuCRpN-xHU-UAcUUbeJBOg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com> <1479888193-23908-4-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1479888193-23908-4-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, linux-kernel@vger.kernel.org, Jason Kridner <jkridner@beagleboard.org>, Robert Nelson <robertcnelson@beagleboard.org>, Tony DiCola <tony@tonydicola.com>, Jason Kridner <jdk@ti.com>

On Wed, Nov 23, 2016 at 2:03 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Since the fbdev framework is in maintenance mode and all new display
> drivers should be made with the DRM framework, remove fbtft from
> staging.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

I'd request that fbtft please be kept in staging until a successor is
ready, such as Noralf's tinydrm.

fbtft is a popular way to connect small TFT LCDs over SPI to single
board computers like BeagleBone and Raspberry Pi.  It became simpler
for users to get fbtft drivers working once Thomas Petazzoni added it
to staging at the end of 2014.  I would like to avoid going back to
the scenario where the fbtft drivers have to be added as a patch
before compiling the kernel.

thanks,
drew
