From: Tom Li <tomli@tomli.me>
Date: Mon, 01 Apr 2019 16:26:18 +0000
Subject: Re: [PATCH v2 3/7] fbdev: sm712fb: support 2D acceleration on SM712 w/ Little-Endian CPU.
Message-Id: <20190401162618.GB15736@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-4-tomli@tomli.me>
 <20190331180947.s44eznujdeucnl7f@debian>
In-Reply-To: <20190331180947.s44eznujdeucnl7f@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Sun, Mar 31, 2019 at 07:09:47PM +0100, Sudip Mukherjee wrote:
> On Fri, Mar 22, 2019 at 01:17:55PM +0800, Yifeng Li wrote:
> I didnot notice any performace improvement in my system. Infact, I have
> never seen the performance problem that you mentioned. But, it will be
> good to have the 2D feature back again.

Are you using sm712fb under the Linux tty console? If you are using X,
Qt or DirectFB or something similar, these 2D code won't have any effect
at all, because they are only used by the Linux VT console internally.
Please try testing it under a Linux tty.

Another possibility is that you are using a high-performance CPU with
high clock/bus frequencies, which writing to the framebuffer directly
can break-even/outperform the 2D acceleration. But I'm not sure about
it. Please let me know more about your setup.

> If it is a big endian, acceleration is disabled, but you are still
> calling smtcfb_reset_accel() which will "enable Zoom Video Port,
> 2D Drawing Engine and Video Processor". Will that not create any problem
> in a big endian system?

Personally, I don't think there's an issue, because smtc_seqw() only does
8-bit I/O, and is known to be safe under Big-Endian.

But I agree, calling this function should be avoided since it's not tested.

> > +	if (unlikely(info->state != FBINFO_STATE_RUNNING))
> > +		return;
> 
> Did you measure the performance difference with and without "unlikely"?
> Quoting GregKH from https://lkml.org/lkml/2018/11/7/36
> "don't do stuff like this unless you can actually measure the
> difference".

In the old days, these two macros are used liberally, everywhere. I learned
about them by reading drivers code in fbdev/. Thanks for informing me the
new policy regarding the use of them. I'll remove them.

> <snip>
> > +		 * & HIGH with 0xffffffff (all ones, and we have already set
> > +		 * that in smtcfb_init_accel). Since the color of this mono
> > +		 * pattern is controlled by DPR_FG_COLOR, BITBLTing it with
> > +		 * ROP_COPY is effectively a rectfill().
> > +		 */
> > +		smtc_dprw(DPR_FG_COLOR, color);
> > +		smtc_dprw(DPR_DST_COORDS, DPR_COORDS(dx, dy));
> 
> I will need some more time to verify all these and other registers with
> the datasheet and test again.

No problem. 

But again, the 2D code is only used by Linux VT code internally, if you are
not using VT console, the behavior cannot be tested properly. Are you testing
it under the Linux tty console? And does your dmesg log says, "2D acceleration
is enabled"?

Running the "fbtest" testsuit is also a good way to "smoke-test" the fbdev
code.

Thanks,
Tom Li
