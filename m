From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 29 Apr 2012 23:22:20 +0000
Subject: Re: [PATCH v2 0/4] video: add support for the AUO-K190X epd controllers
Message-Id: <4F9DCD2C.7030306@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201204281218.04180.heiko@sntech.de>
In-Reply-To: <201204281218.04180.heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On 04/28/2012 10:18 AM, Heiko Stübner wrote:
> Second version of support for the Sipix epd controllers made by AUO.
> 
> Changes were made to the common code in patch 2, including fixing
> the Kconfig options as suggested by Florian Tobias Schandinat and
> fixing a possible runtime-pm mismatch if the deferred_io
> callback was called without a prior call to first_io.

Not entirely correct: I suggested to change it into menuconfig, you
changed it into config. Well, actually I like your solution better than
mine ;)

> 
> Heiko Stübner (4):
>   fb_defio: add first_io callback
>   video: auo_k190x: add code shared by controller drivers
>   video: auo_k190x: add driver for AUO-K1900 variant
>   video: auo_k190x: add driver for AUO-K1901 variant

Applied this series.


Thanks,

Florian Tobias Schandinat

> 
>  drivers/video/Kconfig       |   33 ++
>  drivers/video/Makefile      |    3 +
>  drivers/video/auo_k1900fb.c |  198 ++++++++
>  drivers/video/auo_k1901fb.c |  251 +++++++++++
>  drivers/video/auo_k190x.c   | 1046 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/video/auo_k190x.h   |  129 ++++++
>  drivers/video/fb_defio.c    |    4 +
>  drivers/video/smscufx.c     |    2 +-
>  drivers/video/udlfb.c       |    2 +-
>  include/linux/fb.h          |    1 +
>  include/video/auo_k190xfb.h |  106 +++++
>  11 files changed, 1773 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/video/auo_k1900fb.c
>  create mode 100644 drivers/video/auo_k1901fb.c
>  create mode 100644 drivers/video/auo_k190x.c
>  create mode 100644 drivers/video/auo_k190x.h
>  create mode 100644 include/video/auo_k190xfb.h
> 

