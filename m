From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 10 Jan 2019 15:10:42 +0000
Subject: Re: [PATCH] Fix stack memory disclosure
Message-Id: <c0a93d03-f150-6363-2df7-b2dec8a8638a@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190106075408.58405-1-vlad@tsyrklevich.net>
        <CGME20190108234243epcas4p3b9ec45a771e71a0c3a3af7eeea93905d@epcas4p3.samsung.com>
        <CAGXu5jKiKA79mnTwCxTKsXBBKAvaoaX=CH61pLXdxtWQvUhhuQ@mail.gmail.com>
In-Reply-To: <CAGXu5jKiKA79mnTwCxTKsXBBKAvaoaX=CH61pLXdxtWQvUhhuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook@chromium.org>
Cc: Vlad Tsyrklevich <vlad@tsyrklevich.net>, linux-fbdev@vger.kernel.org, Security Officers <security@kernel.org>, LKML <linux-kernel@vger.kernel.org>


On 01/09/2019 12:41 AM, Kees Cook wrote:
> On Sat, Jan 5, 2019 at 11:51 PM Vlad Tsyrklevich <vlad@tsyrklevich.net> wrote:
>>
>> Using [1] for static analysis I found that the OMAPFB_QUERY_PLANE,
>> OMAPFB_GET_COLOR_KEY, OMAPFB_GET_DISPLAY_INFO, and OMAPFB_GET_VRAM_INFO
>> cases could all leak uninitialized stack memory--either due to
>> uninitialized padding or 'reserved' fields.
>>
>> Fix them by clearing the shared union used to store copied out data.
>>
>> [1] https://github.com/vlad902/kernel-uninitialized-memory-checker
>>
>> Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Fixes: b39a982ddecf ("OMAP: DSS2: omapfb driver")

Thanks.

> Since this driver is orphaned (according to MAINTAINERS), I think this
> fix should go via Bart's tree. Bart, can you take this?

Sure, I will merge it tomorrow (I plan to send fbdev fixes pull request to
Linus next week).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> -Kees
> 
>> Cc: security@kernel.org
>>
>> ---
>>  drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
>> index 53f93616c..8e23160ec 100644
>> --- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
>> +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
>> @@ -609,6 +609,8 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
>>
>>         int r = 0;
>>
>> +       memset(&p, 0, sizeof(p));
>> +
>>         switch (cmd) {
>>         case OMAPFB_SYNC_GFX:
>>                 DBG("ioctl SYNC_GFX\n");
>> --
>> 2.17.0
