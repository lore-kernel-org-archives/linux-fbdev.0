From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Sat, 19 Oct 2013 12:41:46 +0000
Subject: Re: [PATCH] tmio: call tmiofb_set_par in tmiofb_probe
Message-Id: <CALT56yP7xUh2OajGwfe=HyRjuYOm2DKCNv2DVrJn373wS52baw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382003443-5044-1-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1382003443-5044-1-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Oct 19, 2013 at 2:48 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 13:50 Thu 17 Oct     , Dmitry Eremin-Solenikov wrote:
>> Call tmiofb_set_par() to initlaize fixed variable before registering
>> framebuffer. This is necessary for current kexecboot.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>>  drivers/video/tmiofb.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
>> index deb8733..69fd0f7 100644
>> --- a/drivers/video/tmiofb.c
>> +++ b/drivers/video/tmiofb.c
>> @@ -774,6 +774,10 @@ static int tmiofb_probe(struct platform_device *dev)
>>       if (retval)
>>               goto err_hw_init;
>>
>> +     retval = tmiofb_set_par(info);
>> +     if (retval)
>> +             goto err_set_par;
>> +
>
> sorry no fix kexecboot

So calling set_par in _probe() is deprecated/fromn upon? Why?

-- 
With best wishes
Dmitry
