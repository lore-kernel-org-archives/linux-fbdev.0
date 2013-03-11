From: "devendra.aaru" <devendra.aaru@gmail.com>
Date: Mon, 11 Mar 2013 06:16:30 +0000
Subject: Re: [PATCH 1/3] video: backlight: adp5520: fix compiler warning in adp5520_show
Message-Id: <CAHdPZaOttjyhf36Lp+Hai+0x21N25i_r30BO6YT9nj1nhaZieA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362771069-16345-1-git-send-email-devendra.aaru@gmail.com>
In-Reply-To: <1362771069-16345-1-git-send-email-devendra.aaru@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Mar 8, 2013 at 4:01 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Fri,  8 Mar 2013 14:31:07 -0500 Devendra Naga <devendra.aaru@gmail.com> wrote:
>
>> while compiling with make W=1 (gcc gcc (GCC) 4.7.2 20121109 (Red Hat 4.7.2-8))
>>
>> found the following warning
>>
>> drivers/video/backlight/adp5520_bl.c: In function ___adp5520_show___:
>> drivers/video/backlight/adp5520_bl.c:146:6: warning: variable ___error___ set but not used [-Wunused-but-set-variable]
>>
>> fixed by removing the variable
>>
>> ...
>>
>> --- a/drivers/video/backlight/adp5520_bl.c
>> +++ b/drivers/video/backlight/adp5520_bl.c
>> @@ -143,11 +143,10 @@ static int adp5520_bl_setup(struct backlight_device *bl)
>>  static ssize_t adp5520_show(struct device *dev, char *buf, int reg)
>>  {
>>       struct adp5520_bl *data = dev_get_drvdata(dev);
>> -     int error;
>>       uint8_t reg_val;
>>
>>       mutex_lock(&data->lock);
>> -     error = adp5520_read(data->master, reg, &reg_val);
>> +     adp5520_read(data->master, reg, &reg_val);
>>       mutex_unlock(&data->lock);
>>
>>       return sprintf(buf, "%u\n", reg_val);
>
> We shouldn't just ignore the error; with the code as it stands, a
> adp5520_read() failure will result in the kernel displaying
> uninitialised garbage.
>
> So it would be better to propagate the adp5520_read() return value back
> to the caller if it's negative.
>
>
> (This assumes that the i2c layer returns a sane return value - if it
> does, that would make i2c pretty unique :( We could get paranoid and
> return a hard-wired -EIO, but it would be bad of us to overwrite things
> like -ENOMEM).
>
> So I'd suggest this:
>
> --- a/drivers/video/backlight/adp5520_bl.c~video-backlight-adp5520-fix-compiler-warning-in-adp5520_show
> +++ a/drivers/video/backlight/adp5520_bl.c
> @@ -143,13 +143,15 @@ static int adp5520_bl_setup(struct backl
>  static ssize_t adp5520_show(struct device *dev, char *buf, int reg)
>  {
>         struct adp5520_bl *data = dev_get_drvdata(dev);
> -       int error;
> +       int ret;
>         uint8_t reg_val;
>
>         mutex_lock(&data->lock);
> -       error = adp5520_read(data->master, reg, &reg_val);
> +       ret = adp5520_read(data->master, reg, &reg_val);
>         mutex_unlock(&data->lock);
>
> +       if (ret < 0)
> +               return ret;
>         return sprintf(buf, "%u\n", reg_val);
>  }
>

Thanks for the suggestion, i will do the same and i will send you a
patch sooner.

or you can merge your change with my Acked By too :).

> _
>
