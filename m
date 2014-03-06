From: Haojian Zhuang <haojian.zhuang@gmail.com>
Date: Thu, 06 Mar 2014 02:09:49 +0000
Subject: Re: [PATCH 0/4] Cleanups and fix for video/pxa3xx-gcu
Message-Id: <CAN1soZzqzdp3X6ac=Hop4XULrGRS9mggakRUG=h5NMhpmvA4ig@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394035969-32420-1-git-send-email-zonque@gmail.com>
In-Reply-To: <1394035969-32420-1-git-send-email-zonque@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Mar 6, 2014 at 12:12 AM, Daniel Mack <zonque@gmail.com> wrote:
> Here are some cleanups for the pxa3xx-gcu driver. Patch 3/4 is actually
> a real bugfix that is needed since the misc code doesn't set
> file->private_data for us implicitly anymore.
>
> The rest are just straight-forward cleanups.
>
> Thanks,
> Daniel
>
>
> Daniel Mack (4):
>   video: pxa3xx-gcu: rename some symbols
>   video: pxa3xx-gcu: pass around struct device *
>   video: pxa3xx-gcu: provide an empty .open call
>   video: pxa3xx-gcu: switch to devres functions
>
>  drivers/video/pxa3xx-gcu.c | 191 +++++++++++++++++++--------------------------
>  1 file changed, 81 insertions(+), 110 deletions(-)
>
> --
> 1.8.5.3
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
