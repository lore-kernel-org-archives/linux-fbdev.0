From: "Hadli, Manjunath" <manjunath.hadli@ti.com>
Date: Wed, 19 Oct 2011 11:40:17 +0000
Subject: RE: [RFC PATCH 0/3] fbdev driver for dm644x
Message-Id: <B85A65D85D7EB246BE421B3FB0FBB5930328A9BD1A@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello,

Can some one review this patches, so that I can issue a pull request.

Thanks.

Regards,
--Manju

On Mon, Sep 26, 2011 at 19:05:06, Hadli, Manjunath wrote:
> This patch series adds an fbdev driver for Texas Instruments Davinci SoC.The display subsystem consists of OSD and VENC, with OSD supporting 2 RGb planes and
> 2 video planes.
> http://focus.ti.com/general/docs/lit/
> getliterature.tsp?literatureNumber=sprue37d&fileType=pdf
> 
> A good amount of the OSD and VENC enabling code is present in the kernel, and this patch series adds the fbdev interface.
> 
> The fbdev driver exports 4 nodes representing each plane to the user - from fb0 to fb3.
> 
> Manjunath Hadli (3):
>   davinci: vpbe: enable vpbe for fbdev addition
>   davinci: vpbe: add fbdev driver for dm644x
>   davinci: vpbe: add build infrastructure for fbdev driver
> 
>  drivers/media/video/davinci/Kconfig         |   13 +
>  drivers/media/video/davinci/Makefile        |    1 +
>  drivers/media/video/davinci/vpbe_display.c  |    6 +
>  drivers/media/video/davinci/vpbe_fb.c       | 2537 +++++++++++++++++++++++++++
>  drivers/media/video/davinci/vpbe_fb.h       |   66 +
>  drivers/media/video/davinci/vpbe_fb_ioctl.h |  159 ++
>  drivers/media/video/davinci/vpbe_osd.c      |  793 +++++++++-
>  drivers/media/video/davinci/vpbe_venc.c     |   84 +
>  include/media/davinci/vpbe_osd.h            |   64 +-
>  include/media/davinci/vpbe_venc.h           |   21 +
>  10 files changed, 3735 insertions(+), 9 deletions(-)  create mode 100644 drivers/media/video/davinci/vpbe_fb.c
>  create mode 100644 drivers/media/video/davinci/vpbe_fb.h
>  create mode 100644 drivers/media/video/davinci/vpbe_fb_ioctl.h
> 
> 

