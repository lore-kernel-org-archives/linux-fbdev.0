From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 11 Jan 2019 12:45:09 +0000
Subject: Re: [PATCH] Fix stack memory disclosure
Message-Id: <8ae8354f-a197-2ee1-d056-ccbac02028cb@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190106075408.58405-1-vlad@tsyrklevich.net>
        <CGME20190108234243epcas4p3b9ec45a771e71a0c3a3af7eeea93905d@epcas4p3.samsung.com>
        <CAGXu5jKiKA79mnTwCxTKsXBBKAvaoaX=CH61pLXdxtWQvUhhuQ@mail.gmail.com>
        <c0a93d03-f150-6363-2df7-b2dec8a8638a@samsung.com>
In-Reply-To: <c0a93d03-f150-6363-2df7-b2dec8a8638a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook@chromium.org>, Vlad Tsyrklevich <vlad@tsyrklevich.net>
Cc: linux-fbdev@vger.kernel.org, Security Officers <security@kernel.org>, LKML <linux-kernel@vger.kernel.org>


On 01/10/2019 04:10 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 01/09/2019 12:41 AM, Kees Cook wrote:
>> On Sat, Jan 5, 2019 at 11:51 PM Vlad Tsyrklevich <vlad@tsyrklevich.net> wrote:
>>>
>>> Using [1] for static analysis I found that the OMAPFB_QUERY_PLANE,
>>> OMAPFB_GET_COLOR_KEY, OMAPFB_GET_DISPLAY_INFO, and OMAPFB_GET_VRAM_INFO
>>> cases could all leak uninitialized stack memory--either due to
>>> uninitialized padding or 'reserved' fields.
>>>
>>> Fix them by clearing the shared union used to store copied out data.
>>>
>>> [1] https://github.com/vlad902/kernel-uninitialized-memory-checker
>>>
>>> Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Fixes: b39a982ddecf ("OMAP: DSS2: omapfb driver")
> 
> Thanks.
> 
>> Since this driver is orphaned (according to MAINTAINERS), I think this
>> fix should go via Bart's tree. Bart, can you take this?
> 
> Sure, I will merge it tomorrow (I plan to send fbdev fixes pull request to
> Linus next week).

Patch queued for 5.0 (with patch subject prefixed with "omap2fb: "), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
