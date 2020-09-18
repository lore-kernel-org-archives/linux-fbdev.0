From: Jing Xiangfeng <jingxiangfeng@huawei.com>
Date: Fri, 18 Sep 2020 00:52:02 +0000
Subject: Re: [PATCH] fbcon: Remove the superfluous break
Message-Id: <5F6404B2.3080602@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200917131515.147029-1-jingxiangfeng@huawei.com>
 <86015b42-1f87-9f0c-cb34-9d30e8da98a4@embeddedor.com>
In-Reply-To: <86015b42-1f87-9f0c-cb34-9d30e8da98a4@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, b.zolnierkie@samsung.com, gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch, jirislaby@kernel.org, ndesaulniers@google.com, natechancellor@gmail.com, george.kennedy@oracle.com, peda@axentia.se
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org



On 2020/9/18 2:52, Gustavo A. R. Silva wrote:
>
>
> On 9/17/20 08:15, Jing Xiangfeng wrote:
>> Remove the superfuous break, as there is a 'return' before it.
>>
>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> Also, the following Fixes tag should be included in the changelog text:
>
> Fixes: bad07ff74c32 ("fbcon: smart blitter usage for scrolling")

OK, I'll send a v2 with this tag.

>
> Thanks
> --
> Gustavo
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
>>   				    vc->vc_video_erase_char,
>>   				    vc->vc_size_row * count);
>>   			return true;
>> -			break;
>>
>>   		case SCROLL_WRAP_MOVE:
>>   			if (b - t - count > 3 * vc->vc_rows >> 2) {
>> @@ -1818,7 +1817,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>>   				    vc->vc_video_erase_char,
>>   				    vc->vc_size_row * count);
>>   			return true;
>> -			break;
>>
>>   		case SCROLL_WRAP_MOVE:
>>   			if (b - t - count > 3 * vc->vc_rows >> 2) {
>>
> .
>
