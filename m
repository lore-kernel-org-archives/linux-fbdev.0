From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 22 Aug 2012 13:18:46 +0000
Subject: Re: [PATCH 0/2] console_lock debug improvements
Message-Id: <20120822141846.3b142c12@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345588472-4055-1-git-send-email-daniel.vetter@ffwll.ch>
In-Reply-To: <1345588472-4055-1-git-send-email-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org

On Wed, 22 Aug 2012 00:34:30 +0200
Daniel Vetter <daniel.vetter@ffwll.ch> wrote:

> Hi all,
> 
> After Dave Airlie blew through a few days to track down a deadlock at boot-up
> when handing over from the firmware fb to the kms/drm framebuffer driver (1), I've
> figured that lockdep /should/ have caught this.
> 
> And indeed, by adding proper annotations to the console_lock it complains about
> the potential deadlock when exercising the entire driver life-cycle of just one
> fb driver (i.e. not even a handover required). While at it, I've replaced the
> existing in_interrupt check with the more paranoid might_sleep.
> 
> Comments, flames and review highly welcome.

This will be an absolute godsend for DRI debugging. Definitely wants to go
in.

Alan
