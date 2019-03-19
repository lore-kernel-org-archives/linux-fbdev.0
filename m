From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Date: Tue, 19 Mar 2019 16:46:51 +0000
Subject: Re: Indirect call in vesafb driver
Message-Id: <20190319164651.4ec9e3d1@alans-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190313145418.bwta37cogo7a4qtt@K55DR>
In-Reply-To: <20190313145418.bwta37cogo7a4qtt@K55DR>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Pateenok <pateenoc@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 17:54:18 +0300
Alexander Pateenok <pateenoc@gmail.com> wrote:

> Hi,
> 
> There're several indirect calls in inline assembly in vesafb driver
> (drivers/video/fbdev/vesafb.c), and these calls cannot be automatically
> changed to retpolines. It's in vesafb_pan_display():
> 
>    73        __asm__ __volatile__(
>    74                "call *(%%edi)"
> 
> and in vesa_setpalette():
> 
>   113        __asm__ __volatile__(
>   114         "call *(%%esi)"
> 
> Is there need to use CALL_NOSPEC ?

Vesafb is from the time on the dinosaurs but yes any vesa bios code will
not be speculatively hardened. I'd also doubt anyone is actually using
vesafb in the first place but it should use nospec

Alan
