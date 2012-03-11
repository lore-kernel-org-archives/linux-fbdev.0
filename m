From: santosh prasad nayak <santoshprasadnayak@gmail.com>
Date: Sun, 11 Mar 2012 14:29:27 +0000
Subject: Re: [PATCH] Video : Amba: Use in_interrupt() in clcdfb_sleep().
Message-Id: <CAOD=uF7kQHABCmxUL3-J-hZ1E2mXrb7dgsYq7msHhiPJ4Gm-Ew@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331471665-22226-1-git-send-email-santoshprasadnayak@gmail.com>
	<20120311132746.GA13336@n2100.arm.linux.org.uk>
In-Reply-To: <20120311132746.GA13336@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Not to use in_atomic()  in driver code.

 Following article  inspired me to do the change.
http://lwn.net/Articles/274695/

"in_atomic() is for core kernel use only. Because in special
circumstances (ie: kmap_atomic()) we run inc_preempt_count() even on
non-preemptible kernels to tell the per-arch fault handler that it was
invoked by copy_*_user() inside kmap_atomic(), and it must fail.
In other words, in_atomic() works in a specific low-level situation,
but it was never meant to be used in a wider context. Its placement in
hardirq.h next to macros which can be used elsewhere was, thus, almost
certainly a mistake. As Alan Stern pointed out, the fact that Linux
Device Drivers recommends the use of in_atomic() will not have helped
the situation. Your editor recommends that the authors of that book be
immediately sacked. "

In the present case, we just check whether its an IRQ context or user
context. So for that
we can use "in_interrupt()".

Greg also mentions the same in the following mail.
http://www.spinics.net/lists/newbies/msg43402.html

Regards
Santosh

On Sun, Mar 11, 2012 at 6:57 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Mar 11, 2012 at 06:44:25PM +0530, santosh nayak wrote:
>> From: Santosh Nayak <santoshprasadnayak@gmail.com>
>>
>> Instead of "in_atomic()", we can use in_interrupt() to check whether
>> its an interrupt context.
>
> What are you trying to fix?
>
> Your description is an example of a bad commit comment. =A0It merely
> describes the change, which anyone can see by looking at the diff.
> What it totally and utterly fails to do is to describe _why_ the
> change is necessary or what the problem is.
>
> So, until it does, this patch gets a definite NAK.
