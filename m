From: Alexander Shiyan <shc_work@mail.ru>
Date: Thu, 24 Apr 2014 05:03:38 +0000
Subject: Re: [PATCH v2 1/3] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <20140424090338.9f8edcf7803a17ff3fc6a375@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, 12 Apr 2014 10:53:02 +0400
Alexander Shiyan <shc_work@mail.ru> wrote:

Ping.

> This adds support for the framebuffer available in the Cirrus
> Logic CLPS711X CPUs.
> FB features:
> - 1-2-4 bits per pixel.
> - Programmable panel size to a maximum of 1024x256 at 4 bps.
> - Relocatible Frame Buffer (SRAM or SDRAM).
> - Programmable refresh rates.
> - 16 gray scale values.
> This new driver supports usage with devicetree and as a general
> change it removes last user of <mach/hardware.h> for CLPS711X targets,
> so this subarch will fully prepared to switch to multiplatform.
> The driver have been tested with custom board equipped Cirrus Logic
> EP7312 in DT and non-DT mode.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

...

-- 
Alexander Shiyan <shc_work@mail.ru>
