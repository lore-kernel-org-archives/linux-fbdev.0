From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 26 Nov 2018 14:33:08 +0000
Subject: Re: [REGRESSION PATCH] fbdev: fbmem: behave better with small rotated displays and many CPUs
Message-Id: <94947dad-2ac4-99b0-3ebd-0aba62f27d4a@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181108095347.19326-1-peda@axentia.se>
        <CGME20181126141651epcas1p346d68ff01402cea354ad4686fdbb7284@epcas1p3.samsung.com>
        <8faae5c6-ce11-99b4-4fc7-7a8925aad3e4@axentia.se>
In-Reply-To: <8faae5c6-ce11-99b4-4fc7-7a8925aad3e4@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Rosin <peda@axentia.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Fabian Frederick <ffrederick@users.sourceforge.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Geoff Levand <geoff@infradead.org>, James Simmons <jsimmons@users.sf.net>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On 11/26/2018 03:16 PM, Peter Rosin wrote:
> Ping?!

Hi,

Thank you for your patch, it will be considered for 4.21 (as it is not
a recent regression + I'm busy with other things currently).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Cheers,
> Peter
> 
> On 2018-11-08 10:54, Peter Rosin wrote:
>> Blitting an image with "negative" offsets is not working since there
>> is no clipping. It hopefully just crashes. For the bootup logo, there
>> is protection so that blitting does not happen as the image is drawn
>> further and further to the right (ROTATE_UR) or further and further
>> down (ROTATE_CW). There is however no protection when drawing in the
>> opposite directions (ROTATE_UD and ROTATE_CCW).
>>
>> Add back this protection.
>>
>> The regression is 20-odd years old but the mindless warning-killing
>> mentality displayed in commit 34bdb666f4b2 ("fbdev: fbmem: remove
>> positive test on unsigned values") is also to blame, methinks.
>>
>> Fixes: 448d479747b8 ("fbdev: fb_do_show_logo() updates")
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/video/fbdev/core/fbmem.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
>> index bb7f5f23e347..1abeb0b72455 100644
>> --- a/drivers/video/fbdev/core/fbmem.c
>> +++ b/drivers/video/fbdev/core/fbmem.c
>> @@ -435,7 +435,9 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
>>  			image->dx += image->width + 8;
>>  		}
>>  	} else if (rotate = FB_ROTATE_UD) {
>> -		for (x = 0; x < num; x++) {
>> +		u32 dx = image->dx;
>> +
>> +		for (x = 0; x < num && image->dx <= dx; x++) {
>>  			info->fbops->fb_imageblit(info, image);
>>  			image->dx -= image->width + 8;
>>  		}
>> @@ -447,7 +449,9 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
>>  			image->dy += image->height + 8;
>>  		}
>>  	} else if (rotate = FB_ROTATE_CCW) {
>> -		for (x = 0; x < num; x++) {
>> +		u32 dy = image->dy;
>> +
>> +		for (x = 0; x < num && image->dy <= dy; x++) {
>>  			info->fbops->fb_imageblit(info, image);
>>  			image->dy -= image->height + 8;
>>  		}
