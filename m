From: Sergey Kvachonok <ravenexp@gmail.com>
Subject: Re: [Linux-fbdev-devel] KMS + fb + FBIOPUT_VSCREENINFO
Date: Wed, 29 Apr 2009 14:02:40 +0300
Message-ID: <25a99abe0904290402l31e35d3ci509768a683b86096@mail.gmail.com>
References: <8563BBE2A1F848B3B98C1A5FAE08BD09@avitech.sk>
	 <21d7e9970904290027v1275c346p8a8f29d2fb4658fb@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758296AbZD2LD0@vger.kernel.org>
In-Reply-To: <21d7e9970904290027v1275c346p8a8f29d2fb4658fb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Dave Airlie <airlied@gmail.com>
Cc: Peter Hanzel <hanzelpeter@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

> The problem we've had is defining proper semantics for what happens in
> multi-output systems when
> you call this ioctl. Which crtc/output should it set the mode on?
> what happens if the mode isn't valid on all
> connected monitors etc.

Does it really makes all that much sense to run different monitors
with the same mode?
Like embedded notebook panel with weird native resolution and an
external CRT/LCD with
completely unrelated native/preferred modes.

I tried running 2.6.29.1 i915 with one fb per crtc mode,
the first thing it did was to shut down embedded panel and to attach
fbcon to external display.
As fbset doesn't work I couldn't bring the panel back to life, and the
whole thing hung when I con2fb'd one of the VTs to it. Can't provide
more specific data atm, didn't yet try to reproduce   the crash.

BTW fbxine and I believe directfb too use FBIOPUT_VSCREENINFO to
adjust vyres to the maximum to allocate offscreen surfaces for page
flipping.
It isn't really modesetting, but rather framebuffer operation, so is
the color depth setting.
At least these can be painlessly provided with the current setup.

Thanks for listening to my rant,
Sergey
