From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Jan 2020 12:22:47 +0000
Subject: Re: [PATCH] fbdev: matrox: make array wtst_xlat static const, makes object smaller
Message-Id: <fce5c5cc-bbb3-40a9-27fe-90957d25e7fe@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190906181114.31414-1-colin.king@canonical.com>
 <CGME20190906181721epcas4p4be0f813e9da4d8e386b7a1c0b2ab1da7@epcas4p4.samsung.com>
 <20190906181714.GU7482@intel.com>
In-Reply-To: <20190906181714.GU7482@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Colin King <colin.king@canonical.com>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 9/6/19 8:17 PM, Ville Syrjälä wrote:
> On Fri, Sep 06, 2019 at 07:11:14PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Don't populate the array wtst_xlat on the stack but instead make it
>> static const. Makes the object code smaller by 89 bytes.
>>
>> Before:
>>    text	   data	    bss	    dec	    hex	filename
>>   14347	    840	      0	  15187	   3b53	fbdev/matrox/matroxfb_misc.o
>>
>> After:
>>    text	   data	    bss	    dec	    hex	filename
>>   14162	    936	      0	  15098	   3afa	fbdev/matrox/matroxfb_misc.o
>>
>> (gcc version 9.2.1, amd64)
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, patch queued for v5.6 (also sorry for the delay).

>> ---
>>  drivers/video/fbdev/matrox/matroxfb_misc.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/matrox/matroxfb_misc.c b/drivers/video/fbdev/matrox/matroxfb_misc.c
>> index c7aaca12805e..feb0977c82eb 100644
>> --- a/drivers/video/fbdev/matrox/matroxfb_misc.c
>> +++ b/drivers/video/fbdev/matrox/matroxfb_misc.c
>> @@ -673,7 +673,10 @@ static int parse_pins5(struct matrox_fb_info *minfo,
>>  	if (bd->pins[115] & 4) {
>>  		minfo->values.reg.mctlwtst_core = minfo->values.reg.mctlwtst;
>>  	} else {
>> -		u_int32_t wtst_xlat[] = { 0, 1, 5, 6, 7, 5, 2, 3 };
>> +		static const u_int32_t wtst_xlat[] = {
>> +			0, 1, 5, 6, 7, 5, 2, 3
> 
> All of those would easily fit in u8 as well.

Good idea, I've converted the table to u8 while applying the patch.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>> +		};
>> +
>>  		minfo->values.reg.mctlwtst_core = (minfo->values.reg.mctlwtst & ~7) |
>>  						  wtst_xlat[minfo->values.reg.mctlwtst & 7];
>>  	}
>> -- 
>> 2.20.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
