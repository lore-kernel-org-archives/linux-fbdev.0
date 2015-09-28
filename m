From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 28 Sep 2015 07:39:13 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <1443425953.19666.6.camel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
 <20150924144621.40e26f0a@free-electrons.com>
 <20150924152312.GV3383@phenom.ffwll.local>
 <CAMuHMdVAO8Ua4G1DRMxTKxqJaAb4xBTQie-nvOkYJ7sox-YCYw@mail.gmail.com>
 <CADnq5_NL5p+sRzOvVpr=JnZ-e-vGtDD-69qapQMKawWtfVRnCw@mail.gmail.com>
 <CAMuHMdX0Jg9RSu9rm2-trtMCDpS16Zy8VLEnmjvW_vWVWvHdVQ@mail.gmail.com>
 <CANq1E4TN4_NNs32LBcNWeDC2jUtT2TCYHfYeummEC5-TQn7BpA@mail.gmail.com>
In-Reply-To: <CANq1E4TN4_NNs32LBcNWeDC2jUtT2TCYHfYeummEC5-TQn7BpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnaud Patard <apatard@mandriva.com>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

  Hi,

> As Daniel mentioned, the connector+encoder+crtc combination is one of
> those simplifications that would make sense if more such drivers are
> added.

Another one is memory management.  It's pretty complex because it can
handle _way_ more than what simple drivers need, and the result is
_alot_ of ttm boilerplate in the drivers.

cheers,
  Gerd


