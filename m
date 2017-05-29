From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 29 May 2017 09:23:16 +0000
Subject: Re: [PATCH 2/2] video: adp8870: move header file out of I2C realm
Message-Id: <1674548.6H3ihMLElO@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170521220953.2602-1-wsa@the-dreams.de>
        <CGME20170521220958epcas1p30bab0556e81fe48cff9f65b09177dd9c@epcas1p3.samsung.com>
        <20170521220953.2602-3-wsa@the-dreams.de>
In-Reply-To: <20170521220953.2602-3-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Steven Miao <realmz6@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Monday, May 22, 2017 12:09:53 AM Wolfram Sang wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  arch/blackfin/mach-bf537/boards/stamp.c        | 2 +-
>  drivers/video/backlight/adp8870_bl.c           | 2 +-
>  include/linux/{i2c => platform_data}/adp8870.h | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename include/linux/{i2c => platform_data}/adp8870.h (100%)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

