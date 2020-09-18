From: Jing Xiangfeng <jingxiangfeng@huawei.com>
Date: Fri, 18 Sep 2020 00:50:25 +0000
Subject: Re: [PATCH] fbcon: Remove the superfluous break
Message-Id: <5F640451.7020704@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200917131515.147029-1-jingxiangfeng@huawei.com>
 <CAKwvOdnm-PkEt6T3HqB-NYNYADth0MJkXCvFsc-_gyqRE-nmcg@mail.gmail.com>
In-Reply-To: <CAKwvOdnm-PkEt6T3HqB-NYNYADth0MJkXCvFsc-_gyqRE-nmcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, daniel.vetter@ffwll.ch, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, george.kennedy@oracle.com, Greg KH <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Nathan Chancellor <natechancellor@gmail.com>, jirislaby@kernel.org, peda@axentia.se



On 2020/9/18 1:36, Nick Desaulniers wrote:
> On Thu, Sep 17, 2020 at 6:15 AM Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:
>>
>> Remove the superfuous break, as there is a 'return' before it.
>
> superfluous (missed "l")

Thanks for correcting!
>
>>
>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Thanks for the patch; I audited the rest of the switch statements in
> this translation unit; LGTM.
>
>> ---
>>   drivers/video/fbdev/core/fbcon.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
>> index 0b49b0f44edf..623359aadd1e 100644
>> --- a/drivers/video/fbdev/core/fbcon.c
>> +++ b/drivers/video/fbdev/core/fbcon.c
>> @@ -1727,7 +1727,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>>                                      vc->vc_video_erase_char,
>>                                      vc->vc_size_row * count);
>>                          return true;
>> -                       break;
>>
>>                  case SCROLL_WRAP_MOVE:
>>                          if (b - t - count > 3 * vc->vc_rows >> 2) {
>> @@ -1818,7 +1817,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>>                                      vc->vc_video_erase_char,
>>                                      vc->vc_size_row * count);
>>                          return true;
>> -                       break;
>>
>>                  case SCROLL_WRAP_MOVE:
>>                          if (b - t - count > 3 * vc->vc_rows >> 2) {
>> --
>> 2.17.1
>>
>
>
