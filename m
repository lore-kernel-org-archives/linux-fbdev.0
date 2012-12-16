From: Haojian Zhuang <haojian.zhuang@gmail.com>
Date: Sun, 16 Dec 2012 23:47:53 +0000
Subject: Re: [PATCHv4 1/9] video: mmp display subsystem
Message-Id: <CAN1soZxfM2=w-BAkzZ8pN0hkfdgPCUmFmvSVzSYFSoDfD=7dfg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Oct 24, 2012 at 2:56 PM, Zhou Zhu <zzhu3@marvell.com> wrote:
> Added mmp display subsystem to support Marvell MMP display controllers.
>
> This subsystem contains 4 parts:
> --fb folder
> --core.c
> --hw folder
> --panel folder
>
> 1. fb folder contains implementation of fb.
> fb get path and ovly from common interface and operates on these structures.
>
> 2. core.c provides common interface for a hardware abstraction.
> Major parts of this interface are:
> a) Path: path is a output device connected to a panel or HDMI TV.
> Main operations of the path is set/get timing/output color.
> fb operates output device through path structure.
> b) Ovly: Ovly is a buffer shown on the path.
> Ovly describes frame buffer and its source/destination size, offset, input
> color, buffer address, z-order, and so on.
> Each fb device maps to one ovly.
>
> 3. hw folder contains implementation of hardware operations defined by core.c.
> It registers paths for fb use.
>
> 4. panel folder contains implementation of panels.
> It's connected to path. Panel drivers would also regiester panels and linked
> to path when probe.
>
> Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
> Signed-off-by: Lisa Du <cldu@marvell.com>
> ---
>  drivers/video/Kconfig      |    1 +
>  drivers/video/Makefile     |    1 +
>  drivers/video/mmp/Kconfig  |    5 +
>  drivers/video/mmp/Makefile |    1 +
>  drivers/video/mmp/core.c   |  217 +++++++++++++++++++++++++++
>  include/video/mmp_disp.h   |  351 ++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 576 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/mmp/Kconfig
>  create mode 100644 drivers/video/mmp/Makefile
>  create mode 100644 drivers/video/mmp/core.c
>  create mode 100644 include/video/mmp_disp.h
>

Hi Florian,

This patch series have been sent for a long time. And there's no
comments on this.

I need this patch series on enabling LCD on pxa910 platform. Do you
think it's OK to merge?

Best Regards
Haojian
