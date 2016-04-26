From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Tue, 26 Apr 2016 16:26:47 +0000
Subject: Re: [PATCH v2 1/8] drm/rect: Add some drm_clip_rect utility functions
Message-Id: <571F96C7.1060800@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461530942-22485-1-git-send-email-noralf@tronnes.org>
 <20160425163816.GF4329@intel.com> <571E6366.20504@tronnes.org>
 <1615589.QRyc9Clv2Y@avalon>
In-Reply-To: <1615589.QRyc9Clv2Y@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


Den 25.04.2016 23:13, skrev Laurent Pinchart:
> Hi Noralf,
>
> On Monday 25 Apr 2016 20:35:18 Noralf Tr=F8nnes wrote:
>> Den 25.04.2016 18:38, skrev Ville Syrj=E4l=E4:
>>> On Mon, Apr 25, 2016 at 06:05:20PM +0200, Daniel Vetter wrote:
>>>> On Mon, Apr 25, 2016 at 06:09:44PM +0300, Ville Syrj=E4l=E4 wrote:
>>>>> On Mon, Apr 25, 2016 at 04:03:13PM +0200, Noralf Tr=F8nnes wrote:
>>>>>> Den 25.04.2016 15:02, skrev Ville Syrj=E4l=E4:
>>>>>>> On Mon, Apr 25, 2016 at 02:55:52PM +0200, Noralf Tr=F8nnes wrote:
>>>>>>>> Den 25.04.2016 14:39, skrev Ville Syrj=E4l=E4:
>>>>>>>>> On Sun, Apr 24, 2016 at 10:48:55PM +0200, Noralf Tr=F8nnes wrote:
>>>>>>>>>> Add some utility functions for struct drm_clip_rect.

[...]

>> How about we just drop this patch?
>> I couldn't find anyone else that merge these clips, they just loop and
>> handle them individually.
>>
>> The relevant part in drm_fb_helper would become:
>>
>> static void drm_fb_helper_dirty_work(struct work_struct *work)
>> {
>>       struct drm_fb_helper *helper =3D container_of(work, struct drm_fb_=
helper,
>> dirty_work);
>>       struct drm_clip_rect *clip =3D &helper->dirty_clip;
>>       struct drm_clip_rect clip_copy;
>>       unsigned long flags;
>>
>>       spin_lock_irqsave(&helper->dirty_lock, flags);
>>       clip_copy =3D *clip;
>>       clip->x1 =3D clip->y1 =3D ~0;
>>       clip->x2 =3D clip->y2 =3D 0;
>>       spin_unlock_irqrestore(&helper->dirty_lock, flags);
>>
>>       helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, &clip_copy, 1);
>> }
>>
>> static void drm_fb_helper_dirty_init(struct drm_fb_helper *helper)
>> {
>>       spin_lock_init(&helper->dirty_lock);
>>       INIT_WORK(&helper->dirty_work, drm_fb_helper_dirty_work);
>>       helper->dirty_clip.x1 =3D helper->dirty_clip.y1 =3D ~0;
>> }
>>
>> static void drm_fb_helper_dirty(struct fb_info *info, u32 x, u32 y,
>>                   u32 width, u32 height)
>> {
>>       struct drm_fb_helper *helper =3D info->par;
>>       struct drm_clip_rect *clip =3D &helper->dirty_clip;
>>       unsigned long flags;
>>
>>       if (!helper->fb->funcs->dirty)
>>           return;
>>
>>       spin_lock_irqsave(&helper->dirty_lock, flags);
>>       clip->x1 =3D min(clip->x1, x);
>>       clip->y1 =3D min(clip->y1, y);
>>       clip->x2 =3D max(clip->x2, x + width);
>>       clip->y2 =3D max(clip->y2, y + height);
>>       spin_unlock_irqrestore(&helper->dirty_lock, flags);
>>
>>       schedule_work(&helper->dirty_work);
>> }
>>
>>
>> And the driver would use this tinydrm function:
>>
>> void tinydrm_merge_clips(struct drm_clip_rect *dst,
>>                struct drm_clip_rect *src, unsigned num_clips,
>>                unsigned flags, u32 width, u32 height)
>> {
>>       int i;
> Nitpicking here, as i never takes negative values, could you make it an
> unsigned int ?

Sure.

>>       if (!src || !num_clips) {
>>           dst->x1 =3D 0;
>>           dst->x2 =3D width;
>>           dst->y1 =3D 0;
>>           dst->y2 =3D height;
>>           return;
>>       }
>>
>>       dst->x1 =3D dst->y1 =3D ~0;
>>       dst->x2 =3D dst->y2 =3D 0;
>>
>>       for (i =3D 0; i < num_clips; i++) {
>>           if (flags & DRM_MODE_FB_DIRTY_ANNOTATE_COPY)
>>               i++;
>>           dst->x1 =3D min(dst->x1, src[i].x1);
>>           dst->x2 =3D max(dst->x2, src[i].x2);
>>           dst->y1 =3D min(dst->y1, src[i].y1);
>>           dst->y2 =3D max(dst->y2, src[i].y2);
>>       }
>>
>>       if (dst->x2 > width || dst->y2 > height ||
>>           dst->x1 >=3D dst->x2 || dst->y1 >=3D dst->y2) {
>>           DRM_DEBUG_KMS("Illegal clip: x1=3D%u, x2=3D%u, y1=3D%u, y2=3D%=
u\n",
>>                     dst->x1, dst->x2, dst->y1, dst->y2);
>>           dst->x1 =3D dst->y1 =3D 0;
>>           dst->x2 =3D width;
>>           dst->y2 =3D height;
>>       }
>> }
>>
>> static int mipi_dbi_dirtyfb(struct drm_framebuffer *fb, void *vmem,
>>                   unsigned flags, unsigned color,
>>                   struct drm_clip_rect *clips, unsigned num_clips)
>> {
>>       struct drm_clip_rect clip;
>>
>>       tinydrm_merge_clips(&clip, clips, num_clips, flags,
>>                   fb->width, fb->height);

