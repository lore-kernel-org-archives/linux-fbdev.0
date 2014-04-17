From: DaeSeok Youn <daeseok.youn@gmail.com>
Date: Thu, 17 Apr 2014 00:00:54 +0000
Subject: Re: [PATCH] fbdev: fix possible NULL pointer derefernce
Message-Id: <CAHb8M2BdDUJBOsFdDXOKSo2p+=_Gb4Ha92UMa5K6wMyg3KKdmw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140416094034.GA18082@devel>
	<6A3BE65E-93FD-4E22-A55E-49E54E435558@jcrosoft.com>
In-Reply-To: <6A3BE65E-93FD-4E22-A55E-49E54E435558@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: tomi.valkeinen@ti.com, jg1.han@samsung.com, laurent.pinchart@ideasonboard.com, Rob Clark <robdclark@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Hello,

2014-04-16 21:38 GMT+09:00 Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com>:
>
> On Apr 16, 2014, at 5:40 PM, Daeseok Youn <daeseok.youn@gmail.com> wrote:
>
>>
>> The spec->modedb can be NULL by fb_create_modedb().
>>
>> And also smatch says:
>> drivers/video/fbdev/core/fbmon.c:975 fb_edid_to_monspecs() error:
>> potential null dereference 'specs->modedb'.
>> (fb_create_modedb returns null)
>>
>> Signed-off-by: Daeseok Youn <daeseok.youn@gmail.com>
>> ---
>> drivers/video/fbdev/core/fbmon.c |    3 +++
>> 1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
>> index c204ebe..db274ca 100644
>> --- a/drivers/video/fbdev/core/fbmon.c
>> +++ b/drivers/video/fbdev/core/fbmon.c
>> @@ -966,6 +966,9 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
>>
>>       specs->modedb = fb_create_modedb(edid, &specs->modedb_len);
>>
>> +     if (!specs->modedb)
>> +             return;
>> +
>
> we need to return an error and trace it
Yes, you're right. I will change return type from void to int and add
to handle an error when this function(fb_edid_to_monspecs) is called.

I will send this patch as your comment.

Thanks for review.

Daeseok Youn.
>
> Best Regards,
> J.
>>       /*
>>        * Workaround for buggy EDIDs that sets that the first
>>        * detailed timing is preferred but has not detailed
>> --
>> 1.7.4.4
>>
>
