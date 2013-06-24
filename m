From: jett zhou <jett.zhou@gmail.com>
Date: Mon, 24 Jun 2013 10:34:42 +0000
Subject: Re: [V2 5/7] video: mmp: add pitch info in mmp_win structure
Message-Id: <CACDDiy9CP2NyLAwCSr97yOAS50gz6HumY9cAHwO1DFRSCy9L-w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370879574-11397-1-git-send-email-jtzhou@marvell.com>
 <CAMLZHHRxS-wqd4Tb=Af6VEnfRb9MJeNo5RC7qeTLBZ0rgU69pw@mail.gmail.com>
In-Reply-To: <CAMLZHHRxS-wqd4Tb=Af6VEnfRb9MJeNo5RC7qeTLBZ0rgU69pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

2013/6/22 Daniel Drake <dsd@laptop.org>:
> On Mon, Jun 10, 2013 at 9:52 AM, Jett.Zhou <jtzhou@marvell.com> wrote:
>> From: Jing Xiang <jxiang@marvell.com>
>>
>> Add pitch length info of graphics/video layer for mmp_win, if it is
>> YUV format of video layer, u/v pitch will non-zero.
>>
>> Signed-off-by: Jing Xiang <jxiang@marvell.com>
>> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
>> ---
>>  include/video/mmp_disp.h |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/video/mmp_disp.h b/include/video/mmp_disp.h
>> index b9dd1fb..462e3bd 100644
>> --- a/include/video/mmp_disp.h
>> +++ b/include/video/mmp_disp.h
>> @@ -91,6 +91,11 @@ struct mmp_win {
>>         u16     up_crop;
>>         u16     bottom_crop;
>>         int     pix_fmt;
>> +       /*
>> +        * pitch[0]: graphics/video layer line length or y pitch
>> +        * pitch[1]/pitch[2]: video u/v pitch if non-zero
>> +        */
>> +       u32     pitch[3];
>>  };
>
> Thanks for adding a comment here, but the meaning of this field is
> still not clear to me.
> In what case is pitch[0] line length, and in which case does it refer
> to y pitch?
>
> pitch[1] and pitch[2] refer to u/v pitch respectively, if their own
> values are non-zero? (or if not, what value does the "if non-zero"
> comment refer to?)
>
> I would recommend rolling this patch into the patch that actually
> makes use of this new field.
>
> Daniel
Hi Daniel
    pitch is used to represent line length in byte, the usage depends
on pix_fmt.
    If the fmt is YUV , the pitch[0] will be Y length, pitch[1] will
be U length, pitch[2] will be V lenth.
    If the fmt is RGB, the picth[0] will be line lenth, and
pitch[1]/pitch[2] will be 0 and not be used.
    You can refer to pixfmt_to_stride func implementation.
    For the patch rolling, do you mean combine the patch5 and patch6
by one patch?
Thanks


--

----------------------------------
Best Regards
Jett Zhou
