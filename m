From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 09 Mar 2015 08:42:20 +0000
Subject: Re: [PATCH v2 1/4] staging: sm750fb: wrong type for print
Message-Id: <20150309082956.GA9059@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425886506-8643-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CA+V-a8s65fCvd2cA6w2EwaJfaLgPqQ=Hme+m9_wv+y3Y=GxPiQ@mail.gmail.com>
In-Reply-To: <CA+V-a8s65fCvd2cA6w2EwaJfaLgPqQ=Hme+m9_wv+y3Y=GxPiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LFBDEV <linux-fbdev@vger.kernel.org>, OSUOSL Drivers <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Mar 09, 2015 at 07:42:53AM +0000, Lad, Prabhakar wrote:
> On Mon, Mar 9, 2015 at 7:35 AM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> >
> > this patch will give checkpatch warnings about use of printk.
> > this patch was mainly to fix the build warnings. printk will be
> > converted to pr_* and dev_* in a later patch.
> >
> > +       printk("lynxfb mmap pgoff: %lx\n", vma->vm_pgoff);
> > +       printk("lynxfb mmap off 1: %lx\n", off);
> >
> wouldn't it makes sense to change printk to some pr_*() ?
yes, i could have. But usually Greg does not accept patches which is doing more than one type of change. That is why I mentioned in the comments that this will be converted to pr_* and dev_* in a later patch.

regards
sudip

> 
> Cheers,
> --Prabhakar Lad
