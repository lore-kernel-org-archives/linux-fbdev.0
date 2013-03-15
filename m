From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Fri, 15 Mar 2013 12:49:41 +0000
Subject: Re: [PATCH v3] drivers: video: use module_platform_driver_probe()
Message-Id: <CAHkwnC_rc4sz05_a4_3gkt=WR7cZRrtjzBySQW-PFxC+oZU1_g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363338019-13092-1-git-send-email-fabio.porcedda@gmail.com> <27269473.thyiPm2NyN@avalon>
In-Reply-To: <27269473.thyiPm2NyN@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Howells <dhowells@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Fri, Mar 15, 2013 at 1:37 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Fabio,
>
> Thank you for the patch.
>
> On Friday 15 March 2013 10:00:19 Fabio Porcedda wrote:
>> This patch converts the drivers to use the
>> module_platform_driver_probe() macro which makes the code smaller and
>> a bit simpler.
>>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>>
>> Notes:
>>     v3:
>>      - add missing drivers: amifb, atmel_lcdfb, vrfb
>>      - split patch set to each maintainer to easy up respin
>>     v2:
>>      - rebased over linux-next and remove already converted drivers
>>
>>  drivers/video/amifb.c          | 14 +-------------
>>  drivers/video/atmel_lcdfb.c    | 13 +------------
>>  drivers/video/omap2/vrfb.c     | 13 +------------
>>  drivers/video/sh_mipi_dsi.c    | 12 +-----------
>>  drivers/video/sh_mobile_hdmi.c | 12 +-----------
>>  5 files changed, 5 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
>> index 7fa1bf8..03e2de2 100644
>> --- a/drivers/video/amifb.c
>> +++ b/drivers/video/amifb.c
>> @@ -3788,19 +3788,7 @@ static struct platform_driver amifb_driver = {
>>       },
>>  };
>>
>> -static int __init amifb_init(void)
>> -{
>> -     return platform_driver_probe(&amifb_driver, amifb_probe);
>> -}
>> -
>> -module_init(amifb_init);
>> -
>> -static void __exit amifb_exit(void)
>> -{
>> -     platform_driver_unregister(&amifb_driver);
>> -}
>> -
>> -module_exit(amifb_exit);
>> +return module_platform_driver_probe(amifb_driver, amifb_probe);
>
> I think think you need a "return" here.
>
> After fixing that,

Thanks for reviewing.
I will send shortly the patch v4.

Regards
Fabio Porcedda

> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
>>  MODULE_LICENSE("GPL");
>>  MODULE_ALIAS("platform:amiga-video");
>
> --
> Regards,
>
> Laurent Pinchart
>
