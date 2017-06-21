From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Date: Wed, 21 Jun 2017 08:36:08 +0000
Subject: Re: [Nouveau] [PATCH 01/11] drm/fb-helper: do a generic fb_setcmap helper in terms of crtc .gamma_se
Message-Id: <517b7144-9612-2249-cff6-cdebcb628f7b@daenzer.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1497986735-14418-1-git-send-email-peda@axentia.se>
 <1497986735-14418-2-git-send-email-peda@axentia.se>
 <20170621073804.akyg4rxvoavjjt2v@phenom.ffwll.local>
 <dfd961c1-2ca9-d85e-fc28-d873666b9bf3@daenzer.net>
 <20170621081454.ymykfka5peelkqxp@phenom.ffwll.local>
In-Reply-To: <20170621081454.ymykfka5peelkqxp@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Peter Rosin <peda@axentia.se>, Philippe Cornu <philippe.cornu@st.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Yannick Fertre <yannick.fertre@st.com>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, Vincent Abriou <vincent.abriou@st.com>, Ben Skeggs <bskeggs@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org

On 21/06/17 05:14 PM, Daniel Vetter wrote:
> On Wed, Jun 21, 2017 at 04:59:31PM +0900, Michel Dänzer wrote:
>> On 21/06/17 04:38 PM, Daniel Vetter wrote:
>>> On Tue, Jun 20, 2017 at 09:25:25PM +0200, Peter Rosin wrote:
>>>> This makes the redundant fb helpers .load_lut, .gamma_set and .gamma_get
>>>> totally obsolete.
>>>>
>>>> I think the gamma_store can end up invalid on error. But the way I read
>>>> it, that can happen in drm_mode_gamma_set_ioctl as well, so why should
>>>> this pesky legacy fbdev stuff be any better?
>>>>
>>>> drm_fb_helper_save_lut_atomic justs saves the gamma lut for later. However,
>>>> it saves it to the gamma_store which should already be up to date with what
>>>> .gamma_get would return and is thus a nop. So, zap it.
>>>
>>> Removing drm_fb_helper_save_lut_atomic should be a separate patch I
>>> think.
>>>  
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>
>> [...]
>>
>>>> @@ -1167,50 +1150,6 @@ void drm_fb_helper_set_suspend_unlocked(struct drm_fb_helper *fb_helper,
>>>>  }
>>>>  EXPORT_SYMBOL(drm_fb_helper_set_suspend_unlocked);
>>>>  
>>>> -static int setcolreg(struct drm_crtc *crtc, u16 red, u16 green,
>>>> -		     u16 blue, u16 regno, struct fb_info *info)
>>>> -{
>>>> -	struct drm_fb_helper *fb_helper = info->par;
>>>> -	struct drm_framebuffer *fb = fb_helper->fb;
>>>> -
>>>> -	if (info->fix.visual = FB_VISUAL_TRUECOLOR) {
>>>
>>> This case here seems gone, and it was also the pièce de résistance when I
>>> tried tackling fbdev lut support. As far as I understand this stuff we do
>>> not support FB_VISUAL_TRUECOLOR palette, and all that bitshifting here is
>>> pointless. But I'm honestly not really clear.
>>>
>>> I think removing this case should also be a separate patch, and I'd very
>>> much prefer that someone with some fbdev-clue would ack it.
>>
>> No need for anyone with fbdev-clue, just run fbset -i. :)

Adding Bartlomiej and the linux-fbdev list, just in case I'm wrong below.


>> fbcon uses a TRUECOLOR visual at depths > 8.
> 
> Then I understand even less what exactly this code does ... Should we keep
> it?

I think we need it. It updates the entries of info->pseudo_palette,
which is kind of a pseudocolor palette mapping 16 indices to pixel
values to write to the framebuffer.

If the setcolreg hook is removed, the setcmap hook needs to do this instead.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
