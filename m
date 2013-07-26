From: Pawel Moll <pawel.moll@arm.com>
Date: Fri, 26 Jul 2013 14:41:24 +0000
Subject: Re: [RFC 0/1] drm/pl111: Initial drm/kms driver for pl111
Message-Id: <1374849684.3213.81.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>
 <CAF6AEGtspnhSGNM4_QQubVfOkZ1Gh1-Z3iyHOLBPVWuqRy81ew@mail.gmail.com>
 <1374847564.3213.70.camel@hornet>
 <CAF6AEGtNEOpuKqcr7vfieCx0mot44L2bZzOt4ipcmUVv4FwUVw@mail.gmail.com>
In-Reply-To: <CAF6AEGtNEOpuKqcr7vfieCx0mot44L2bZzOt4ipcmUVv4FwUVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Clark <robdclark@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Tom Cooksey <Tom.Cooksey@arm.com>

On Fri, 2013-07-26 at 15:21 +0100, Rob Clark wrote:
> Well, if you have something complex enough to benefit from CDF, then
> you probably ought to be looking at drm/kms. 

That's what we're doing - hope you appreciate Tom's effort of re-writing
a driver for something that pre-dates DRM/KMS by generations ;-)

> I guess I don't really care about what goes in fbdev.  

Well, I've guessed that ;-)

> My main concern is that we have more than enough work to do,
> and have more than enough complexity.  If we end up w/ bunch of glue
> to tie things in to drm properties, how drm helpers sequence things
> during modeset, locking, etc.. I just don't see that turning out well.
>  And also, just on the logistical side, having something shared across
> subsystems makes changes more of a pain during the merge window.  Not
> to mention backports to stable kernels, distro kernels, etc.  It all
> just seems like it will be a lot of unnecessary headache.

I won't argue that, however it seems to me that CDF is such a small
variable in the equation that it would disappear in the noise. Surely
you have (or will have) standard DRM interface to drive the display
pipeline where CDF would be one of many back-ends? In the end you'll
have to solve the same problem - how to represent a random pipeline in a
generic way so different components can be plugged one into another.
Anyway, I'm not planning to stick my nose between DRM and CDF, really.
I'm just hoping for a solution that will fit my needs :-)

Pawel


