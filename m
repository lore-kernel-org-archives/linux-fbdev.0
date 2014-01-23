From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 23 Jan 2014 05:44:05 +0000
Subject: Re: [PATCH v2] backlight: turn backlight on/off when necessary
Message-Id: <000101cf17fe$20ac79a0$62056ce0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390196846-15304-1-git-send-email-Ying.Liu@freescale.com>
 <87sisg5pfo.fsf@intel.com>
In-Reply-To: <87sisg5pfo.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Liu Ying' <Ying.Liu@freescale.com>
Cc: 'Jani Nikula' <jani.nikula@linux.intel.com>, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 'Jingoo Han' <jg1.han@samsung.com>

On Wednesday, January 22, 2014 6:36 PM, Jani Nikula wrote:
> On Mon, 20 Jan 2014, Liu Ying <Ying.Liu@freescale.com> wrote:
> > We don't have to turn backlight on/off everytime a blanking
> > or unblanking event comes because the backlight status may
> > have already been what we want. Another thought is that one
> > backlight device may be shared by multiple framebuffers. We
> > don't hope blanking one of the framebuffers may turn the
> > backlight off for all the other framebuffers, since they are
> > likely being active to display something. This patch adds
> > some logics to record each framebuffer's backlight usage to
> > determine the backlight device use count and whether the
> > backlight should be turned on or off. To be more specific,
> > only one unblank operation on a certain blanked framebuffer
> > may increase the backlight device's use count by one, while
> > one blank operation on a certain unblanked framebuffer may
> > decrease the use count by one, because the userspace is
> > likely to unblank a unblanked framebuffer or blank a blanked
> > framebuffer.
> >
> > Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> > ---
> > v1 can be found at https://lkml.org/lkml/2013/5/30/139
> >
> > v1->v2:
> > * Make the commit message be more specific about the condition
> >   in which backlight device use count can be increased/decreased.
> > * Correct the setting for bd->props.fb_blank.
> >
> >  drivers/video/backlight/backlight.c |   28 +++++++++++++++++++++-------
> >  include/linux/backlight.h           |    6 ++++++
> >  2 files changed, 27 insertions(+), 7 deletions(-)
> >

[.....]
> 
> Anything backlight worries me a little, and there are actually three
> changes bundled into one patch here:
> 
> 1. Changing bd->props.state and bd->props.fb_blank only when use_count
>    changes from 0->1 or 1->0.
> 
> 2. Calling backlight_update_status() only with the above change, and not
>    on all notifier callbacks.
> 
> 3. Setting bd->props.fb_blank always to either FB_BLANK_UNBLANK or
>    FB_BLANK_POWERDOWN instead of *(int *)evdata->data.
> 
> The rationale in the commit message seems plausible, and AFAICT the code
> does what it says on the box, so for that (and for that alone) you can
> have my
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> 
> *BUT* it would be laborous to figure out whether this change in
> behaviour might regress some drivers. I'm just punting on that. And that
> brings us back to the three changes above - in a bisect POV it might be
> helpful to split the patch up. Up to the maintainers.

I agree with Jani Nikula's opinion.
Please split this patch into three patches as above mentioned.

Best regards,
Jingoo Han

