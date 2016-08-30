From: moshe green <mgmoshes@gmail.com>
Date: Tue, 30 Aug 2016 19:42:31 +0000
Subject: Re: [PATCH 7/9] staging: sm750fb: fix block comment style issues in ddk750_chip.c
Message-Id: <CAJEcRgosrA+q9u6NMNJGR5XCA+Gy-SEMc51GcOry6URcoB4NJQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
 <ad80e695e9730861466d5960359b06af27ca7c30.1472583825.git.mgmoshes@gmail.com> <1472584763.5512.119.camel@perches.com>
In-Reply-To: <1472584763.5512.119.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Will do.
Thanks

On 30 August 2016 at 22:19, Joe Perches <joe@perches.com> wrote:
> On Tue, 2016-08-30 at 22:05 +0300, Moshe Green wrote:
>> Fix block comment * prefix and trailing */ warnings found
>> by the checkpatch.pl tool in ddk750_chip.c.
> []
>> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> []
>> @@ -320,8 +320,10 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
>>       int max_d = 6;
>>
>>       if (getChipType() = SM750LE) {
>> -             /* SM750LE don't have prgrammable PLL and M/N values to work on.
>> -             Just return the requested clock. */
>> +             /* SM750LE don't have
>> +              * prgrammable PLL and M/N values to work on
>
> Might as well fix the programmable typo too.
>
