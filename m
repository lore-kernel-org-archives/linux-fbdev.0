From: jett zhou <jett.zhou@gmail.com>
Date: Sun, 14 Jul 2013 03:00:25 +0000
Subject: Re: [V3 0/7] Enhance mmp display driver
Message-Id: <CACDDiy8OwYHbmYGwc0FV2NLVfu1BiUL9GYCmA2QEVVB5isFJGQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372332473-6584-1-git-send-email-jtzhou@marvell.com>
 <20130709133918.GC18477@ns203013.ovh.net>
In-Reply-To: <20130709133918.GC18477@ns203013.ovh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Jean
     As I checked the for-next branch, found patch4 and patch5 are
already applied.
     As checked on my side,  only apply patch1~patch3 and
patch6~patch7 is ok, so think you can apply them except for patch4/5.
     If there is still problem, please let me know, I will check it then.
Thanks

2013/7/9 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
> HI,
>
>         please rebase on the for-next branch as it does not apply
>
> Best Regards,
> J.
> On 19:27 Thu 27 Jun     , Jett.Zhou wrote:
>> Changelog:
>> 1 Add more comments for the mmp_display rbswap usage
>> according to Daniel's comments;
>> 2 Add fix patch for ttc_dkb on rbswap;
>> 3 Add more comments on the pitch usage and definition;
>> 4 Combine the modification on pitch of graphic and video layer
>> in one patch.
>>
>> Guoqing Li (2):
>>   video: mmp: rb swap setting update for mmp display
>>   video: mmp: optimize some register setting code
>>
>> Jett.Zhou (1):
>>   ARM: mmp: remove the legacy rbswap setting for ttc_dkb platform
>>
>> Jing Xiang (4):
>>   video: mmp: fix graphics/video layer enable/mask issue
>>   video: mmp: fix memcpy wrong size for mmp_addr issue
>>   video: mmp: calculate pitch value when fb set win
>>   video: mmp: add pitch info in mmp_win structure
>>
>>  arch/arm/mach-mmp/ttc_dkb.c     |    4 +-
>>  drivers/video/mmp/fb/mmpfb.c    |   34 +++++++++++------
>>  drivers/video/mmp/hw/mmp_ctrl.c |   79 ++++++++++++++++++++++-----------------
>>  drivers/video/mmp/hw/mmp_ctrl.h |    5 ++
>>  include/video/mmp_disp.h        |    6 +++
>>  5 files changed, 79 insertions(+), 49 deletions(-)
>>



--

----------------------------------
Best Regards
Jett Zhou
