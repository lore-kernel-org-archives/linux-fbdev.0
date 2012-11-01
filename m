From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 01 Nov 2012 00:45:48 +0000
Subject: RE: [PATCH 05/10] video: exynos_dp: Remove sink control to D0
Message-Id: <001f01cdb7ca$3bf8f2a0$b3ead7e0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344398064-13563-6-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1344398064-13563-6-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thursday, November 01, 2012 2:05 AM Sean Paul wrote
> 
> On Mon, Aug 20, 2012 at 5:19 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> > On Wednesday, August 08, 2012 12:54 PM Sean Paul wrote:
> >>
> >> Don't reset the sink power to D0. Removing this for three reasons:
> >>
> >> 1) It's not required in the SW link training documentation
> > OK.
> >> 2) The comment is incorrect, D0 is normal operation, not "power down"
> > OK. As you mentioned, D0 is not 'power down', 'normal operation'.
> > However, if comment is wrong, usually we fix comment, not remove it. :)
> >
> 
> The datasheet doesn't mention this step at all. Furthermore, the
> comment explains how it *should* work, so I think it's the code that
> is in error. Do you know why this code is needed?

This is not requirement of the datasheet.
Also, D0 is not necessary for Link training.

Um, this is work-around for initial development.
Newly developed panel did not work, due to pane problem,
so this work-around was added.
However, the panel problem was fixed, so this code is
not necessary.

Please replace comment as below:

According to DP spec, it is not required in the Link Training procedure.


Best regards,
Jingoo Han

> 
> >> 3) It seems to change things in the link training that causes glitches
> >
> > Um, it seems that this problem depends on LCD panel.
> > Other LCDs that I have tested do not have this kind of problem.
> > Please, modify this comment.
> >
> 
> That was a red herring, it didn't cause the glitches, just made them
> less obvious.
> 
> Sean
> 
> >>
> >> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> >> ---
> >>  drivers/video/exynos/exynos_dp_core.c |    6 ------
> >>  1 files changed, 0 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> >> index 207bd7e..1c998d9 100644
> >> --- a/drivers/video/exynos/exynos_dp_core.c
> >> +++ b/drivers/video/exynos/exynos_dp_core.c
> >> @@ -273,12 +273,6 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
> >>       for (lane = 0; lane < lane_count; lane++)
> >>               dp->link_train.cr_loop[lane] = 0;
> >>
> >> -     /* Set sink to D0 (Sink Not Ready) mode. */
> >> -     ret = exynos_dp_write_byte_to_dpcd(dp, DPCD_ADDR_SINK_POWER_STATE,
> >> -                             DPCD_SET_POWER_STATE_D0);
> >> -     if (ret)
> >> -             return ret;
> >> -
> >>       /* Set link rate and count as you want to establish*/
> >>       exynos_dp_set_link_bandwidth(dp, dp->link_train.link_rate);
> >>       exynos_dp_set_lane_count(dp, dp->link_train.lane_count);
> >> --
> >> 1.7.7.3
> >

