From: Grazvydas Ignotas <notasas@gmail.com>
Date: Thu, 10 May 2012 10:58:13 +0000
Subject: Re: [PATCH] OMAPDSS: OMAPFB: always allow to configure overlay
Message-Id: <CANOLnON8jnw+CLOBDLnUpo-gsnnnKxTSyRrTxF3h1Kn=WMO18g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336144581-25151-1-git-send-email-notasas@gmail.com>
In-Reply-To: <1336144581-25151-1-git-send-email-notasas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Thu, May 10, 2012 at 1:28 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Fri, 2012-05-04 at 18:16 +0300, Grazvydas Ignotas wrote:
>> Currently when multiple overlays are active, OMAPFB_SETUP_PLANE fails.
>> Instead of failing, allow it to configure the first overlay as if there
>> was only one overlay, the remaining ones will have to be configured in
>> other ways (sysfs).
>>
>> This allows overlay-controlling programs (like video players) to function
>> properly when framebuffer is cloned to another display (like TV).
>>
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>> ---
>>  drivers/video/omap2/omapfb/omapfb-ioctl.c |   36 ++++++++++------------------
>>  1 files changed, 13 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
>> index 6a09ef8..58b7f2d 100644
>> --- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
>> +++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
>> @@ -70,11 +70,6 @@ static int omapfb_setup_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
>>
>>       DBG("omapfb_setup_plane\n");
>>
>> -     if (ofbi->num_overlays != 1) {
>> -             r = -EINVAL;
>> -             goto out;
>> -     }
>> -
>>       /* XXX uses only the first overlay */
>>       ovl = ofbi->overlays[0];
>
> What if there are no overlays? I'm not quite sure about it, but I think
> it's possible.

Hmm, I guess you are right, will send v2.



-- 
Gražvydas
