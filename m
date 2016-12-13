From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 13 Dec 2016 07:33:24 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <1481614404.27088.64.camel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1481158879.26959.41.camel@kernel.crashing.org>
 <20161208101005.6ufl3d4qvwprosju@phenom.ffwll.local>
 <1481232519.26959.49.camel@kernel.crashing.org>
 <CAPM=9twUSRvfmh2ENMXTwCx-ULGzmPpyHs_wMM0XGDeWHMhnXw@mail.gmail.com>
In-Reply-To: <CAPM=9twUSRvfmh2ENMXTwCx-ULGzmPpyHs_wMM0XGDeWHMhnXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

  Hi,

> The acceleration that most of the 2D things provide isn't ever that
> great, and shadowing is a lot more effective if done properly.

That is probably true for anything pci-ish, because those devices are
optimized for memory writes and reads are horribly slow.  So you surely
want avoid device memory reads and shadowing is a effective way to do
this.

On arm hardware the tradeoff may look quite different, the cpus are
relatively slow and I think most arm gpus don't have dedicated device
memory ...

cheers,
  Gerd

