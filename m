From: Rongrong Zou <zourongrong@huawei.com>
Date: Mon, 30 May 2016 03:21:54 +0000
Subject: Re: [path v2 7/7] drm/hisilicon/hibmc: Add maintainer for Hibmc DRM
Message-Id: <574BB1D2.9030409@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1464514855-108050-1-git-send-email-zourongrong@gmail.com>
 <1464514855-108050-8-git-send-email-zourongrong@gmail.com>
 <CAGd==07sV0qaDES5D5ozvkC1FDQXZ-Z9_UCNX8vO09HKBktq3w@mail.gmail.com>
In-Reply-To: <CAGd==07sV0qaDES5D5ozvkC1FDQXZ-Z9_UCNX8vO09HKBktq3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Xinliang Liu <xinliang.liu@linaro.org>, Rongrong Zou <zourongrong@gmail.com>
Cc: David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, lijianhua@huawei.com, dri-devel <dri-devel@lists.freedesktop.org>, Hanjun Guo <guohanjun@huawei.com>, majun258@huawei.com, Linuxarm <linuxarm@huawei.com>, LAKML <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org

Hi Xinliang,

在 2016/5/30 10:31, Xinliang Liu 写道:
> On 29 May 2016 at 17:40, Rongrong Zou <zourongrong@gmail.com> wrote:
>> Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
>> Signed-off-by: Jianhua Li <lijianhua@huawei.com>
>> ---
>>   MAINTAINERS | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f466673..a8a62e0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3957,6 +3957,13 @@ T:       git git://github.com/patjak/drm-gma500
>>   S:     Maintained
>>   F:     drivers/gpu/drm/gma500/
>>
>> +DRM DRIVERS FOR HIBMC
>> +M:     lijianhua <lijianhua@huawei.com>
>> +M:     Rongrong Zou <zourongrong@gmail.com>
>> +L:     dri-devel@lists.freedesktop.org
>> +S:     Maintained
>> +F:     drivers/gpu/drm/hisilicon/hibmc
>
> Please add a "/" ad the end of this line.

OK, thanks!

> And move this part into DRM DRIVERS FOR HISILICON

Can it be placed as below:

DRM DRIVERS FOR HISILICON HIBMC
M:     lijianhua <lijianhua@huawei.com>
M:     Rongrong Zou <zourongrong@gmail.com>
...

DRM DRIVERS FOR HISILICON KIRIN
M:     Xinliang Liu <z.liuxinliang@hisilicon.com>
R:     Xinwei Kong <kong.kongxinwei@hisilicon.com>
...
>
> Thanks,
> -xinliang
>
>> +
>>   DRM DRIVERS FOR HISILICON
>>   M:     Xinliang Liu <z.liuxinliang@hisilicon.com>
>>   R:     Xinwei Kong <kong.kongxinwei@hisilicon.com>
>> --
>> 1.9.1
>>
>
> .
>


-- 
Regards,
Rongrong
