From: Dave Airlie <airlied@gmail.com>
Date: Sun, 11 Aug 2013 08:42:12 +0000
Subject: Re: EDID modes unavailable when no connector/crtc available at boot
Message-Id: <CAPM=9tzShWxZ-f=641r+-uc21JkY3kTeM2K=tsiB+OotNCnrQA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5207160A.6070803@prisktech.co.nz>
In-Reply-To: <5207160A.6070803@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tony Prisk <linux@prisktech.co.nz>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, dri-devel@lists.freedesktop.org

On Sun, Aug 11, 2013 at 2:41 PM, Tony Prisk <linux@prisktech.co.nz> wrote:
> I am working on the HDMI driver for the i.MX6 as part of the larger DRM
> driver written by Sascha Hauer and need a little advice. I seem to be
> missing one important part of the subsystem that I haven't been able to
> resolve.
>

fbcon is limited by boot sizes as at least with dynamic memory
management and how fbdev works resizing the allocation is nearly
impossible to do race free, since fbdev will hand out mmaps to
userspace and that stops you from ever moving anything once the device
is open.

But this is only for the fbdev emulation, a real kms application
should be able to use a larger size no problems.

Dave.
