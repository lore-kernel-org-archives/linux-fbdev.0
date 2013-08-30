From: Chen Gang <gang.chen@asianux.com>
Date: Fri, 30 Aug 2013 08:17:52 +0000
Subject: Re: [PATCH] drivers: video: i740fb: add 'default' processing contents for 'switch'.
Message-Id: <52205530.4090805@asianux.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51ECF12D.8060903@asianux.com>
In-Reply-To: <51ECF12D.8060903@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On 08/30/2013 03:21 PM, Tomi Valkeinen wrote:
> On 22/07/13 11:45, Chen Gang wrote:
>> Need add related 'default' processing contents for 'switch', or may
>> report 'wm' uninitialized warning.
>>
>> The related warning:
>>
>>   drivers/video/i740fb.c:662:26: warning: �wm� may be used uninitialized in this function [-Wmaybe-uninitialized]
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  drivers/video/i740fb.c |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/i740fb.c b/drivers/video/i740fb.c
>> index 6c48388..e82e767 100644
>> --- a/drivers/video/i740fb.c
>> +++ b/drivers/video/i740fb.c
>> @@ -336,6 +336,9 @@ static u32 i740_calc_fifo(struct i740fb_par *par, u32 freq, int bpp)
>>  				wm = 0x16110000;
>>  		}
>>  		break;
>> +	default:
>> +		wm = 0;
>> +		BUG();
>>  	}
> 
> I don't think you should use BUG there. BUG should be used when there's
> not really a good way to continue. Here you could have just a WARN, and
> return some default FIFO watermark value.
> 

i740_calc_fifo() is a static function, so we can check its caller's
information to find the suitable fixing ways (for extern function, we
almost can not do like this).

it has only one caller i740fb_decode_var(), which has already let 'bpp'
within the values (8, 15, 16, 24, 32). So if another values occurs, it
must be a BUG (e.g. the stack may override under ia32).


Hmm... it really has quite a few same cases in kernel wide like our
case, but at least they do not report warnings (this does not like our
case), so let just fix our case to satisfy the compiler. :-)

>  Tomi
> 
> 

Thanks.
-- 
Chen Gang
