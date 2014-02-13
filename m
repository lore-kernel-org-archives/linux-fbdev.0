From: "Alexander E. Patrakov" <patrakov@gmail.com>
Date: Thu, 13 Feb 2014 06:37:51 +0000
Subject: Re: Fixing the kernels backlight API
Message-Id: <52FC683F.10905@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <52FB8F45.9060006@redhat.com>	<CAPM=9tyYLuoTtW69-cPx-JSuar++D5WEtYRZr_-aP7uowZpVyA@mail.gmail.com>	<20140212204311.GH3891@intel.com>
	<CANq1E4R=UVo5YVPUrdRFeobAE-qU6e-+GHZ2VJwwaa8zEO6g3Q@mail.gmail.com>
In-Reply-To: <CANq1E4R=UVo5YVPUrdRFeobAE-qU6e-+GHZ2VJwwaa8zEO6g3Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?ISO-8859-1?Q?Ville_Syrj=E4?= =?ISO-8859-1?Q?l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

13.02.2014 04:26, David Herrmann wrote:
> The "attach" stuff actually sounds doable, but who decides which one
> to attach? You still need some user-space script during device-plug
> for that.
> But to be honest, the simplest way would be a "backlightd"
> bus-activatable daemon. SetBacklight() then takes a DRM-connector and
> brightness-value, which the daemon looks up in /sys and sets.. This
> has the advantage that we can do any fancy matching in user-space. We
> can provide quirks (maybe even via udev-hwdb) and other helpers for
> weird setups.

What would be done with Samsung monitors (like an old SyncMaster 770P) 
that have a DVI connection, no physical buttons and have to be 
controlled via DDC-CI? Currently, ddccontrol works (via /dev/i2c-*), but 
only from root. I would like this use case to be covered in such a way 
that it could work both in Xorg and in Wayland, and, if possible, 
without races related to i2c usage from the kernel and from userspace.

-- 
Alexander E. Patrakov
