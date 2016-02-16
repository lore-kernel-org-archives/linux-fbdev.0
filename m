From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Date: Tue, 16 Feb 2016 16:01:00 +0000
Subject: Re: [PATCH resend] video: Use bool instead int pointer for get_opt_bool() argument
Message-Id: <56C347BC.7000005@bmw-carit.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1455009512-26806-1-git-send-email-daniel.wagner@bmw-carit.de>
 <56C320B8.1070900@ti.com>
In-Reply-To: <56C320B8.1070900@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Maik Broemme <mbroemme@plusserver.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/16/2016 02:14 PM, Tomi Valkeinen wrote:
> 
> On 09/02/16 11:18, Daniel Wagner wrote:
>> As the function name already indicates that get_opt_bool() parses
>> for a bool. It is not a surprise that compiler is complaining
>> about it when -Werror=incompatible-pointer-types is used:
>>
>> drivers/video/fbdev/intelfb/intelfbdrv.c: In function ‘intelfb_setup’:
>> drivers/video/fbdev/intelfb/intelfbdrv.c:353:39: error: passing argument 3 of ‘get_opt_bool’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>>    if (get_opt_bool(this_opt, "accel", &accel))
>>
>> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
>> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
>> ---
>> [resend because Maik's emial address bounced last try]
>>
>> Hi,
>>
>> In the 'simple wait queue support' series is a patch
>> which turns on -Werror=incompatible-pointer-types which will
>> result in a compile error for intelfb.
>>
>> https://lkml.org/lkml/2016/1/28/462
>>
>> Even if that patch wont make it, this one makes sense (at least
>> for me :))
>>
>> I'll prepend this patch to the next version of the series in order
>> to see if I got rid of all incompatible pointer types errors caught
>> by the kbuild test robot.
> 
> The patch looks good to me, but I didn't quite catch the above. So do
> you want me to apply this to fbdev tree, or do you need to take this via
> some other tree? If the latter, you have my ack.

I don't have any preference on the routing. So if you take it via fbdev
that would be nice. One thing less to care about :)

thanks,
daniel
