From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 06 May 2013 21:22:37 +0000
Subject: Re: [PATCH 3/7] drm: Update drm_addmap and drm_mmap to use PAT WC instead of MTRRs
Message-Id: <CALCETrVe=JSPB=x79e1fAK=DrMgo7_Liagihib9quJDJ0N670Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1367621038.git.luto@amacapital.net> <d6e5e371e464b7de1115a00f02b5b834315cd986.1367621039.git.luto@amacapital.net>
In-Reply-To: <d6e5e371e464b7de1115a00f02b5b834315cd986.1367621039.git.luto@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>

On Fri, May 3, 2013 at 4:00 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
> ---
>
> This needs careful review.  I don't really know what this code does, nor
> do I have the hardware.  (I don't understand AGP and the associated
> caching implications.)

This patch is wrong (I didn't update the matching mtrr_del), and I'm
reworking this whole series.  But I may need some help on this one:
why is the mtrr handle of a map (whatever a map is) exported to
userspace via the ADD_MAP and GET_MAP ioctls?  What (if anything) is
userspace supposed to do with it?  Do I need to return a valid MTRR
register number?  Is there any userspace code at all that sets
_DRM_WRITE_COMBINING in DRM_IOCTL_ADD_MAP with appropriate alignment
and needs the MTRR, for which the drm driver doesn't already add the
MTRR?

--Andy
