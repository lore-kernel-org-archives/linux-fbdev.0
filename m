From: Charles Lohr <lohr85@gmail.com>
Date: Thu, 15 Mar 2018 20:03:08 +0000
Subject: Re: fbcon non-desktop display use
Message-Id: <CAGu26P_+Sk=GD0SZAofu5MxWwJmBZiSg_Xz+OLRu8-A3Bu93MQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAGu26P8B-JNPnRrvgKCirE+rE2vGpgo56Hxh_tKYxY2jrwcNRQ@mail.gmail.com>
 <87zi39yyx1.fsf@keithp.com>
In-Reply-To: <87zi39yyx1.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keith Packard <keithp@keithp.com>
Cc: David Airlie <airlied@redhat.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

To try to address both concerns, it feels easiest to do not in-line.

1) Just for background: The H3, and many other ARM systems use the
framebuffer for all video access, 3D accelerated as well as X11. If we
want to permit HMD (headmount display) or other non-desktop displays
on these devices are going to be used at all, it seems DRM must be set
up for them.  I don't think of this as a "feature".

2) Although I "wish" there was a way to permit non-desktop use with
multiple displays, I am having difficulty finding a specific need to
be able to turn it on/off.  All applications I can imagine with the
HMD currently would involve the HMD being the only connected device.
I am still "submitting" the patch with the parameter, however, if you
folks decide not to accept it, I intend to re-submit with just the &&
strict fix (which I just tested and it's good!) -- unless you (Keith)
are willing to put forward the && strict as a patch.

3) I am trying "plain text mode" for my patch, so hopefully it doesn't
truncate the lines.  Also, I misunderstood "Signed-off-by" Thanks!

Signed-off-by: Charles Lohr <lohr85@gmail.com>

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 035784ddd..e14624d0f 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -55,6 +55,11 @@ MODULE_PARM_DESC(drm_fbdev_overalloc,
                 "Overallocation of the fbdev buffer (%) [default="
                 __MODULE_STRING(CONFIG_DRM_FBDEV_OVERALLOC) "]");

+static bool drm_fbdev_permit_non_desktop;
+module_param(drm_fbdev_permit_non_desktop, bool, 0644);
+MODULE_PARM_DESC(drm_fbdev_permit_non_desktop,
+               "Allow the framebuffer to use non-desktop displays
[default=off]");
+
 static LIST_HEAD(kernel_fb_helper_list);
 static DEFINE_MUTEX(kernel_fb_helper_lock);

@@ -2109,7 +2114,7 @@ static bool drm_connector_enabled(struct
drm_connector *connector, bool strict)
 {
        bool enable;

-       if (connector->display_info.non_desktop)
+       if (connector->display_info.non_desktop &&
!drm_fbdev_permit_non_desktop && strict)
                return false;

        if (strict)

On Thu, Mar 15, 2018 at 2:30 PM, Keith Packard <keithp@keithp.com> wrote:
> Charles Lohr <lohr85@gmail.com> writes:
>
>> Even if the vive is the only device connected, it will still not permit it
>> to be operated.  See https://github.com/linux-sunxi/linux-sunxi/issues/291
>> for dri with a lot of debugging turned on.
>
> Oh, it's not supposed to do that. I had intended to write the code so
> that if the only device available was a non-desktop device that it would
> go ahead and use it. The X server patches did that, but the kernel ones
> did not. It looks like that would be an easy patch -- just skip the
> non_desktop check in the !strict case for drm_connector_enabled.
>
> However, your patch is a good addition as it will allow you to also
> enable the HMD when other monitors are connected.
>
>> I can understand that most users would probably prefer that the vive isn't
>> automatically used if no other displays are available, however, the current
>> behavior prevents use of the vive on all devices that use fbdev for their
>> primary output.
>
> That was definitely not my intention, and thanks for discovering this!
>
>> I've never sent an email to the kernel devel list, so I'm still a little
>> nervous.  Especially because this is against a different branch, and I'm
>> starting to think that I should be messaging there, but this is something
>> that really needs to go upstream.
>
> We'll get it sorted out; I'm not sure what Dave's preference is these
> days anyways.
>
> Aside from some minor formatting issues, this patch looks good to me.
>
>> Signed-off-by:
>
> You'll need to add your name and email address here.
>
>> diff --git a/drivers/gpu/drm/drm_fb_helper.c
>> b/drivers/gpu/drm/drm_fb_helper.c
>> index 035784ddd..8bfaf79ff 100644
>> --- a/drivers/gpu/drm/drm_fb_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>> @@ -55,6 +55,11 @@ MODULE_PARM_DESC(drm_fbdev_overalloc,
>>                  "Overallocation of the fbdev buffer (%) [default="
>>                  __MODULE_STRING(CONFIG_DRM_FBDEV_OVERALLOC) "]");
>>
>> +static bool drm_fbdev_permit_non_desktop;
>> +module_param(drm_fbdev_permit_non_desktop, bool, 0644);
>> +MODULE_PARM_DESC(drm_fbdev_permit_non_desktop,
>> +               "Allow the framebuffer to use non-desktop displays
>> [default=off]");
>> +
>
> Your email client appears to be wrapping long lines, which breaks the patch.
>
>
>>  static LIST_HEAD(kernel_fb_helper_list);
>>  static DEFINE_MUTEX(kernel_fb_helper_lock);
>>
>> @@ -2109,7 +2114,7 @@ static bool drm_connector_enabled(struct
>> drm_connector *connector, bool strict)
>>  {
>>         bool enable;
>>
>> -       if (connector->display_info.non_desktop)
>> +       if (connector->display_info.non_desktop &&
>> !drm_fbdev_permit_non_desktop)
>
> If you added '&& strict' here, it will use the HMD if there aren't any
> desktop monitors connected.
>
> --
> -keith
