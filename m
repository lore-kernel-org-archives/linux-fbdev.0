From: Noralf Tronnes <notro@tronnes.org>
Date: Mon, 12 Jan 2015 14:30:14 +0000
Subject: Re: SSD1306 OLED driver
Message-Id: <54B3DA76.1070205@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Den 12.01.2015 10:44, skrev Ssagarr Patil:
> I got it compiled against my kernel, but not sure how to add it in my board file (My platform
> has no DT support). Should it be registered as spi slave device , I tried adding the following,
>
>      {
>          .modalias    = "fb_ssd1306",
>          .irq        = -1,
>          .max_speed_hz    = 16000000,
>          .bus_num    = 2,
>          .chip_select    = 0,
>          .mode        = SPI_MODE_0,
>      },
>
> But nothing came up how do I register ? any quick pointer would be helpful.

Copy/symlink fbtft.h to include/fbtft.h and do it like this: 
https://github.com/notro/fbtft/wiki/Build-kernel-and-fbtft-drivers#configure-devices

Or use the fbtft_device module:
https://github.com/notro/fbtft/wiki/fbtft_device
ssd1306 entry: 
https://github.com/notro/fbtft/blob/master/fbtft_device.c#L272
The values can be set/changed using module arguments.

