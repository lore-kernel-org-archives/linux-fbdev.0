From: Pawel Osciak <p.osciak@samsung.com>
Date: Fri, 02 Jul 2010 14:53:54 +0000
Subject: RE: [PATCH v3 09/12] s3c-fb: Correct window osd size and alpha
Message-Id: <004501cb19f6$6416dbe0$2c4493a0$%osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
	<1277712538-23188-10-git-send-email-p.osciak@samsung.com>
	<4C2DE691.6050209@simtec.co.uk>
In-Reply-To: <4C2DE691.6050209@simtec.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>Ben Dooks <ben@simtec.co.uk> wrote:
>On 28/06/10 09:08, Pawel Osciak wrote:
>> S3C64xx and S5P OSD registers for OSD size and alpha are as follows:
>> VIDOSDC: win 0 - size, win 1-4: alpha
>> VIDOSDD: win 1-2 - size; not present for windows 0, 3 and 4
>>
>> Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/video/s3c-fb.c |   58 ++++++++++++++++++++++++++++++++++++++++++--
>---
>>  1 files changed, 51 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
>> index 94423c5..3b2c7fe 100644
>> --- a/drivers/video/s3c-fb.c
>> +++ b/drivers/video/s3c-fb.c
>> @@ -64,6 +64,9 @@ struct s3c_fb;
>>  #define VIDOSD_B(win, variant) (OSD_BASE(win, variant) + 0x04)
>>  #define VIDOSD_C(win, variant) (OSD_BASE(win, variant) + 0x08)
>>  #define VIDOSD_D(win, variant) (OSD_BASE(win, variant) + 0x0C)
>> +#define VIDOSD_SIZE(win, variant, win_variant) \
>> +	(OSD_BASE(win, variant) + (win_variant).osd_size_off)
>> +#define VIDOSD_ALPHA(win, variant, win_variant) VIDOSD_C(win, variant)
>
>hmm, this is becoming a bit complicated. if we have a function to
>set it then maybe we should just calculate it there.
>

>> @@ -1445,12 +1478,17 @@ static int s3c_fb_resume(struct platform_device
>*pdev)
>>  static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] __devinitdata = {
>>  	[0] = {
>>  		.has_osd_c	= 1,
>> +		.has_osd_size	= 1,
>> +		.osd_size_off	= 0x8,
>>  		.palette_sz	= 256,
>>  		.valid_bpp	= VALID_BPP1248 | VALID_BPP(16) | VALID_BPP(24),
>>  	},
>>  	[1] = {
>>  		.has_osd_c	= 1,
>>  		.has_osd_d	= 1,
>> +		.has_osd_size	= 1,
>> +		.osd_size_off	= 0x12,
>> +		.has_osd_alpha	= 1,
>
>how about osd_size_off !=0 => has_osd_size ?
>

Could be done that way, yes... I'm not aware of any SoC with osd_size_off = 0
till now.

>do we need to change the osd c and d definitions?

I'd prefer not using "OSD_C" and "OSD_D" names at all. How they are changing
their usage across hw versions and windows is confusing enough. Maybe we should
only be using osd_sizeand osd_alpha instead? Would you agree?


Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center





