From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Sat, 26 Sep 2015 07:29:20 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <CAKb7UvicrPD_xkXSgoSRWW9iOVd2XaKw368jxn+2GzinipSorw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
	<20150926071539.GA30836@sudip-pc>
In-Reply-To: <20150926071539.GA30836@sudip-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Arnaud Patard <apatard@mandriva.com>, Dave Airlie <airlied@redhat.com>

On Sat, Sep 26, 2015 at 3:15 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> BTW, I had a doubt about drm drivers. Is there any library or test suite
> to test the driver? I am almost halfway in making a KMS driver for SM712
> but still don't know how to test it properly. I was thinkig of asking
> Daniel offlist but since this thread came up so asking here.

Take a look at the modetest tool, part of libdrm:
http://cgit.freedesktop.org/mesa/drm/tree/tests/modetest

It's quite handy and contains command-line access to a lot of the
various KMS functionality, changing modes, configuring planes,
different formats, etc.

  -ilia
