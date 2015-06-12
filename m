From: Juston Li <juston.h.li@gmail.com>
Date: Fri, 12 Jun 2015 10:08:57 +0000
Subject: Re: [PATCH] staging: sm750fb: fix c99 comments
Message-Id: <CAFow2F-pp3E0HfcpzZWipnW2rYhMKmWxhhGkErM9tMjfJ4g0GQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434092837-10290-1-git-send-email-juston.h.li@gmail.com>
	<20150612092103.GB18158@patagonia>
In-Reply-To: <20150612092103.GB18158@patagonia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Konrad Zapalowicz <bergo.torino@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Fri, Jun 12, 2015 at 2:21 AM, Konrad Zapalowicz
<bergo.torino@gmail.com> wrote:
>> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
>> index 8b47c1b..b2137c8 100644
>> --- a/drivers/staging/sm750fb/ddk750_chip.c
>> +++ b/drivers/staging/sm750fb/ddk750_chip.c
>> @@ -17,7 +17,7 @@ logical_chip_type_t getChipType(void)
>>       char physicalRev;
>>       logical_chip_type_t chip;
>>
>> -     physicalID = devId750;//either 0x718 or 0x750
>> +     physicalID = devId750; /* either 0x718 or 0x750 /
>
> Does the code compile? I'm worried that the above line will produce
> error as the comment block is not properly closed.
>
>  - konrad

Good catch, can't believe I missed that. I'll fix, actually test compile
this time and resend.

Regards
Juston
