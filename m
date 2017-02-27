From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Mon, 27 Feb 2017 20:31:53 +0000
Subject: Re: [PATCH 5/5] staging: gdm724x: Remove unnecessary else after return
Message-Id: <CALrZqyMy3q1GOj3uDK3VpXCs4rNrX2R7WM5wHgFXQTaH-U0utA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1488219268-3006-1-git-send-email-singhalsimran0@gmail.com>
 <1488219268-3006-5-git-send-email-singhalsimran0@gmail.com> <1488224468.25838.11.camel@perches.com>
In-Reply-To: <1488224468.25838.11.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, lustre-devel@lists.lustre.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, outreachy-kernel@googlegroups.com

On Tue, Feb 28, 2017 at 1:11 AM, Joe Perches <joe@perches.com> wrote:
> On Mon, 2017-02-27 at 23:44 +0530, simran singhal wrote:
>> This patch fixes the checkpatch warning that else is not generally
>> useful after a break or return.
>
>> This was done using Coccinelle:
>> @@
>> expression e2;
>> statement s1;
>> @@
>> if(e2) { ... return ...; }
>> -else
>>          s1
> []
>> diff --git a/drivers/staging/gdm724x/gdm_endian.c b/drivers/staging/gdm724x/gdm_endian.c
> []
>> @@ -26,30 +26,26 @@ __dev16 gdm_cpu_to_dev16(struct gdm_endian *ed, u16 x)
>>  {
>>       if (ed->dev_ed = ENDIANNESS_LITTLE)
>>               return (__force __dev16)cpu_to_le16(x);
>> -     else
>> -             return (__force __dev16)cpu_to_be16(x);
>> +     return (__force __dev16)cpu_to_be16(x);
>
> again, not a checkpatch message for any of the
> suggested modified hunks.
>
So, I have to change commit message.
