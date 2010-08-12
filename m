From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 12 Aug 2010 20:14:21 +0000
Subject: Re: [PATCH] s3fb: add DDC support
Message-Id: <20100812131421.bb2839f8.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201008112218.11535.linux@rainbow-software.org>
In-Reply-To: <201008112218.11535.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Ondrej Zajicek <santiago@crfreenet.org>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Wed, 11 Aug 2010 22:18:09 +0200
Ondrej Zary <linux@rainbow-software.org> wrote:

> Add I2C support for the DDC bus to s3fb driver. This is only bus support,
> driver does not use EDID.
> 
> Tested on Trio64V+, Trio64V2/DX, Virge (2 cards), Virge/DX (4 cards) and
> Trio3D/2X (3 cards) with i2cdetect and decode-edid.
> 
> Will probably not work on Trio32 - my 2 cards have DDC support in BIOS that
> looks different from the other cards but the DDC pins on the VGA connector
> are not connected.
> 
> Virge/GX, Virge/GX2 and Virge/VX are untested.
> 
> ...
>
> +#ifdef CONFIG_FB_S3_DDC

Now please send us the drivers/video/Kconfig hunk as well ;)

FB_S3_DDC might need to depend on I2C.
