From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 14 Feb 2014 08:45:46 +0000
Subject: Re: Fixing the kernels backlight API
Message-Id: <52FDD7BA.6040209@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <52FB8F45.9060006@redhat.com>
	<CAPM=9tyYLuoTtW69-cPx-JSuar++D5WEtYRZr_-aP7uowZpVyA@mail.gmail.com>
	<52FCCBA1.3070303@redhat.com> <20140213171932.GB4420@srcf.ucam.org>
	<52FD204E.40507@redhat.com> <20140213201237.GA19355@srcf.ucam.org>
In-Reply-To: <20140213201237.GA19355-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: "xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

Hi,

On 02/13/2014 09:12 PM, Matthew Garrett wrote:
> On Thu, Feb 13, 2014 at 08:43:10PM +0100, Hans de Goede wrote:
> 
>> I can understand where Dave is coming from, from a kernel pov, so this
>> might really be easier to just solve in userspace. I don't know if you've
>> seen my very rough sketch of how this could work in userspace in my other
>> mail. The idea would be to still make this show up on a specific connector,
>> but only at the xrandr level, not at the drm level, and have the xserver
>> talk to some kind of backlightd for this.  The backlightd API should of cource
>> be generic enough that it can be used in wayland too.
> 
> Sure. You should probably take a look at libbacklight, which already has 
> some amount of support for appropriate heuristics.

Ah, I did not know about libbacklight, thanks for the pointer.

Note that although I believe we do need to sort out this mess, and having
something like backlightd would be a good idea, I likely won't have time to
work on this in the near future. For $dayjob I will be focussing on finishing
rootless xorg and working on libinput. And $hobbytime is all going to getting
upstream support for Allwinner ARM SoCs into place.

Still I'll put a line about this in my todo file, just don't expect anything
soon, and no promises about this at all!

Regards,

Hans
