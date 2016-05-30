From: Rongrong Zou <zourongrong@huawei.com>
Date: Mon, 30 May 2016 03:11:38 +0000
Subject: Re: [path v2 0/7] Add DRM driver for Hisilicon Hibmc
Message-Id: <574BAF6A.9040208@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1464514855-108050-1-git-send-email-zourongrong@gmail.com>
 <CAGd==0662wa-mAdX+tUf9_Tw6qQhc0-D5ivSYdRBS=OrqAVYnA@mail.gmail.com>
In-Reply-To: <CAGd==0662wa-mAdX+tUf9_Tw6qQhc0-D5ivSYdRBS=OrqAVYnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Xinliang Liu <xinliang.liu@linaro.org>, Rongrong Zou <zourongrong@gmail.com>
Cc: David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, lijianhua@huawei.com, dri-devel <dri-devel@lists.freedesktop.org>, Hanjun Guo <guohanjun@huawei.com>, majun258@huawei.com, Linuxarm <linuxarm@huawei.com>, LAKML <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org

Hi Xinliang

在 2016/5/30 11:01, Xinliang Liu 写道:
> Hi Rongrong,
>
> It seems that you haven't run the checkpatch script.
> Please run this script to check your patches before you send them. Like bellow:
> $ cd yourkerneldir
> $ ./scripts/checkpatch.pl --strict yourpatches

I run checkpatch.pl without "--strict", and i'll check again with
this parameter, thanks!

>
> Thanks,
> -xinliang
>
> On 29 May 2016 at 17:40, Rongrong Zou <zourongrong@gmail.com> wrote:
>> This patch set adds a new drm driver for Hisilicon Hibmc. Hibmc is a
>> base board management controller, usually it is used on server for
>> Out-of-band management purpose. In this patch set, we just support basic
>> function for Hibmc display subsystem. Hibmc display subsystem is connected
>> to host CPU by PCIe as blow:
>>
>> +----------+       +----------+
>> |          | PCIe  |  Hibmc   |
>> |host CPU( |<----->| display  |
>> |arm64,x86)|       |subsystem |
>> +----------+       +----------+
>>
>> Hardware Detail for Hibmc display subsystem
>> -----------
>>
>>    The display subsystem of Hibmc is show as bellow:
>>    +----+      +----+      +----+     +--------+
>>    |    |      |    |      |    |     |        |
>>    | FB |----->| DE |----->|VDAC|---->|external|
>>    |    |      |    |      |    |     | VGA    |
>>    +----+      +----+      +----+     +--------+
>>
>>    -DE(Display Engine) is the display controller.
>>    -VDAC(Video Digital-to-Analog converter) converts the RGB diaital data
>>    stream from DE to VGA analog signals.
>>
>> Change History
>> ------------
>>
>> Changes in v2:
>>    -Remove self-defined macros for bit operations.
>>    -Remove unused register.
>>    -Replace those deprecated functions with new version of them.
>>    -use drm_connector_register_all() to register connector after
>>     drm_dev_register().
>>
>> The patch v1 is at
>> https://lists.freedesktop.org/archives/dri-devel/2016-February/101921.html
>> Sorry for too late sending.
>>
>>
>> Rongrong Zou (7):
>>    idrm/hisilicon/hibmc: Add hisilicon hibmc drm master driver
>>    drm/hisilicon/hibmc: Add plane for DE
>>    drm/hisilicon/hibmc: Add crtc for DE
>>    drm/hisilicon/hibmc: Add encoder for VDAC
>>    drm/hisilicon/hibmc: Add connector for VDAC
>>    drm/hisilicon/hibmc: Add support for frame buffer
>>    drm/hisilicon/hibmc: Add maintainer for Hibmc DRM
>>
>>   MAINTAINERS                                       |   7 +
>>   drivers/gpu/drm/hisilicon/Kconfig                 |   1 +
>>   drivers/gpu/drm/hisilicon/Makefile                |   3 +-
>>   drivers/gpu/drm/hisilicon/hibmc/Kconfig           |  13 +
>>   drivers/gpu/drm/hisilicon/hibmc/Makefile          |   4 +
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 477 ++++++++++++++++++++++
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h    |  29 ++
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 399 ++++++++++++++++++
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  64 +++
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c | 286 +++++++++++++
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.c |  91 +++++
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.h |  28 ++
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h  | 214 ++++++++++
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 174 ++++++++
>>   14 files changed, 1789 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/Kconfig
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/Makefile
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.c
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.h
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>>
>> --
>> 1.9.1
>>
>
> .
>


-- 
Regards,
Rongrong
