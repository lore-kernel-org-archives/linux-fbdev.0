From: robin <robin@protonic.nl>
Date: Wed, 11 Dec 2019 08:35:35 +0000
Subject: Re: [PATCH v3 12/12] auxdisplay: constify fb ops
Message-Id: <7c78b5c7421f75c2afdeb4b3a15c8a09@protonic.nl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575390740.git.jani.nikula@intel.com>
 <31c18e3ce9d6962aabda4799b3051039ff591c92.1575390741.git.jani.nikula@intel.com>
 <87pngx4muv.fsf@intel.com>
In-Reply-To: <87pngx4muv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>

Hello Jani,

On 2019-12-09 15:03, Jani Nikula wrote:
> On Tue, 03 Dec 2019, Jani Nikula <jani.nikula@intel.com> wrote:
>> Now that the fbops member of struct fb_info is const, we can start
>> making the ops const as well.
>> 
>> Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
>> Cc: Robin van der Gracht <robin@protonic.nl>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> Acked-by: Robin van der Gracht <robin@protonic.nl>
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> 
> Miguel, Robin, just to err on the safe side, were you both okay with me
> merging this through drm-misc? Not very likely to conflict badly.

ht16k33 driver hasn't seen much change lately, should be fine.

Robin
