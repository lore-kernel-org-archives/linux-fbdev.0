From: Juston Li <juston.h.li@gmail.com>
Date: Sat, 20 Jun 2015 08:07:24 +0000
Subject: Re: [PATCH v3] staging: sm750fb: use tabs for indentation
Message-Id: <CAFow2F_T4d-gkr8Ago8kvgagFwDUA_7ea67d8kcrb6O_0k+Y=w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434779457-18601-1-git-send-email-juston.h.li@gmail.com>
	<20150620074335.GB15195@sudip-PC>
In-Reply-To: <20150620074335.GB15195@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sat, Jun 20, 2015 at 12:43 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> On Fri, Jun 19, 2015 at 10:50:57PM -0700, Juston Li wrote:
>> Replace spaces with tabs for indentation to fix the checkpatch.pl warning
>> 'WARNING: please, no spaces at the start of a line'
>>
>> checkpatch doesn't catch comments indented by spaces but I fixed comments
>> adjacent to warnings as well so they would remain aligned.
>>
>> Signed-off-by: Juston Li <juston.h.li@gmail.com>
>> ---
> <snip>
>> diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.c b/drivers/staging/sm750fb/ddk750_hwi2c.c
>> index 7826376..23d6e19 100644
>> --- a/drivers/staging/sm750fb/ddk750_hwi2c.c
>> +++ b/drivers/staging/sm750fb/ddk750_hwi2c.c
>> @@ -9,71 +9,69 @@
>>  #define HWI2C_WAIT_TIMEOUT              0xF0000
>>
>>
>> -int hwI2CInit(
>> -    unsigned char busSpeedMode
>> -)
>> +int hwI2CInit(unsigned char busSpeedMode)
> but this is what you say in commit message. Please only do one type of
> change in a single patch.

Yeah, there were a couple of those changes I forgot to mention.
They were cases where there was nothing to align the lines to and it was
easier just to fix the overall code style.

It is a separate change so I'll remove the changes and resend.
I actually finished on several other  checkpatch.pl fix patches so
I'll just include this in a patchset.

Regards
Juston
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
