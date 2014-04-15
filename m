From: Steven Miao <realmz6@gmail.com>
Date: Tue, 15 Apr 2014 06:35:06 +0000
Subject: Re: [PATCH] video: bf54x-lq043fb: fix build error
Message-Id: <CAMk6uBmxzJrbaQoiGcW2N5DtAqC16YErdd3tV5B4RP+nyNFdmA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397266245-3144-1-git-send-email-realmz6@kernel.org>
	<534BD810.3010705@ti.com>
In-Reply-To: <534BD810.3010705@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Steven Miao <realmz6@kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, bfin <adi-buildroot-devel@lists.sourceforge.net>, "open list:CAN NETWORK DRIVERS <linux-can@vger.kernel.org>, open
	list:NETWORKING DRIVERS <netdev@vger.kernel.org>, open list" <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org

Hi Tomi,

On Mon, Apr 14, 2014 at 8:44 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 12/04/14 04:30, Steven Miao wrote:
>> From: Steven Miao <realmz6@gmail.com>
>>
>> should include linux/gpio.h
>>
>> Signed-off-by: Steven Miao <realmz6@gmail.com>
>> ---
>>  drivers/video/bf54x-lq043fb.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
>> index 42b8f9d..d2b54f1 100644
>> --- a/drivers/video/bf54x-lq043fb.c
>> +++ b/drivers/video/bf54x-lq043fb.c
>> @@ -49,6 +49,7 @@
>>  #include <linux/spinlock.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/gpio.h>
>
> The driver includes <asm/gpio.h>. I think that should be removed, and
> <linux/gpio.h> should be used.
Yes, it should be removed.
>
> Can you also remove the asm/gpio.h in your patch, and see if it compiles
> fine?
I have tested it, it's fine. I'll resend the patch.
>
>  Tomi
>
>
-steven
