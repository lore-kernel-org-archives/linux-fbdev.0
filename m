From: Levente Kurusa <levex@linux.com>
Date: Mon, 16 Dec 2013 17:16:14 +0000
Subject: Re: [PATCH 3/4] backlight: lcd: call put_device if device_register fails
Message-Id: <52AF355E.3080105@linux.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386959996-7958-1-git-send-email-levex@linux.com> <1386959996-7958-4-git-send-email-levex@linux.com> <006f01cefa1a$97ea4710$c7bed530$%han@samsung.com>
In-Reply-To: <006f01cefa1a$97ea4710$c7bed530$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>, 'Andrew Morton' <akpm@linux-foundation.org>
Cc: 'LKML' <linux-kernel@vger.kernel.org>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

On 12/16/2013 05:52 AM, Jingoo Han wrote:
> On Saturday, December 14, 2013 3:40 AM, Levente Kurusa wrote:
>>
>> Currently we kfree the container of the device which failed to register.
>> This is wrong as the last reference is not given up with a put_device
>> call. Also, now that we have put_device() callen, we no longer need
>> the kfree as the new_ld->dev.release function will take care of kfreeing
>> the associated memory.
>>
>> Signed-off-by: Levente Kurusa <levex@linux.com>
> 
> (+cc Andrew Morton)
> 
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> 
> It looks good.
> According to the comment of device_register, put_device()
> should be used, instead of directly freeing.
Indeed, this is also mostly explained in [0/4]. Thanks for the Ack!
> 
[...]
> 
> Levente Kurusa,
> By the way, don't send the same mails three times, without any
> reason. It is the waste of traffic. :-(
> 

Yea, sorry about that I messed up my git's smtp config and hence most of the
messages bounced off. It didn't even reach LKML. Sorry once more.


-- 
Regards,
Levente Kurusa
