From: Dave Airlie <airlied@gmail.com>
Date: Tue, 07 May 2013 03:09:48 +0000
Subject: Re: [PATCH 3/7] drm: Update drm_addmap and drm_mmap to use PAT WC instead of MTRRs
Message-Id: <CAPM=9twx2VL2_Xo2-byhWcZ5csbYzyV18trEOzAqmHT8javGrg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1367621038.git.luto@amacapital.net>
	<d6e5e371e464b7de1115a00f02b5b834315cd986.1367621039.git.luto@amacapital.net>
	<CALCETrVe=JSPB=x79e1fAK=DrMgo7_Liagihib9quJDJ0N670Q@mail.gmail.com>
	<CAH3drwYSZVrM4uWwFAxD+c0n1Q9i-et=Mwbk253E+cd+BtW9yw@mail.gmail.com>
	<CALCETrXO7OVxjw5nJ+HrBP7yAoAXk14w1cMbWBC4ZdBmZ6-3JQ@mail.gmail.com>
In-Reply-To: <CALCETrXO7OVxjw5nJ+HrBP7yAoAXk14w1cMbWBC4ZdBmZ6-3JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jerome Glisse <j.glisse@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

>>
>> From memory, even on pat system we need mtrr for VRAM is PCI BAR. We
>> cover it with a write combine MTRR. The whole ioctl is use by some ddx
>> or maybe even directly the XServer to do this mtrr mess in userspace.
>
> Egads!  So we have a _DRM_WRITE_COMBINING flag, which will continue to
> work fine, but almost nothing uses it.
>
> I'm amazed this stuff works in the current code, though.  Apparently
> the memory type (WC or UC) of a drm mapping is determined by the mtrr
> the driver set, but if one part of the BAR is textures or the
> framebuffer and another part is an outgoing command ring, won't one of
> them end up with the wrong memory type?

Nobody sane puts the command ring in VRAM.

Dave.
