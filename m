From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 09 Jan 2011 23:19:18 +0000
Subject: Re: [PATCH] video: imx: Update the manufacturer name
Message-Id: <AANLkTikeX3Yih3usYH68S=d2yRMjK_LJ=xizKRUh=VJJ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294590818-5001-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1294590818-5001-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Hi Uwe,

2011/1/9 Uwe Kleine-König <u.kleine-koenig@pengutronix.de>:
> Hello Fabio,
>
> On Sun, Jan 09, 2011 at 02:33:38PM -0200, Fabio Estevam wrote:
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>>  drivers/video/Kconfig |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>> index 55dc6fb..0ac30ef 100644
>> --- a/drivers/video/Kconfig
>> +++ b/drivers/video/Kconfig
>> @@ -414,7 +414,7 @@ config FB_SA1100
>>         Y here.
>>
>>  config FB_IMX
>> -     tristate "Motorola i.MX LCD support"
>> +     tristate "Freescale i.MX LCD support"
> do you have an explanation why this is wrong?  Was it a copy&paste
> error?  If it used to be correct I'd prefer to keep Motorola in there.

The reason is that there exists no "Motorola i.MX" anymore.

Freescale is the company that manufactures the i.MX processors
currently, not Motorola.

Motorola used to manufacture i.MX devices until 2004. After the
spin-off in 2004, Freescale continued as the i.MX manufacturer.

Also, if you look at the first submission of the i.MX framebuffer
driver from Sascha (imxfb: Add Freescale i.MX framebuffer driver -
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h|2f891cb64b0b9c8d389da97c221ee4288f1307)
it contains the correct name there ,so this patch makes the driver
selection consistent.

Regards,

Fabio Estevam
