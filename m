From: Moritz Muehlenhoff <jmm@inutil.org>
Subject: Re: [PATCH] radeonfb: (#2) Implement proper workarounds for PLL accesses
Date: Sun, 10 Apr 2005 12:05:26 +0200
Message-ID: <E1DKZJn-0001dN-KQ@localhost.localdomain>
References: <1110519743.5810.13.camel@gaston> <1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de> <1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de> <1112827655.9518.194.camel@gaston> <jehdii8hjk.fsf@sykes.suse.de> <21d7e9970504071422349426eb@mail.gmail.com> <1112914795.9568.320.camel@gaston> <jemzsa6sxg.fsf@sykes.suse.de> <1112923186.9567.349.camel@gaston> <jezmw9ug7j.fsf@sykes.suse.de> <1113005006.9568.402.camel@gaston> <jey8brj4tx.fsf@sykes.suse.de> <1113089591.9518.440.camel@gaston>
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261461AbVDJKFl@vger.kernel.org>
In-Reply-To: <1113089591.9518.440.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org

Benjamin Herrenschmidt wrote:
>> radeonfb_setcolreg: INPLL
>> radeonfb_setcolreg: OUTPLL
>> radeonfb_setcolreg: OUTPLL
>> ... last three lines repeated 63 times
>
> Hrm... the last (serie of 64 setcolreg) are probably X beeing extremely
> dumb, and calling the ioctl 64 times to set each palette entry instead
> of doing a single call for the whole palette...
>
> Anyway. Except for maybe the double set-par on switch from X to console,
> there isn't much more we can do here. We might be able to improve X but
> there is a significant lag between a fix done to X.org HEAD appears in
> any distro. The fact is, according to ATI, there is a HW bug on M6 taht
> can cause lockups of the chip, and this 5ms workaround is necessary to
> avoid it... 

But it's not specific to X11; I've applied the patch you posted and the
same symptoms occur for pure tty switching as well, the delay has decreased
a bit (it's hard to measure, but around a second), but it's still rather
annoying to work with.

Is it distinguishable which M6 models are buggy? I'm using my X31 for about
a year now and have probably made some tens of thousands of switches without
lockups, so presumably not all models cause lockups.

Cheers,
        Moritz
