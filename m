From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Fri, 29 Apr 2016 14:47:08 +0000
Subject: Re: [PATCH v4 3/7] drm/fb-helper: Add fb_deferred_io support
Message-Id: <572373EC.9010503@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461856717-6476-1-git-send-email-noralf@tronnes.org>
 <1461856717-6476-4-git-send-email-noralf@tronnes.org>
 <572358A0.8010002@ti.com>
In-Reply-To: <572358A0.8010002@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org


Den 29.04.2016 14:50, skrev Tomi Valkeinen:
> Hi,
>
> On 28/04/16 18:18, Noralf Tr=C3=B8nnes wrote:
>> This adds deferred io support to drm_fb_helper.
>> The fbdev framebuffer changes are flushed using the callback
>> (struct drm_framebuffer *)->funcs->dirty() by a dedicated worker
>> ensuring that it always runs in process context.
>>
>> Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> ---
> Thanks for the series! Unfortunately I haven't been able to follow the
> discussions properly, so I hope my questions haven't been covered earlier.
>
>> Changes since v3:
>> - Don't use forward decl, move drm_fb_helper_dirty_work()
>> - Use DIV_ROUND_UP in drm_fb_helper_deferred_io()
>>
>> Changes since v2:
>> - FB_DEFERRED_IO is now always selected by DRM_KMS_FB_HELPER, ifdef remo=
ved
>> - The drm_clip_rect utility functions are dropped, so open code it
>> - docs: use & to denote structs
>>
>> Changes since v1:
>> - Use a dedicated worker to run the framebuffer flushing like qxl does
>> - Add parameter descriptions to drm_fb_helper_deferred_io
>>
>>   drivers/gpu/drm/Kconfig         |   1 +
>>   drivers/gpu/drm/drm_fb_helper.c | 103 ++++++++++++++++++++++++++++++++=
+++++++-
>>   include/drm/drm_fb_helper.h     |  15 ++++++
>>   3 files changed, 118 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index 9e4f2f1..8e6f34b 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -52,6 +52,7 @@ config DRM_KMS_FB_HELPER
>>   	select FB_CFB_FILLRECT
>>   	select FB_CFB_COPYAREA
>>   	select FB_CFB_IMAGEBLIT
>> +	select FB_DEFERRED_IO
>>   	help
>>   	  FBDEV helpers for KMS drivers.
>>
>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_he=
lper.c
>> index 855108e..62f849f 100644
>> --- a/drivers/gpu/drm/drm_fb_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>> @@ -84,6 +84,15 @@ static LIST_HEAD(kernel_fb_helper_list);
>>    * and set up an initial configuration using the detected hardware, dr=
ivers
>>    * should call drm_fb_helper_single_add_all_connectors() followed by
>>    * drm_fb_helper_initial_config().
>> + *
>> + * If CONFIG_FB_DEFERRED_IO is enabled and &drm_framebuffer_funcs ->dir=
ty is
>> + * set, the drm_fb_helper_{cfb,sys}_{write,fillrect,copyarea,imageblit}
>> + * functions will accumulate changes and schedule &fb_helper .dirty_wor=
k to run
>> + * right away. This worker then calls the dirty() function ensuring tha=
t it
>> + * will always run in process context since the fb_*() function could be
>> + * running in atomic context. If drm_fb_helper_deferred_io() is used as=
 the
> Who's calling {write,fillrect,copyarea,imageblit} in an atomic context?
> That sounds like a very bad idea to me...

I haven't verified it myself, but took it as fact based on
commit: bcb39af4486be07e896fc374a2336bad3104ae0a

drm/udl: make usage as a console safer
Okay you don't really want to use udl devices as your console, but if
you are unlucky enough to do so, you run into a lot of schedule while atomic
due to printk being called from all sorts of funky places. So check if we
are in an atomic context, and queue the damage for later, the next printk
should cause it to appear. This isn't ideal, but it is simple, and seems to
work okay in my testing here.

(dirty area idea came from xenfb)

fixes a bunch of sleeping while atomic issues running fbcon on udl devices.

Cc: stable@vger.kernel.org
Signed-off-by: Dave Airlie <airlied@redhat.com>

> If this is only for accumulating changes, I think it may be better to
> leave that to the driver as it may have better idea of how to accumulate.
>
> But, of course, this is a helper, so if all the drivers use this kind of
> accumulation, it makes sense =3D).

qxl already accumulates damage this way and upcoming tinydrm also.
udl has handled this damage inline except when in_atomic() which results
in damage being deferred to the next fb_*() call.

It is possible for drivers to have their own fb_*() handling and still
use drm_fb_helper_deferred_io().


For those who likes details, this is fbcon unblanking which results in a
full display update on a 320x240 display, shell with blinking cursor on
the last line of the console:

[ 5505.164150] drm_fb_helper_dirty: x=152,width=3D8,y"4,height=16
[ 5505.164186] [drm:drm_atomic_state_init] Allocated atomic state b859e400
[...more drm atomic msgs...]
[ 5505.164713] drm_fb_helper_dirty: x=152,width=3D8,y"4,height=16
[ 5505.164746] [drm:drm_atomic_state_init] Allocated atomic state b859e440
[...more drm atomic msgs...]
[ 5505.165086] drm_fb_helper_dirty: x=3D0,width20,y=3D0,height=16
[ 5505.165153] drm_fb_helper_dirty: x=3D0,width20,y=16,height=16
[ 5505.165220] drm_fb_helper_dirty: x=3D0,width20,y2,height=16
[ 5505.165287] drm_fb_helper_dirty: x=3D0,width20,yH,height=16
[ 5505.165354] drm_fb_helper_dirty: x=3D0,width20,yd,height=16
[ 5505.165420] drm_fb_helper_dirty: x=3D0,width20,y=80,height=16
[ 5505.165487] drm_fb_helper_dirty: x=3D0,width20,y=96,height=16
[ 5505.165553] drm_fb_helper_dirty: x=3D0,width20,y=112,height=16
[ 5505.165619] drm_fb_helper_dirty: x=3D0,width20,y=128,height=16
[ 5505.165686] drm_fb_helper_dirty: x=3D0,width20,y=144,height=16
[ 5505.165752] drm_fb_helper_dirty: x=3D0,width20,y=160,height=16
[ 5505.165818] drm_fb_helper_dirty: x=3D0,width20,y=176,height=16
[ 5505.165884] drm_fb_helper_dirty: x=3D0,width20,y=192,height=16
[ 5505.165949] drm_fb_helper_dirty: x=3D0,width20,y 8,height=16
[ 5505.165978] drm_fb_helper_dirty: x=3D0,width=112,y"4,height=16
[ 5505.165988] drm_fb_helper_dirty: x=112,width=3D8,y"4,height=16
[ 5505.166002] drm_fb_helper_dirty: x=120,width$,y"4,height=16
[ 5505.166041] drm_fb_helper_dirty: x=144,width=176,y"4,height=16
[ 5505.166058] drm_fb_helper_dirty: x=152,width=3D8,y"4,height=16
[ 5505.166079] drm_fb_helper_dirty: x=152,width=3D8,y"4,height=16
[ 5505.166424] drm_fb_helper_dirty_work: x1=3D0,x220,y1=3D0,y2$0
[ 5505.166452] adafruit-tft spi0.0: mipi_dbi_dirtyfb: vmem=BAc40000,=20
x1=3D0, x220, y1=3D0, y2$0

Cursor blinking:

[ 5505.363478] drm_fb_helper_dirty: x=152,width=3D8,y"4,height=16
[ 5505.363509] drm_fb_helper_dirty_work: x1=152,x2=160,y1"4,y2$0
[ 5505.363539] adafruit-tft spi0.0: mipi_dbi_dirtyfb: vmem=BAc40000,=20
x1=152, x2=160, y1"4, y2$0

[ 5505.563488] drm_fb_helper_dirty: x=152,width=3D8,y"4,height=16
[ 5505.563514] drm_fb_helper_dirty_work: x1=152,x2=160,y1"4,y2$0
[ 5505.563542] adafruit-tft spi0.0: mipi_dbi_dirtyfb: vmem=BAc40000,=20
x1=152, x2=160, y1"4, y2$0


Noralf.


