From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 09 Jun 2020 11:58:01 +0000
Subject: Re: [Bug Report] drivers/video/fbdev/da8xx-fb.c: undefined behavior when left shifting
Message-Id: <7f7946f8-eb27-0745-6298-bd8099e43969@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200522030138eucas1p2555438440fee702f55c52980aa6111f3@eucas1p2.samsung.com>
 <BL0PR06MB45486287654FC3C2045A5655E5B40@BL0PR06MB4548.namprd06.prod.outlook.com>
In-Reply-To: <BL0PR06MB45486287654FC3C2045A5655E5B40@BL0PR06MB4548.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Changming Liu <liu.changm@northeastern.edu>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "yaohway@gmail.com" <yaohway@gmail.com>, "Lu, Long" <l.lu@northeastern.edu>


[ added TI DaVinci platform Maintainers to Cc: ]

Hi,

On 5/22/20 5:01 AM, Changming Liu wrote:
> Hi Bartlomiej,
> Greetings, it's me again, I sent you a bug report yesterday, I hope that find you well.
> 
> This time I found that in /drivers/video/fbdev/da8xx-fb.c
> function lcd_cfg_vertical_sync, there might be an undefined result by left shifting.
> 
> More specifically, in function lcd_cfg_vertical_sync, line 437. back_porch is a signed integer 
> which might come from user space. And it's logic AND with string literal 0xff. The result is then left shifted by 24 bits.
> 
> The problem is, since the logic AND produce a signed integer and the result of left shifting this signed integer
> (whose lowest 8 bits not cleared) by 24 bits is undefined when its 8th bit is 1. Similar patterns can be found in line 410 as well.
> 
> I wonder if this bug is worth fixing? This can help me understand linux and UB a lot.
> 
> Looking forward to you valuable response.

I assume that lcd_cfg_{horizontal,vertical}_sync() take parameters as
signed integers (and not unsigned ones) in order to special case "0"
value (I suppose that hardware expects all bits sets to represent
the "0" value). Sekhar/Bartosz: could you verify this?

If the above is true to get rid of undefined behaviors in the code
(BTW gcc seems to produce correct results currently, I don't know
about clang) we should add type casts in proper places, i.e:

static void lcd_cfg_horizontal_sync(int back_porch, int pulse_width,
		int front_porch)
{
	u32 reg;

	reg = lcdc_read(LCD_RASTER_TIMING_0_REG) & 0x3ff;
	reg |= (((u32)(back_porch - 1) & 0xff) << 24)
	    | (((u32)(front_porch - 1) & 0xff) << 16)
	    | (((u32)(pulse_width - 1) & 0x3f) << 10);
	lcdc_write(reg, LCD_RASTER_TIMING_0_REG);

	/*
	 * LCDC Version 2 adds some extra bits that increase the allowable
	 * size of the horizontal timing registers.
	 * remember that the registers use 0 to represent 1 so all values
	 * that get set into register need to be decremented by 1
	 */
	if (lcd_revision = LCD_VERSION_2) {
		/* Mask off the bits we want to change */
		reg = lcdc_read(LCD_RASTER_TIMING_2_REG) & ~0x780000ff;
		reg |= ((u32)(front_porch - 1) & 0x300) >> 8;
		reg |= ((u32)(back_porch - 1) & 0x300) >> 4;
		reg |= ((u32)(pulse_width - 1) & 0x3c0) << 21;
		lcdc_write(reg, LCD_RASTER_TIMING_2_REG);
	}
}

static void lcd_cfg_vertical_sync(int back_porch, int pulse_width,
		int front_porch)
{
	u32 reg;

	reg = lcdc_read(LCD_RASTER_TIMING_1_REG) & 0x3ff;
	reg |= (((u32)back_porch & 0xff) << 24)
	    | (((u32)front_porch & 0xff) << 16)
	    | (((u32)(pulse_width - 1) & 0x3f) << 10);
	lcdc_write(reg, LCD_RASTER_TIMING_1_REG);
}

Also it would be helpful to disallow negative values being passed
from user-space in fb_ioctl().

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Best regards,
> Changming Liu
> 
