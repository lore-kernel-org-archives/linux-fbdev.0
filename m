From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 13 Dec 2016 07:36:09 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <1481614569.27088.67.camel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
         <1481158879.26959.41.camel@kernel.crashing.org>
         <035da7a8-5a3f-1ef6-f686-479773e78084@ti.com>
         <1481232210.26959.47.camel@kernel.crashing.org>
In-Reply-To: <1481232210.26959.47.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, airlied@linux.ie, linux-kernel@vger.kernel.org

  Hi,

> Well, I had that argument with Dave Airlie which I CCed. The "dumb" ones like
> bochsdrmfb, cirrusdrmfb, astdrmfb ... all use shadowing, meaning they use a
> lot more memory and cannot do any 2D acceleration for fbcon.

Well, at least for cirrusdrmfb using 2d accel is kida pointless as this
only shifts the software bitblit from the kernel to qemu ...

cheers,
  Gerd

