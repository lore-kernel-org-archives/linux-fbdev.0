From: Pawel Osciak <p.osciak@samsung.com>
Date: Fri, 02 Jul 2010 14:45:03 +0000
Subject: RE: [PATCH v3 08/12] s3c-fb: Add SHADOWCON shadow register locking
Message-Id: <004401cb19f5$27b9efd0$772dcf70$%osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
	<1277712538-23188-9-git-send-email-p.osciak@samsung.com>
	<4C2DE587.6000306@simtec.co.uk>
In-Reply-To: <4C2DE587.6000306@simtec.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>Ben Dooks <ben@simtec.co.uk> wrote:
>On 28/06/10 09:08, Pawel Osciak wrote:
>> @@ -218,6 +218,9 @@
>>  #define WINCON1_BPPMODE_25BPP_A1888		(0xd << 2)
>>  #define WINCON1_BPPMODE_28BPP_A4888		(0xd << 2)
>>
>> +/* S5PV210 */
>> +#define SHADOWCON				(0x34)
>> +#define SHADOWCON_WINx_PROTECT(_win)		(1 << (10 + _win))
>
>you should have () around the _win arg.
>

Good catch, thanks.

>>
>>  #define VIDOSDxA_TOPLEFT_X_MASK			(0x7ff << 11)
>>  #define VIDOSDxA_TOPLEFT_X_SHIFT		(11)
>> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
>> index 0a93fca..94423c5 100644
>> --- a/drivers/video/s3c-fb.c
>> +++ b/drivers/video/s3c-fb.c
>> @@ -79,6 +79,7 @@ struct s3c_fb;
>>   * @osd: The base for the OSD registers.
>>   * @palette: Address of palette memory, or 0 if none.
>>   * @has_prtcon: Set if has PRTCON register.
>> + * @has_shadowcon: Set if has SHADOWCON register.
>>   */
>>  struct s3c_fb_variant {
>>  	unsigned int	is_2443:1;
>> @@ -95,6 +96,7 @@ struct s3c_fb_variant {
>>  	unsigned short	palette[S3C_FB_MAX_WIN];
>>
>>  	unsigned int	has_prtcon:1;
>> +	unsigned int	has_shadowcon:1;
>>  };
>>
>>  /**
>> @@ -363,6 +365,36 @@ static int s3c_fb_align_word(unsigned int bpp,
>unsigned int pix)
>>  }
>>
>>  /**
>> + * shadow_protect_win() - disable updating values from shadow registers at
>vsync
>> + *
>> + * @win: window to protect registers for
>> + * @protect: 1 to protect (disable updates)
>> + */
>> +static void shadow_protect_win(struct s3c_fb_win *win, int protect)
>
>technically, protect should be of type 'bool'

Well... ok, I guess it's the "new" trend ;)


Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center





