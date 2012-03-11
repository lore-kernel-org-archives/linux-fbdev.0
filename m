From: santosh prasad nayak <santoshprasadnayak@gmail.com>
Date: Sun, 11 Mar 2012 14:49:21 +0000
Subject: Re: [PATCH] Video : Amba: Use in_interrupt() in clcdfb_sleep().
Message-Id: <CAOD=uF5GbsyHS5iXjJ1YcqJyGLHwT8Wjhiie1daJAVqu527Umg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331471665-22226-1-git-send-email-santoshprasadnayak@gmail.com>
	<20120311132746.GA13336@n2100.arm.linux.org.uk>
	<CAOD=uF7kQHABCmxUL3-J-hZ1E2mXrb7dgsYq7msHhiPJ4Gm-Ew@mail.gmail.com>
	<20120311143615.GB13336@n2100.arm.linux.org.uk>
In-Reply-To: <20120311143615.GB13336@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sun, Mar 11, 2012 at 8:06 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Mar 11, 2012 at 07:47:27PM +0530, santosh prasad nayak wrote:
>> Not to use in_atomic() =A0in driver code.
>>
>> =A0Following article =A0inspired me to do the change.
>> http://lwn.net/Articles/274695/
>>
>> "in_atomic() is for core kernel use only. Because in special
>> circumstances (ie: kmap_atomic()) we run inc_preempt_count() even on
>> non-preemptible kernels to tell the per-arch fault handler that it was
>> invoked by copy_*_user() inside kmap_atomic(), and it must fail.
>> In other words, in_atomic() works in a specific low-level situation,
>> but it was never meant to be used in a wider context. Its placement in
>> hardirq.h next to macros which can be used elsewhere was, thus, almost
>> certainly a mistake. As Alan Stern pointed out, the fact that Linux
>> Device Drivers recommends the use of in_atomic() will not have helped
>> the situation. Your editor recommends that the authors of that book be
>> immediately sacked. "
>>
>> In the present case, we just check whether its an IRQ context or user
>> context. So for that
>> we can use "in_interrupt()".
>>
>> Greg also mentions the same in the following mail.
>> http://www.spinics.net/lists/newbies/msg43402.html
>
> In which case, we'll just have to do mdelay() and forget about allowing
> anything else to run for the 20ms that we need to sleep. =A0Sucky but
> that's the way things are.

 mdelay() or msleep() are there before. I did not change that.


my point is :  in_atomic()  vs "in_interrupt()".
We should avoid to use "in_atomic()" in driver code.

In the present case to check IRQ context "in_interrupt()" should be preferr=
ed.


regards
Santosh

regards
Santosh
