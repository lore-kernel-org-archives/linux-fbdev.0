From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Thu, 13 Feb 2014 20:12:37 +0000
Subject: Re: Fixing the kernels backlight API
Message-Id: <20140213201237.GA19355@srcf.ucam.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <52FB8F45.9060006@redhat.com>
	<CAPM=9tyYLuoTtW69-cPx-JSuar++D5WEtYRZr_-aP7uowZpVyA@mail.gmail.com>
	<52FCCBA1.3070303@redhat.com> <20140213171932.GB4420@srcf.ucam.org>
	<52FD204E.40507@redhat.com>
In-Reply-To: <52FD204E.40507-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

On Thu, Feb 13, 2014 at 08:43:10PM +0100, Hans de Goede wrote:

> I can understand where Dave is coming from, from a kernel pov, so this
> might really be easier to just solve in userspace. I don't know if you've
> seen my very rough sketch of how this could work in userspace in my other
> mail. The idea would be to still make this show up on a specific connector,
> but only at the xrandr level, not at the drm level, and have the xserver
> talk to some kind of backlightd for this.  The backlightd API should of cource
> be generic enough that it can be used in wayland too.

Sure. You should probably take a look at libbacklight, which already has 
some amount of support for appropriate heuristics.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
