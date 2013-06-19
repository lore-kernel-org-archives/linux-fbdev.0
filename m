From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Wed, 19 Jun 2013 17:10:52 +0000
Subject: Re: [RFC PATCH 3/5] video: exynos_dsi: Use generic PHY driver
Message-Id: <51C1E61C.8030808@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371231951-1969-1-git-send-email-s.nawrocki@samsung.com>
 <1371231951-1969-4-git-send-email-s.nawrocki@samsung.com>
 <1502179.yCdHZgQgqV@flatron>
In-Reply-To: <1502179.yCdHZgQgqV@flatron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 06/16/2013 11:15 PM, Tomasz Figa wrote:
> On Friday 14 of June 2013 19:45:49 Sylwester Nawrocki wrote:
>> > Use the generic PHY API instead of the platform callback to control
>> > the MIPI DSIM DPHY.
>> > 
>> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> > ---
>> >  drivers/video/display/source-exynos_dsi.c |   36
>> > +++++++++-------------------- include/video/exynos_dsi.h               
>> > |    5 ----
>> >  2 files changed, 11 insertions(+), 30 deletions(-)
>
> Yes, this is what I was really missing a lot while developing this driver.
> 
> Definitely looks good! It's a shame we don't have this driver in mainline 
> yet ;)

Yes, I should have mentioned in the cover letter this patch depends
on modified version of this [1] patch set of yours. I'll drop this
patch and will update the driver staying in mainline now, but I won't
be able to test it, on a non-dt platform.

I guess even some pre-eliminary display (panel) API would be helpful.
The CDF development seems to have been stalled for some time. I wonder
if we could first have something that works for limited set of devices
and be extending it gradually, rather than living with zero support
for displays on DT based ARM platforms.

[1] http://www.spinics.net/lists/linux-fbdev/msg09689.html

Regards,
Sylwester
