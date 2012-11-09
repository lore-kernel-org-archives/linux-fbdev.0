From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 09 Nov 2012 02:41:13 +0000
Subject: Re: [PATCH] video: exynos_dp: Clean up SW link training
Message-Id: <001501cdbe23$af3129e0$0d937da0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351702475-31324-1-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1351702475-31324-1-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Friday, November 09, 2012 6:03 AM Sean Paul wrote
> 
> On Fri, Nov 2, 2012 at 10:45 AM, Sean Paul <seanpaul@chromium.org> wrote:
> > On Thu, Nov 1, 2012 at 8:48 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> >> On Friday, November 02, 2012 1:15 AM Sean Paul wrote
> >>>
> >>> On Thu, Nov 1, 2012 at 1:35 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> >>> > On Thursday, November 01, 2012 1:55 AM Sean Paul wrote
> >>> >>
> >>> >> Clean up some of the SW training code to make it more clear and reduce
> >>> >> duplicate code.
> >>> >>
> >>> >> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> >>> >> ---
> >>> >>  drivers/video/exynos/exynos_dp_core.c |  279 +++++++++++++--------------------
> >>> >>  1 files changed, 112 insertions(+), 167 deletions(-)
> >>> >>
> >>> >> Thanks for the pointer. There are still places where the code can be either
> >>> >> simplified, or duplication removed.
> >>> >
> >>> > Removing duplication is good, but don't change the Link training sequence.
> >>> > Link training sequence is very sensitive and tricky.
> >>> >
> >>>
> >>> I definitely appreciate how tricky it is :) I didn't actually change
> >>> any of the functionality from the original code.
> >>
> >> No, you changed the procedure when exynos_dp_clock_recovery_ok() fails.
> >> It is not the same with exynos_dp_get_adjust_training_lane().
> >> So, the else path at exynos_dp_process_clock_recovery() should not be
> >> changed.
> >>
> >>>
> >>> I noticed you made a couple of functional changes in your clean-up
> >>> patch (http://www.spinics.net/lists/linux-fbdev/msg06849.html). I
> >>> assumed that these functional changes were no-ops since bug fixes
> >>> would have gone in separate patches.
> >>>
> >>> I've also done a fair bit of testing to ensure it works.
> >>
> >> Yes, I know.
> >> But, most panels does NOT make the problem,
> >> even though there is a bug.
> >>
> >> With your panel, exynos_dp_clock_recovery_ok() does not fail,
> >> so, the problem does NOT happen.
> >>
> >>>
> >>> > I will modify your patch and I will submit new patch.
> >>> >
> >>>
> >>> More comments below.
> >>>
> >>> > Best regards,
> >>> > Jingoo Han
> >>> >
> >>> >>
> >>> >> Below is a rebased patch for your review.
> >>> >>
> >>> >> Sean
> >>> >>
> >>> >>
> >>> >> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> >>> >> index 44820f2..b126e8a 100644
> >>> >> --- a/drivers/video/exynos/exynos_dp_core.c
> >>> >> +++ b/drivers/video/exynos/exynos_dp_core.c
> >>> >> @@ -276,7 +276,7 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
> >>> >>
> >>> >>       /* Set sink to D0 (Sink Not Ready) mode. */
> >>> >>       retval = exynos_dp_write_byte_to_dpcd(dp, DPCD_ADDR_SINK_POWER_STATE,
> >>> >> -                             DPCD_SET_POWER_STATE_D0);
> >>> >> +                     DPCD_SET_POWER_STATE_D0);
> >>> >>       if (retval)
> >>> >>               return retval;
> >>> >>
> >>> >> @@ -301,17 +301,18 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
> >>> >>       exynos_dp_set_training_pattern(dp, TRAINING_PTN1);
> >>> >>
> >>> >>       /* Set RX training pattern */
> >>> >> -     exynos_dp_write_byte_to_dpcd(dp,
> >>> >> -             DPCD_ADDR_TRAINING_PATTERN_SET,
> >>> >> -             DPCD_SCRAMBLING_DISABLED |
> >>> >> -             DPCD_TRAINING_PATTERN_1);
> >>> >> +     retval = exynos_dp_write_byte_to_dpcd(dp,
> >>> >> +                     DPCD_ADDR_TRAINING_PATTERN_SET,
> >>> >> +                     DPCD_SCRAMBLING_DISABLED | DPCD_TRAINING_PATTERN_1);
> >>> >> +     if (retval)
> >>> >> +             return retval;
> >>> >>
> >>> >>       for (lane = 0; lane < lane_count; lane++)
> >>> >>               buf[lane] = DPCD_PRE_EMPHASIS_PATTERN2_LEVEL0 |
> >>> >>                           DPCD_VOLTAGE_SWING_PATTERN1_LEVEL0;
> >>> >> -     retval = exynos_dp_write_bytes_to_dpcd(dp,
> >>> >> -             DPCD_ADDR_TRAINING_LANE0_SET,
> >>> >> -             lane_count, buf);
> >>> >> +
> >>> >> +     retval = exynos_dp_write_bytes_to_dpcd(dp, DPCD_ADDR_TRAINING_LANE0_SET,
> >>> >> +                     lane_count, buf);
> >>> >>
> >>> >>       return retval;
> >>> >>  }
> >>> >> @@ -337,18 +338,17 @@ static int exynos_dp_clock_recovery_ok(u8 link_status[2], int lane_count)
> >>> >>       return 0;
> >>> >>  }
> >>> >>
> >>> >> -static int exynos_dp_channel_eq_ok(u8 link_align[3], int lane_count)
> >>> >> +static int exynos_dp_channel_eq_ok(u8 link_status[2], u8 link_align,
> >>> >> +             int lane_count)
> >>> >>  {
> >>> >>       int lane;
> >>> >> -     u8 lane_align;
> >>> >>       u8 lane_status;
> >>> >>
> >>> >> -     lane_align = link_align[2];
> >>> >> -     if ((lane_align & DPCD_INTERLANE_ALIGN_DONE) = 0)
> >>> >> +     if ((link_align & DPCD_INTERLANE_ALIGN_DONE) = 0)
> >>> >>               return -EINVAL;
> >>> >>
> >>> >>       for (lane = 0; lane < lane_count; lane++) {
> >>> >> -             lane_status = exynos_dp_get_lane_status(link_align, lane);
> >>> >> +             lane_status = exynos_dp_get_lane_status(link_status, lane);
> >>> >>               lane_status &= DPCD_CHANNEL_EQ_BITS;
> >>> >>               if (lane_status != DPCD_CHANNEL_EQ_BITS)
> >>> >>                       return -EINVAL;
> >>> >> @@ -432,22 +432,47 @@ static void exynos_dp_reduce_link_rate(struct exynos_dp_device *dp)
> >>> >>       dp->link_train.lt_state = FAILED;
> >>> >>  }
> >>> >>
> >>> >> +static void exynos_dp_get_adjust_training_lane(struct exynos_dp_device *dp,
> >>> >> +                             u8 adjust_request[2])
> >>> >> +{
> >>> >> +     int lane, lane_count;
> >>> >> +     u8 voltage_swing, pre_emphasis, training_lane;
> >>> >> +
> >>> >> +     lane_count = dp->link_train.lane_count;
> >>> >> +     for (lane = 0; lane < lane_count; lane++) {
> >>> >> +             voltage_swing = exynos_dp_get_adjust_request_voltage(
> >>> >> +                                             adjust_request, lane);
> >>> >> +             pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis(
> >>> >> +                                             adjust_request, lane);
> >>> >> +             training_lane = DPCD_VOLTAGE_SWING_SET(voltage_swing) |
> >>> >> +                             DPCD_PRE_EMPHASIS_SET(pre_emphasis);
> >>> >> +
> >>> >> +             if (voltage_swing = VOLTAGE_LEVEL_3)
> >>> >> +                     training_lane |= DPCD_MAX_SWING_REACHED;
> >>> >> +             if (pre_emphasis = PRE_EMPHASIS_LEVEL_3)
> >>> >> +                     training_lane |= DPCD_MAX_PRE_EMPHASIS_REACHED;
> >>> >> +
> >>> >> +             dp->link_train.training_lane[lane] = training_lane;
> >>> >> +     }
> >>> >> +}
> >>> >> +
> >>> >>  static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
> >>> >>  {
> >>> >> -     u8 link_status[2];
> >>> >>       int lane, lane_count, retval;
> >>> >> -
> >>> >> -     u8 adjust_request[2];
> >>> >> -     u8 voltage_swing;
> >>> >> -     u8 pre_emphasis;
> >>> >> -     u8 training_lane;
> >>> >> +     u8 voltage_swing, pre_emphasis, training_lane;
> >>> >> +     u8 link_status[2], adjust_request[2];
> >>> >>
> >>> >>       usleep_range(100, 101);
> >>> >>
> >>> >>       lane_count = dp->link_train.lane_count;
> >>> >>
> >>> >>       retval =  exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
> >>> >> -                             2, link_status);
> >>> >> +                     2, link_status);
> >>> >> +     if (retval)
> >>> >> +             return retval;
> >>> >> +
> >>> >> +     retval =  exynos_dp_read_bytes_from_dpcd(dp,
> >>> >> +                     DPCD_ADDR_ADJUST_REQUEST_LANE0_1, 2, adjust_request);
> >>> >>       if (retval)
> >>> >>               return retval;
> >>> >>
> >>> >> @@ -455,43 +480,9 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
> >>> >>               /* set training pattern 2 for EQ */
> >>> >>               exynos_dp_set_training_pattern(dp, TRAINING_PTN2);
> >>> >>
> >>> >> -             for (lane = 0; lane < lane_count; lane++) {
> >>> >> -                     retval = exynos_dp_read_bytes_from_dpcd(dp,
> >>> >> -                                     DPCD_ADDR_ADJUST_REQUEST_LANE0_1,
> >>> >> -                                     2, adjust_request);
> >>> >> -                     if (retval)
> >>> >> -                             return retval;
> >>> >> -
> >>> >> -                     voltage_swing = exynos_dp_get_adjust_request_voltage(
> >>> >> -                                                     adjust_request, lane);
> >>> >> -                     pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis(
> >>> >> -                                                     adjust_request, lane);
> >>> >> -                     training_lane = DPCD_VOLTAGE_SWING_SET(voltage_swing) |
> >>> >> -                                     DPCD_PRE_EMPHASIS_SET(pre_emphasis);
> >>> >> -
> >>> >> -                     if (voltage_swing = VOLTAGE_LEVEL_3)
> >>> >> -                             training_lane |= DPCD_MAX_SWING_REACHED;
> >>> >> -                     if (pre_emphasis = PRE_EMPHASIS_LEVEL_3)
> >>> >> -                             training_lane |= DPCD_MAX_PRE_EMPHASIS_REACHED;
> >>> >> -
> >>> >> -                     dp->link_train.training_lane[lane] = training_lane;
> >>> >> -
> >>> >> -                     exynos_dp_set_lane_link_training(dp,
> >>> >> -                             dp->link_train.training_lane[lane],
> >>> >> -                             lane);
> >>> >> -             }
> >>> >> -
> >>> >
> >>> > Please don't move it to back.
> >>> >
> >>>
> >>> I assume you're talking about the adjust_request read here? I noticed
> >>> this was changed in your original clean-up patch
> >>> (http://www.spinics.net/lists/linux-fbdev/msg06849.html), but assumed
> >>> it was a no-op. What bug does it fix? According to the flowcharts in
> >>> the exynos5250 datasheet (figure 49-10 & 49-11), this should be done
> >>> *before* setting training pattern 2. Your alteration to my patch will
> >>> read it after.
> >>>
> >>> I also noticed that you added back exynos_dp_get_adjust_training_lane
> >>> call here, along with setting DPCD_ADDR_TRAINING_LANE0_SET. You'll
> >>> notice that this same code is run in the else path of this function.
> >>
> >> No, it is not same.
> >>
> >> 1) your patch
> >>         exynos_dp_read_bytes_from_dpcd(dp,
> >>                 DPCD_ADDR_ADJUST_REQUEST_LANE0_1, 2, adjust_request);
> >>         if (exynos_dp_clock_recovery_ok(link_status, lane_count) = 0) {
> >>                 ...
> >>         } else {
> >>                 for (lane = 0; lane < lane_count; lane++) {
> >>                         training_lane = exynos_dp_get_lane_link_training()
> >>                         voltage_swing = exynos_dp_get_adjust_request_voltage()
> >>                         pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis()
> >>                         ...
> >>
> >> 2) my patch
> >>         if (exynos_dp_clock_recovery_ok(link_status, lane_count) = 0) {
> >>                 ...
> >>         } else {
> >>                 for (lane = 0; lane < lane_count; lane++) {
> >>                         training_lane = exynos_dp_get_lane_link_training()
> >>                         exynos_dp_read_bytes_from_dpcd(dp,
> >>                                 DPCD_ADDR_ADJUST_REQUEST_LANE0_1, 2, adjust_request);
> >>                         voltage_swing = exynos_dp_get_adjust_request_voltage()
> >>                         pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis()
> >>                         ...
> >>
> >>
> >> When the place of reading DPCD_ADDR_ADJUST_REQUEST_LANE0_1 is changed,
> >> it makes the Link Fail problem when exynos_dp_clock_recovery_ok() fails.
> >> In the case of most panels, exynos_dp_clock_recovery_ok() does not fail.
> >> But, some panels failed at exynos_dp_clock_recovery_ok(), and makes the problem
> >> if your patch is used.
> >>
> >
> > I must be missing something. exynos_dp_clock_recovery_ok just
> > interprets link_status, which is read in the same place in both
> > patches. exynos_dp_get_lane_link_training reads from an exynos
> > register. I fail to see how either of those operations could affect
> > the adjust_request DPCD read.
> >
> > The following is the order of operations for
> > exynos_dp_clock_recovery_ok failure with my patch:
> >
> > (1) Read lane_status from DPCD
> > (2) Read adjust_request from DPCD
> > (3) clock_recovery_ok fails
> > (4) Get training_lane 0, parse voltage_swing 0 from adjust_request,
> > parse pre_emphasis 0 from adjust_request
> > (5) Check voltage_swing and pre_emphasis against training_lane,
> > increment loop count if nothing changed, exit earlyif max met
> > (6) Repeat (4),(5) for lane 1, 2, 3
> > (7) Change the value of training_lane to match adjust request read in step (2)
> > (8) Write training_ctl to exynos DP register (all lanes)
> > (9) Write training_lane back out to DPCD (all lanes)
> >
> > With your patch (http://www.spinics.net/lists/linux-fbdev/msg08548.html):
> >
> > (1) Read lane_status from DPCD
> > (2) clock_recovery_ok fails
> > (3) Get training_lane 0
> > (4) Read adjust_request from DPCD
> > (5) Parse voltage_swing 0 from adjust_request, parse pre_emphasis 0
> > from adjust_request
> > (6) Exit early if max met, check voltage_swing and pre_emphasis
> > against training_lane, increment loop count if nothing changed
> > (7) Change the value of training_lane to match adjust request read in step (4)
> > (8) Write training_ctl to exynos DP register for lane 0
> > (9) Repeat (3), (4), (5), (6), (7), (8) for lane 1, 2, 3
> > (9) Write training_lane back out to DPCD (all lanes)
> >
> > So unless reading the training lane from DPCD or
> > exynos_dp_set_lane_link_training (which writes an exynos register)
> > changes the value of the adjust_request read from DPCD, our patches
> > are the same :)
> >
> >> Also, your patch calls exynos_dp_get_adjust_request_voltage() and
> >> exynos_dp_get_adjust_request_pre_emphasis() twice,
> >> when exynos_dp_clock_recovery_ok() fails. Previously, exynos_dp_clock_recovery_ok()
> >> and exynos_dp_get_adjust_request_pre_emphasis() are called only onetime
> >> when exynos_dp_clock_recovery_ok() fails.
> >> There is no need to call exynos_dp_get_adjust_request_voltage() and
> >> exynos_dp_get_adjust_request_pre_emphasis() 'TWICE'.
> >>
> >
> > Yes, it does, but it's just a shift and bitwise-AND... not really
> > heavy weight. It would be nice to refactor that code a bit to remove
> > the nasty, but that's a different patch.
> >
> >
> >>
> >> Anyway, your patch is good and readability is improved.
> >> So, I went the extra mile to accept your original patch and
> >> add it to v3 patch that I sent.
> >> (http://www.spinics.net/lists/linux-fbdev/msg08548.html)
> >>
> >> But, it is necessary to be careful with some error paths,
> >> that is not used at most eDP panels.
> >>
> >
> > I'm still not convinced, but I think we're converging :)
> >
> 
> Ping.
> 

OK, I will accept your original patch.
Your original patch seems to be follow the Link Training procedure
of DP standard, more.
But, I will change exynos_dp_write_byte_to_dpcd() x 4 times
to exynos_dp_write_bytes_to_dpcd(), as I mentioned.

I will post v4 patches.
Thank you.


Best regards,
Jingoo Han

> 
> > Cheers,
> >
> > Sean
> >
> >
> >
> >> Best regards,
> >> Jingoo Han
> >>
> >>> Hence, I removed the duplication and put it all at the bottom. This
> >>> improves readability, matches the flowchart more closely, and removes
> >>> duplication.
> >>>
> >>> I'd urge you to please read my patch more carefully and ask questions
> >>> if you have any.
> >>>
> >>> Thanks!
> >>>
> >>> Sean
> >>>
> >>> >>               retval = exynos_dp_write_byte_to_dpcd(dp,
> >>> >>                       DPCD_ADDR_TRAINING_PATTERN_SET,
> >>> >> -                     DPCD_SCRAMBLING_DISABLED |
> >>> >> -                     DPCD_TRAINING_PATTERN_2);
> >>> >> -             if (retval)
> >>> >> -                     return retval;
> >>> >> -
> >>> >> -             retval = exynos_dp_write_bytes_to_dpcd(dp,
> >>> >> -                     DPCD_ADDR_TRAINING_LANE0_SET,
> >>> >> -                     lane_count,
> >>> >> -                     dp->link_train.training_lane);
> >>> >> +                     DPCD_SCRAMBLING_DISABLED | DPCD_TRAINING_PATTERN_2);
> >>> >>               if (retval)
> >>> >>                       return retval;
> >>> >>
> >>> >> @@ -501,73 +492,49 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
> >>> >>               for (lane = 0; lane < lane_count; lane++) {
> >>> >>                       training_lane = exynos_dp_get_lane_link_training(
> >>> >>                                                       dp, lane);
> >>> >> -                     retval = exynos_dp_read_bytes_from_dpcd(dp,
> >>> >> -                                     DPCD_ADDR_ADJUST_REQUEST_LANE0_1,
> >>> >> -                                     2, adjust_request);
> >>> >> -                     if (retval)
> >>> >> -                             return retval;
> >>> >> -
> >>> >>                       voltage_swing = exynos_dp_get_adjust_request_voltage(
> >>> >>                                                       adjust_request, lane);
> >>> >>                       pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis(
> >>> >>                                                       adjust_request, lane);
> >>> >>
> >>> >> -                     if (voltage_swing = VOLTAGE_LEVEL_3 ||
> >>> >> -                         pre_emphasis = PRE_EMPHASIS_LEVEL_3) {
> >>> >> -                             dev_err(dp->dev, "voltage or pre emphasis reached max level\n");
> >>> >> -                             goto reduce_link_rate;
> >>> >> -                     }
> >>> >> -
> >>> >> -                     if ((DPCD_VOLTAGE_SWING_GET(training_lane) =
> >>> >> -                                     voltage_swing) &&
> >>> >> -                        (DPCD_PRE_EMPHASIS_GET(training_lane) =
> >>> >> -                                     pre_emphasis)) {
> >>> >> +                     if (DPCD_VOLTAGE_SWING_GET(training_lane) =
> >>> >> +                                     voltage_swing &&
> >>> >> +                         DPCD_PRE_EMPHASIS_GET(training_lane) =
> >>> >> +                                     pre_emphasis)
> >>> >>                               dp->link_train.cr_loop[lane]++;
> >>> >> -                             if (dp->link_train.cr_loop[lane] = MAX_CR_LOOP) {
> >>> >> -                                     dev_err(dp->dev, "CR Max loop\n");
> >>> >> -                                     goto reduce_link_rate;
> >>> >> -                             }
> >>> >> -                     }
> >>> >>
> >>> >> -                     training_lane = DPCD_VOLTAGE_SWING_SET(voltage_swing) |
> >>> >> -                                     DPCD_PRE_EMPHASIS_SET(pre_emphasis);
> >>> >> -
> >>> >> -                     if (voltage_swing = VOLTAGE_LEVEL_3)
> >>> >> -                             training_lane |= DPCD_MAX_SWING_REACHED;
> >>> >> -                     if (pre_emphasis = PRE_EMPHASIS_LEVEL_3)
> >>> >> -                             training_lane |= DPCD_MAX_PRE_EMPHASIS_REACHED;
> >>> >> -
> >>> >> -                     dp->link_train.training_lane[lane] = training_lane;
> >>> >> -
> >>> >> -                     exynos_dp_set_lane_link_training(dp,
> >>> >> -                             dp->link_train.training_lane[lane], lane);
> >>> >> +                     if (dp->link_train.cr_loop[lane] = MAX_CR_LOOP ||
> >>> >> +                         voltage_swing = VOLTAGE_LEVEL_3 ||
> >>> >> +                         pre_emphasis = PRE_EMPHASIS_LEVEL_3) {
> >>> >> +                             dev_err(dp->dev, "CR Max reached (%d,%d,%d)\n",
> >>> >> +                                     dp->link_train.cr_loop[lane],
> >>> >> +                                     voltage_swing, pre_emphasis);
> >>> >> +                             exynos_dp_reduce_link_rate(dp);
> >>> >> +                             return -EIO;
> >>> >> +                     }
> >>> >>               }
> >>> >> +     }
> >>> >> +
> >>> >> +     exynos_dp_get_adjust_training_lane(dp, adjust_request);
> >>> >>
> >>> >> -             retval = exynos_dp_write_bytes_to_dpcd(dp,
> >>> >> -                             DPCD_ADDR_TRAINING_LANE0_SET, lane_count,
> >>> >> -                             dp->link_train.training_lane);
> >>> >> +     for (lane = 0; lane < lane_count; lane++) {
> >>> >> +             exynos_dp_set_lane_link_training(dp,
> >>> >> +                     dp->link_train.training_lane[lane], lane);
> >>> >> +             retval = exynos_dp_write_byte_to_dpcd(dp,
> >>> >> +                     DPCD_ADDR_TRAINING_LANE0_SET + lane,
> >>> >> +                     dp->link_train.training_lane[lane]);
> >>> >
> >>> > The following would be better.
> >>> > byte's'_to_dpcd is faster than byte_to_dpcd x 4 times.
> >>> >
> >>> >         for (lane = 0; lane < lane_count; lane++) {
> >>> >                 exynos_dp_set_lane_link_training(dp,
> >>> >                         dp->link_train.training_lane[lane], lane);
> >>> >         }
> >>> >
> >>> >         retval = exynos_dp_write_bytes_to_dpcd(dp,
> >>> >                         DPCD_ADDR_TRAINING_LANE0_SET, lane_count,
> >>> >                         dp->link_train.training_lane);
> >>> >
> >>>
> >>>
> >>> Makes sense, that's a good change.
> >>>
> >>>
> >>> >>               if (retval)
> >>> >>                       return retval;
> >>> >>       }
> >>> >>
> >>> >>       return retval;
> >>> >> -
> >>> >> -reduce_link_rate:
> >>> >> -     exynos_dp_reduce_link_rate(dp);
> >>> >> -     return -EIO;
> >>> >>  }
> >>> >>
> >>> >>  static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
> >>> >>  {
> >>> >> -     u8 link_status[2];
> >>> >> -     u8 link_align[3];
> >>> >>       int lane, lane_count, retval;
> >>> >>       u32 reg;
> >>> >> -
> >>> >> -     u8 adjust_request[2];
> >>> >> -     u8 voltage_swing;
> >>> >> -     u8 pre_emphasis;
> >>> >> -     u8 training_lane;
> >>> >> +     u8 link_align, link_status[2], adjust_request[2];
> >>> >>
> >>> >>       usleep_range(400, 401);
> >>> >>
> >>> >> @@ -578,85 +545,63 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
> >>> >>       if (retval)
> >>> >>               return retval;
> >>> >>
> >>> >> -     if (exynos_dp_clock_recovery_ok(link_status, lane_count) = 0) {
> >>> >> -             link_align[0] = link_status[0];
> >>> >> -             link_align[1] = link_status[1];
> >>> >> -
> >>> >> -             exynos_dp_read_byte_from_dpcd(dp,
> >>> >> -                     DPCD_ADDR_LANE_ALIGN_STATUS_UPDATED,
> >>> >> -                     &link_align[2]);
> >>> >> -
> >>> >> -             for (lane = 0; lane < lane_count; lane++) {
> >>> >> -                     retval = exynos_dp_read_bytes_from_dpcd(dp,
> >>> >> -                                     DPCD_ADDR_ADJUST_REQUEST_LANE0_1,
> >>> >> -                                     2, adjust_request);
> >>> >> -                     if (retval)
> >>> >> -                             return retval;
> >>> >> +     if (exynos_dp_clock_recovery_ok(link_status, lane_count)) {
> >>> >> +             exynos_dp_reduce_link_rate(dp);
> >>> >> +             return -EIO;
> >>> >> +     }
> >>> >>
> >>> >> -                     voltage_swing = exynos_dp_get_adjust_request_voltage(
> >>> >> -                                                     adjust_request, lane);
> >>> >> -                     pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis(
> >>> >> -                                                     adjust_request, lane);
> >>> >> -                     training_lane = DPCD_VOLTAGE_SWING_SET(voltage_swing) |
> >>> >> -                                     DPCD_PRE_EMPHASIS_SET(pre_emphasis);
> >>> >> +     retval = exynos_dp_read_bytes_from_dpcd(dp,
> >>> >> +                     DPCD_ADDR_ADJUST_REQUEST_LANE0_1, 2, adjust_request);
> >>> >> +     if (retval)
> >>> >> +             return retval;
> >>> >>
> >>> >> -                     if (voltage_swing = VOLTAGE_LEVEL_3)
> >>> >> -                             training_lane |= DPCD_MAX_SWING_REACHED;
> >>> >> -                     if (pre_emphasis = PRE_EMPHASIS_LEVEL_3)
> >>> >> -                             training_lane |= DPCD_MAX_PRE_EMPHASIS_REACHED;
> >>> >> +     retval = exynos_dp_read_byte_from_dpcd(dp,
> >>> >> +                     DPCD_ADDR_LANE_ALIGN_STATUS_UPDATED, &link_align);
> >>> >> +     if (retval)
> >>> >> +             return retval;
> >>> >>
> >>> >> -                     dp->link_train.training_lane[lane] = training_lane;
> >>> >> -             }
> >>> >> +     exynos_dp_get_adjust_training_lane(dp, adjust_request);
> >>> >>
> >>> >> -             if (exynos_dp_channel_eq_ok(link_align, lane_count) = 0) {
> >>> >> -                     /* traing pattern Set to Normal */
> >>> >> -                     exynos_dp_training_pattern_dis(dp);
> >>> >> +     if (!exynos_dp_channel_eq_ok(link_status, link_align, lane_count)) {
> >>> >> +             /* traing pattern Set to Normal */
> >>> >> +             exynos_dp_training_pattern_dis(dp);
> >>> >>
> >>> >> -                     dev_info(dp->dev, "Link Training success!\n");
> >>> >> +             dev_info(dp->dev, "Link Training success!\n");
> >>> >>
> >>> >> -                     exynos_dp_get_link_bandwidth(dp, &reg);
> >>> >> -                     dp->link_train.link_rate = reg;
> >>> >> -                     dev_dbg(dp->dev, "final bandwidth = %.2x\n",
> >>> >> -                             dp->link_train.link_rate);
> >>> >> +             exynos_dp_get_link_bandwidth(dp, &reg);
> >>> >> +             dp->link_train.link_rate = reg;
> >>> >> +             dev_dbg(dp->dev, "final bandwidth = %.2x\n",
> >>> >> +                     dp->link_train.link_rate);
> >>> >>
> >>> >> -                     exynos_dp_get_lane_count(dp, &reg);
> >>> >> -                     dp->link_train.lane_count = reg;
> >>> >> -                     dev_dbg(dp->dev, "final lane count = %.2x\n",
> >>> >> -                             dp->link_train.lane_count);
> >>> >> +             exynos_dp_get_lane_count(dp, &reg);
> >>> >> +             dp->link_train.lane_count = reg;
> >>> >> +             dev_dbg(dp->dev, "final lane count = %.2x\n",
> >>> >> +                     dp->link_train.lane_count);
> >>> >>
> >>> >> -                     /* set enhanced mode if available */
> >>> >> -                     exynos_dp_set_enhanced_mode(dp);
> >>> >> -                     dp->link_train.lt_state = FINISHED;
> >>> >> -             } else {
> >>> >> -                     /* not all locked */
> >>> >> -                     dp->link_train.eq_loop++;
> >>> >> +             /* set enhanced mode if available */
> >>> >> +             exynos_dp_set_enhanced_mode(dp);
> >>> >> +             dp->link_train.lt_state = FINISHED;
> >>> >>
> >>> >> -                     if (dp->link_train.eq_loop > MAX_EQ_LOOP) {
> >>> >> -                             dev_err(dp->dev, "EQ Max loop\n");
> >>> >> -                             goto reduce_link_rate;
> >>> >> -                     }
> >>> >> +             return 0;
> >>> >> +     }
> >>> >>
> >>> >> -                     for (lane = 0; lane < lane_count; lane++)
> >>> >> -                             exynos_dp_set_lane_link_training(dp,
> >>> >> -                                     dp->link_train.training_lane[lane],
> >>> >> -                                     lane);
> >>> >> +     /* not all locked */
> >>> >> +     dp->link_train.eq_loop++;
> >>> >>
> >>> >> -                     retval = exynos_dp_write_bytes_to_dpcd(dp,
> >>> >> -                                     DPCD_ADDR_TRAINING_LANE0_SET,
> >>> >> -                                     lane_count,
> >>> >> -                                     dp->link_train.training_lane);
> >>> >> -                     if (retval)
> >>> >> -                             return retval;
> >>> >> -             }
> >>> >> -     } else {
> >>> >> -             goto reduce_link_rate;
> >>> >> +     if (dp->link_train.eq_loop > MAX_EQ_LOOP) {
> >>> >> +             dev_err(dp->dev, "EQ Max loop\n");
> >>> >> +             exynos_dp_reduce_link_rate(dp);
> >>> >> +             return -EIO;
> >>> >>       }
> >>> >>
> >>> >> -     return 0;
> >>> >> +     for (lane = 0; lane < lane_count; lane++)
> >>> >> +             exynos_dp_set_lane_link_training(dp,
> >>> >> +                     dp->link_train.training_lane[lane], lane);
> >>> >>
> >>> >> -reduce_link_rate:
> >>> >> -     exynos_dp_reduce_link_rate(dp);
> >>> >> -     return -EIO;
> >>> >> +     retval = exynos_dp_write_bytes_to_dpcd(dp, DPCD_ADDR_TRAINING_LANE0_SET,
> >>> >> +                     lane_count, dp->link_train.training_lane);
> >>> >> +
> >>> >> +     return retval;
> >>> >>  }
> >>> >>
> >>> >>  static void exynos_dp_get_max_rx_bandwidth(struct exynos_dp_device *dp,
> >>> >> --
> >>> >> 1.7.7.3
> >>> >
> >>

