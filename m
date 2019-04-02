From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 02 Apr 2019 20:59:36 +0000
Subject: Re: [PATCH v2 4/7] fbdev: sm712fb: add 32-bit color modes, drops some other modes.
Message-Id: <CADVatmMt6Au2pGETZoKc3W9nz9ys9Up=KvsA8P0YzyUCyEDDww@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me> <20190322051759.15007-5-tomli@tomli.me>
 <20190331183333.kpyt2hm5iy6m5u34@debian> <20190401164158.GC15736@localhost.localdomain>
In-Reply-To: <20190401164158.GC15736@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, LFBDEV <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>

On Mon, Apr 1, 2019 at 5:42 PM Tom Li <tomli@tomli.me> wrote:
>
> On Sun, Mar 31, 2019 at 07:33:33PM +0100, Sudip Mukherjee wrote:
> > Why are you removing existing functionality from the driver? These are
> > supported but were never listed so could not be used. I think you can
> > just add these to vesa_mode_table[] and they can be used.
>
> If there are some "functionalities" in a system, but they are never used,
> even worse, they are programmed in a way that they cannot be used by any
> user no matter what, meanwhile not a single user had filed a bug report
> in the entire lifecycle of the program, then I'd call them "dead code",
> that serves no useful purposes, rather than "functionalities". I think
> most kernel developers can agree on this.

I think I will call that as a bug, a bug which did not export the
configuration and so it was not used. But, now that we know of the bug
we should fix the bug instead of removing the configuration.

>
> > I have an old CRT in India which supports 320x240 mode and can test there
> > when I am there next.
>
> Well... If someone (e.g. you) do see a need of this feature, then fixing
> them (instead of removing them) becomes a reasonable choice.
>
> Coincidentally, I've also purchased a video converter a few days ago. Please
> allow some time for me to testing it, so I can see if they're working. If so,
> I'll add them to the vesa_mode_table[] in PATCH v3.

Thanks.


-- 
Regards
Sudip
