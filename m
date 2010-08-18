From: Chris Wilson <chris@chris-wilson.co.uk>
Date: Wed, 18 Aug 2010 19:13:12 +0000
Subject: Re: [REGRESSION] [2.6.36-rc1] [DRM INTEL] [drm:intel_calculate_wm] *ERROR* Insufficient FIFO for pla
Message-Id: <89k83a$9bjd6q@azsmga001.ch.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201008182046.37732.maciej.rutecki@gmail.com>
In-Reply-To: <201008182046.37732.maciej.rutecki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: maciej.rutecki@gmail.com, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, airlied@linux.ie

On Wed, 18 Aug 2010 20:46:37 +0200, Maciej Rutecki <maciej.rutecki@gmail.com> wrote:
> Last known good: 2.6.35
> Failing kernel: 2.6.36-rc1
> 
> During boot kernel display this message:
> [    0.831906] [drm:intel_calculate_wm] *ERROR* Insufficient FIFO for plane, 
> expect flickering: entries required = 36, available = 28.

To be honest, I was shocked at how often we were actually computing that
we required a larger FIFO for scanout than was available. Typically, it is
the result of the pessimistic latency we guess for the memory fetch and so
we err on the side of extreme caution when computing the watermark. So in
effect, we have been clamping the FIFO since the beginning, but we only
just added the warning message as an aide to diagnosing some FIFO
underruns. We could tone down the error message, the real goal though is
to improve the accuracy of the calculation and thereby reduce power.

> Systems seems work OK, but in 2.6.35 I don't have this message. On another 
> system with 2.6.36-rc1 kernel I have the same message.

Yes, there was just a couple of places where we changed the calculation to
round-up but otherwise the wm logic remained mostly the same. So if you
haven't been experiencing FIFO underruns, e.g. the screen flickering, then
it is likely that the error is benign (and just wasting power).

-- 
Chris Wilson, Intel Open Source Technology Centre
