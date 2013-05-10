From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 10 May 2013 01:21:33 +0000
Subject: Re: [RFC/PATCH v2 0/8] Clean up write-combining MTRR addition
Message-Id: <CALCETrUWZmcOv6WmpdUCqb-xwH9ZLrrXffv96j6hguV08OGtkQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1368128020.git.luto@amacapital.net> <CAH3drwa_ypKKqZ8eayeR4fA4Ounj55R3R9y0_b5crp99YMFQ=w@mail.gmail.com>
In-Reply-To: <CAH3drwa_ypKKqZ8eayeR4fA4Ounj55R3R9y0_b5crp99YMFQ=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jerome Glisse <j.glisse@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@gmail.com>

On Thu, May 9, 2013 at 4:44 PM, Jerome Glisse <j.glisse@gmail.com> wrote:
> On Thu, May 9, 2013 at 3:46 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> A fair number of drivers (mostly graphics) add write-combining MTRRs.
>> Most ignore errors and most add the MTRR even on PAT systems which don't
>> need to use MTRRs.
>
> This comment is wrong, as i said we need MTRR on PAT system for VRAM.

I didn't follow it last time.

 - If userspace is setting an MTRR directly, then it will work exactly
as before -- this patch has no effect on the userspace MTRR APIs.

 - If userspace uses the drm map interface with DRM_FRAME_BUFFER or
DRM_WRITE_COMBINING, there won't be an MTRR but the range will still
be WC.

 - If userspace uses GEM or TTM, then everything should still use WC
(TTM has explicit handling for this, which I presume is correct, and
i915, the major GEM user, already doesn't set an MTRR).

 - If userspace does not map the range, then either the kernel driver
is buggy or it doesn't matter because there's no map.

Is there a case I've missed?

--Andy
