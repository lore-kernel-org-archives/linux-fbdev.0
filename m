From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 03 Nov 2016 09:25:51 +0000
Subject: Re: [PATCH] video: ARM CLCD: fix Vexpress regression
Message-Id: <CACRpkdYB=9PdRo9ChPAijLBRcJ5ezSN5rrhf6Si51bfFF1Z4dg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>
 <f95e05ef-e8e0-c5f4-9635-ae392c1812a3@ti.com>
In-Reply-To: <f95e05ef-e8e0-c5f4-9635-ae392c1812a3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Nov 2, 2016 at 9:34 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 20/10/16 09:46, Linus Walleij wrote:
>> The CLCD does not come up on Versatile Express as it does not
>> (currently) have a syscon node for controlling the block apart
>> from the CLCD itself. Make sure the .init() function can bail
>> out without an error making it probe again.
>>
>> Reported-by: Amit Pundir <amit.pundir@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  drivers/video/fbdev/amba-clcd-versatile.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/amba-clcd-versatile.c b/drivers/video/fbdev/amba-clcd-versatile.c
>> index 19ad8645d93c..d909b7dda14d 100644
>> --- a/drivers/video/fbdev/amba-clcd-versatile.c
>> +++ b/drivers/video/fbdev/amba-clcd-versatile.c
>> @@ -527,7 +527,8 @@ int versatile_clcd_init_panel(struct clcd_fb *fb,
>>                                            &clcd_id);
>>       if (!np) {
>>               dev_err(dev, "no Versatile syscon node\n");
>> -             return -ENODEV;
>> +             /* Vexpress does not have this */
>> +             return 0;
>>       }
>>       versatile_clcd_type = (enum versatile_clcd)clcd_id->data;
>
> Actually, the above doesn't look correct. If this is not an error, then
> the driver shouldn't print an error.
>
> Shall I just remove the print?

You're right, sorry for not thinking deeper :(

Just cut the print.

Thanks!

Yours,
Linus Walleij
