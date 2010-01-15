From: Chris Wilson <chris@chris-wilson.co.uk>
Date: Fri, 15 Jan 2010 08:36:13 +0000
Subject: Re: 2.6.33-rc4-git1 -- [drm:i915_gem_execbuffer] *ERROR* i915_gem_do_execbuffer returns -512
Message-Id: <89k83a$6u8c0e@azsmga001.ch.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <a44ae5cd1001142018k1f6b741buf560edbda0ca6e33@mail.gmail.com>
In-Reply-To: <a44ae5cd1001142018k1f6b741buf560edbda0ca6e33@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>, DRI for Linux <dri-devel@lists.sourceforge.net>, David Airlie <airlied@linux.ie>, linux-fbdev@vger.kernel.org

On Thu, 14 Jan 2010 23:18:14 -0500, Miles Lane <miles.lane@gmail.com> wrote:
> I just hit this with 2.6.33-rc4-git1 and DRI modesetting enabled.  I
> don't know what event triggered the error.  I had resumed from suspend
> a long time before the error appeared in my dmesg output:
> 
> [ 8505.847430] [drm:i915_gem_execbuffer] *ERROR*
> i915_gem_do_execbuffer returns -512

Apologies, this is not an error. It is an interrupted system call with an
overzealous DRM_ERROR() -- we will hopefully remove this printk promptly.
-ickle

-- 
Chris Wilson, Intel Open Source Technology Centre
