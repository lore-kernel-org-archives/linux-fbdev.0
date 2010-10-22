From: Jeff Garzik <jgarzik@pobox.com>
Date: Fri, 22 Oct 2010 17:18:52 +0000
Subject: Re: [PATCH] rivafb: dubious assignment
Message-Id: <4CC1C77C.1000700@pobox.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101022133130.4cb2cb96@absol.kitzblitz> <AANLkTimAb_gjx7m6pKvYHL=SjB9DousdUJA2K9uyPt1F@mail.gmail.com>
In-Reply-To: <AANLkTimAb_gjx7m6pKvYHL=SjB9DousdUJA2K9uyPt1F@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nicolas Kaiser <nikai@nikai.net>, Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/22/2010 10:47 AM, Geert Uytterhoeven wrote:
> On Fri, Oct 22, 2010 at 13:31, Nicolas Kaiser<nikai@nikai.net>  wrote:
>> A duplicated assignment unconditionally changes max_gfsize to
>> GFIFO_SIZE.
>>
>> It looks to me like this might not be intended, or is it?
>>
>> Signed-off-by: Nicolas Kaiser<nikai@nikai.net>
>> ---
>>   drivers/video/riva/riva_hw.c |    1 -
>>   1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/video/riva/riva_hw.c b/drivers/video/riva/riva_hw.c
>> index 78fdbf5..936abfa 100644
>> --- a/drivers/video/riva/riva_hw.c
>> +++ b/drivers/video/riva/riva_hw.c
>> @@ -263,7 +263,6 @@ static int nv3_iterate(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_arb_i
>>      vmisses = 2;
>>      if (ainfo->gburst_size = 128) max_gfsize = GFIFO_SIZE_128;
>>      else  max_gfsize = GFIFO_SIZE;
>> -    max_gfsize = GFIFO_SIZE;
>>      while (1)
>>      {
>>          if (ainfo->vid_en)
>> --
>> 1.7.2.2
>
> According to full-history-linux, this comes from the initial drop in 2.3.49pre2,
> from nVidia code(?), imported by Jeff Garzik.

Yep, came straight from X.org driver code...   Patch certainly looks 
correct, but who knows but NV for sure :)


