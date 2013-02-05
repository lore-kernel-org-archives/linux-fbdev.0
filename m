From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 05 Feb 2013 21:04:27 +0000
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH]Siliconmotion initial patch
Message-Id: <20130205210427.GF5813@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4CE6A5494DEECD498EBCD4C5488B1AFCEAC6F7@CNDC08.cn.smi.ad>
In-Reply-To: <4CE6A5494DEECD498EBCD4C5488B1AFCEAC6F7@CNDC08.cn.smi.ad>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?utf-8?B?QWFyb24uQ2hlbiDpmYjkv4rmnbA=?= <aaron.chen@siliconmotion.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, =?utf-8?B?Y2Flc2FyLnFpdSDoo5jotZvmtbc=?= <caesar.qiu@siliconmotion.com>, dri-devel@lists.freedesktop.org

On Tue, Feb 05, 2013 at 03:51:55PM +0800, Aaron.Chen  陈俊杰 wrote:
> This is an initial patch for Siliconmotion Graphics chips. It add SM750
> chip support with 2d accelerate and hw curser support. It is a complete
> new driver. So the patch is a little bit big. Is it OK for review?

Adding a new fbdev driver while established consensus pretty much boils
down to fbdev being a dead subsystem which should only be used for legacy
applications and drivers: Not good. You should implement this as a drm
modesetting driver, and if required base your 2d acceleration on top of
the drm fb helpers. Or just implement a drm/gem driver to expose this.

Additionally you should include the appropriate mailing lists, which is
linux-fbdev for fbdev drivers.

On a very quick read the patch has serious issues:

- checkpatch.pl:

total: 2 errors, 779 warnings, 7961 lines checked

NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
      scripts/cleanfile

- Remants of hungarian notation (dunno whether checkpatch checks for
  those, too much other stuff flying by, but it really stuck out).

- Not using the linux i2c layer in the ddk750_hwi2c.c file.

- Reimplementing i2c bit-banging code in the ddk750_swi2c.c

- Adding a new implementation of a sil 164 dvi driver, we already have at
  least two in drivers/gpu/drm/i2c/sil164_drv.c and
  drivers/gpu/drm/i915/dvo_sil164.c.  This should be unified and probably
  use the drm encoder slave framework.

At that point I've given up on further review, since there's clearly a lot
of work left to do. Please review SubmittingPatches from the kernel
documentation carefully. Also cc'ing our dear staging maintainer, he
should be able to point you at further useful resources for getting this
going.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
