From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 15 Dec 2011 11:39:31 +0000
Subject: Re: [PATCH 48/57] fbdev: sh_mobile_meram: Allocate ICBs automatically
Message-Id: <201112151239.32084.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323784972-24205-49-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1323784972-24205-49-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Damian,

On Thursday 15 December 2011 03:58:12 Damian Hobson-Garcia wrote:
> Hi Laurent,
> 
> On 2011/12/13 23:02, Laurent Pinchart wrote:
> > Instead of manually specifying the ICBs to use in platform data,
> > allocate them automatically at runtime.
> > 
> > The MERAM registration function now returns a pointer to an opaque MERAM
> > object, which is passed to the update and unregistration functions.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> 
> So one concern that I have about this is in regards to sharing ICBs with
> user-space drivers. Since there are user space drivers (via UIO) for blocks
> like the VEU, that may want to have access to MERAM, we need a way to
> communicate which ICBs are free to user space. With the hard-coded platform
> data we could easily assume that kernel drivers would use, for example, the
> upper 16 ICBs and so user-space drivers were free to use the lower 16.

You're right, I forgot about that :-/

> One simple temporary workaround might be to provide a range of useable ICBs
> in the platform data. The MERAM memory allocation range can always easily be
> tweaked by using the meram_resources structure.

That sounds good to me. I'll implement that.

-- 
Regards,

Laurent Pinchart
