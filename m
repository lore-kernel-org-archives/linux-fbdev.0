From: James Simmons <jsimmons@infradead.org>
Date: Wed, 10 Mar 2010 18:04:35 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <alpine.LFD.2.00.1003101744450.4419@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
	<a5d587fb1003010118r1b586990ja4144441143bb4be@mail.gmail.com>
	<21d7e9971003022102v232c099r441b0bd843b30313@mail.gmail.com>
	<a5d587fb1003030023l355eab4dtb9f4cd62058dea3e@mail.gmail.com>
	<21d7e9971003030123q2e5d073dj68a81d612e26dc94@mail.gmail.com>
In-Reply-To: <21d7e9971003030123q2e5d073dj68a81d612e26dc94@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI development list <dri-devel@lists.sourceforge.net>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, Michal Suchanek <hramrach@centrum.cz>


> My main problem with calling the drm underneath the fbdev is it
> seems like a layering violation. Then again some of code in the kernel
> is also contributing to this violation. I'd really like to make fbdev more
> like an in-kernel version of what X driver have to do, and leave all the
> initial modepicking etc to the fbdev interface layer.
> 
> If we take  the layering as
> fbcon -> fbdev -> kms -> hw
> 
> I feel calling ioctls on the KMS layer from userspace to do stuff for
> fbcon or fbdev
> is wrong, and we should rather expose a more intelligent set of ioctls via the
> fbdev device node. This points at quite a bit of typing.

	I agree. We had the same issue with fbdev and fbcon. From the 
fbcon layer you can call stty to change the resolution. In that case the 
mode change came from fbcon to fbdev. Easy problem to handle. Well some 
people still wanted to be able to able to change their console resolution 
with fbset. Not only change the resolution on one VC (virtual consoel) but 
in some cases change the resolution on all the VCs mapped to that fbdev. 
Now some times the user wanted to change the resolution for say a game (using 
SDL for example) and then expected the fbcon resolution to be restored 
when they exited. In that case we wanted the resolution change not to be 
propagated up to the fbcon layer. The way the fbdev changes are propagated 
with a notifier chain. Now the issue of mirroring is another thing which 
was never settled on.
	Considering now the KMS layer is not so bad as it seems. The fbdev 
emulation layer already changes the drm mode (fbdev -> kms) plus in that
case you get the benefit of automatically sending a signal to the fbcon 
layer to keep it in sync. In the case of kms -> fbdev you need to update 
the fbdev state. This could be done pretty easily plus if done right would
update the fbcon state as well.
