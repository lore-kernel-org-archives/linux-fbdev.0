From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 20 Mar 2019 20:08:06 +0000
Subject: Re: [PATCH] xen, fbfront: mark expected switch fall-through
Message-Id: <6675f2ed-6916-2be5-fb60-39c9436f53f7@embeddedor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190227205303.GA1231@embeddedor>
 <f8ff03de-9d7c-233a-cd86-37269667db0c@gmail.com>
In-Reply-To: <f8ff03de-9d7c-233a-cd86-37269667db0c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Oleksandr Andrushchenko <andr2000@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: xen-devel <xen-devel@lists.xenproject.org>, linux-fbdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Hi all,

Friendly ping:

Who can take this?

Thanks
--
Gustavo

On 2/28/19 5:51 AM, Oleksandr Andrushchenko wrote:
> +Xen-devel list
> 
> On 2/27/19 10:53 PM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>
>> This patch fixes the following warning:
>>
>> drivers/video/fbdev/xen-fbfront.c: In function ‘xenfb_backend_changed’:
>> drivers/video/fbdev/xen-fbfront.c:678:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>     if (dev->state = XenbusStateClosed)
>>        ^
>> drivers/video/fbdev/xen-fbfront.c:681:2: note: here
>>    case XenbusStateClosing:
>>    ^~~~
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> Notice that, in this particular case, the code comment is modified
>> in accordance with what GCC is expecting to find.
>>
>> This patch is part of the ongoing efforts to enable
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/video/fbdev/xen-fbfront.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
>> index 6a4bbc9e1fb0..a3d6b6db221b 100644
>> --- a/drivers/video/fbdev/xen-fbfront.c
>> +++ b/drivers/video/fbdev/xen-fbfront.c
>> @@ -677,7 +677,7 @@ static void xenfb_backend_changed(struct xenbus_device *dev,
>>       case XenbusStateClosed:
>>           if (dev->state = XenbusStateClosed)
>>               break;
>> -        /* Missed the backend's CLOSING state -- fallthrough */
>> +        /* fall through - Missed the backend's CLOSING state. */
>>       case XenbusStateClosing:
>>           xenbus_frontend_closed(dev);
>>           break;
> 
