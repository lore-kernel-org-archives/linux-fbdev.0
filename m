From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 29 Apr 2010 19:06:38 +0000
Subject: Re: [PATCH 24/30] viafb: Add a driver for the video capture engine
Message-Id: <20100429130638.0abff0dc@tpl.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272493051-25380-1-git-send-email-corbet@lwn.net>
	<1272493051-25380-25-git-send-email-corbet@lwn.net>
	<20100429191624.30cd67e0@neptune.home>
In-Reply-To: <20100429191624.30cd67e0@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On Thu, 29 Apr 2010 19:16:24 +0200
Bruno Pr=C3=A9mont <bonbons@linux-vserver.org> wrote:

> I think the extra 'viafb-camera' entry should be wrapped into a
>=20
> #if defined(CONFIG_FB_VIA_CAMERA) || defined(CONFIG_FB_VIA_CAMERA_MODULE)

I think you're right, yes.  (As noted above, the camera driver isn't
quite ready for merging yet - but I can't swear I would have caught
this one, so I'm glad you did).

> or probably better be dynamically added when camera module is loaded
> and/or detects/probes the camera sub-device.

That's a little harder - the platform device is the means by which the
camera and the core communicate.  I guess I could add a general "I'm a
via-core subdev and I'm here now" exported function in the core, but
I'm not sure that would be better than just having the platform dev be
there.

But it definitely shouldn't be around if the camera is configured out.

Thanks,

jon
