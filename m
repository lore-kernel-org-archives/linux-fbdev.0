From: robin <robin@protonic.nl>
Date: Mon, 02 Dec 2019 08:08:08 +0000
Subject: Re: [PATCH v2 14/14] auxdisplay: constify fb ops
Message-Id: <db5f3f940317323543fe8b5adbbefff6@protonic.nl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
 <94a33cf0a587e803bcadcf80e8152eac9b196f34.1575022735.git.jani.nikula@intel.com>
 <20191129152424.GG624164@phenom.ffwll.local>
 <CANiq72kRGg1AZHC-pR_uKykMxmcMPM2+qbXVPVQhHrZRzu723Q@mail.gmail.com>
 <20191129203007.GV624164@phenom.ffwll.local>
 <CANiq72mEseWduUkJ069E8m8XKuyctsxOsTEZAfGm9d81WzpGEQ@mail.gmail.com>
In-Reply-To: <CANiq72mEseWduUkJ069E8m8XKuyctsxOsTEZAfGm9d81WzpGEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jani Nikula <jani.nikula@intel.com>, linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org

On 2019-11-29 21:59, Miguel Ojeda wrote:
> On Fri, Nov 29, 2019 at 9:30 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>> 
>> Well we do have very small lcd display drivers in drm, and before that 
>> in
>> fbdev. And you have a fbdev framebuffer driver in there, which looks a 
>> bit
>> misplaced ...
>> 
>> Afaiui you also have some even tinier lcd drivers where you don't 
>> address
>> pixels, but just directly upload text, and those obviously don't fit 
>> into
>> drm/fbdev world. But anything where you can address pixels very much 
>> does.
>> -Daniel
> 
> The first driver in the category used fb.h. At the time (~13 years
> ago) it was decided that the drivers should go into a different
> category/folder instead and then the other were added.
> 
> In any case, I am removing the original ones since I cannot test them
> anymore and there are likely no user. The only other fb user could be
> relocated if Robin agrees.

The ht16k33 driver registers a framebuffer, backlight and input device.
Not sure if it's OK to let a driver under fbdev register all of those,
but relocating it is fine by me.

Robin
