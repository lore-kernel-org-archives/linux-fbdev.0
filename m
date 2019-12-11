From: Jani Nikula <jani.nikula@intel.com>
Date: Wed, 11 Dec 2019 11:11:54 +0000
Subject: Re: [PATCH v3 12/12] auxdisplay: constify fb ops
Message-Id: <87wob32k1x.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575390740.git.jani.nikula@intel.com>
 <31c18e3ce9d6962aabda4799b3051039ff591c92.1575390741.git.jani.nikula@intel.com>
 <87pngx4muv.fsf@intel.com>
 <CANiq72nPccKZghPM-FrNRnQ8AkN_r40cUmM3ruhyGtiTs_DdyQ@mail.gmail.com>
In-Reply-To: <CANiq72nPccKZghPM-FrNRnQ8AkN_r40cUmM3ruhyGtiTs_DdyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Robin van der Gracht <robin@protonic.nl>

On Tue, 10 Dec 2019, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> On Mon, Dec 9, 2019 at 3:04 PM Jani Nikula <jani.nikula@intel.com> wrote:
>>
>> On Tue, 03 Dec 2019, Jani Nikula <jani.nikula@intel.com> wrote:
>> > Now that the fbops member of struct fb_info is const, we can start
>> > making the ops const as well.
>> >
>> > Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
>> > Cc: Robin van der Gracht <robin@protonic.nl>
>> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> > Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> > Acked-by: Robin van der Gracht <robin@protonic.nl>
>> > Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>>
>> Miguel, Robin, just to err on the safe side, were you both okay with me
>> merging this through drm-misc? Not very likely to conflict badly.
>
> I think that is fine, go ahead! :)

Thanks, pushed to drm-misc-next!

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
