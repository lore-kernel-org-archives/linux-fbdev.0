From: Dave Airlie <airlied@gmail.com>
Date: Tue, 18 Jul 2017 20:44:49 +0000
Subject: Re: [PATCH] efifb: allow user to disable write combined mapping.
Message-Id: <CAPM=9tyWv79U9=-YNacf34don_Gn5RGggBsZG7R9FNuV8_qe1g@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="94eb2c03fcdc3275a305549d9601"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170718060909.5280-1-airlied@redhat.com> <20170718143404.omgxrujngj2rhiya@redhat.com>
 <CA+55aFwKzwDPYFsPpuQNfBaS-dL2aD0=z1hGEnkaTT1MMfWB6Q@mail.gmail.com>
In-Reply-To: <CA+55aFwKzwDPYFsPpuQNfBaS-dL2aD0=z1hGEnkaTT1MMfWB6Q@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Jones <pjones@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Dave Airlie <airlied@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>

--94eb2c03fcdc3275a305549d9601
Content-Type: text/plain; charset="UTF-8"

On 19 July 2017 at 05:57, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, Jul 18, 2017 at 7:34 AM, Peter Jones <pjones@redhat.com> wrote:
>>
>> Well, that's kind of amazing, given 3c004b4f7eab239e switched us /to/
>> using ioremap_wc() for the exact same reason.  I'm not against letting
>> the user force one way or the other if it helps, though it sure would be
>> nice to know why.
>
> It's kind of amazing for another reason too: how is ioremap_wc()
> _possibly_ slower than ioremap_nocache() (which is what plain
> ioremap() is)?

In normal operation the console is faster with _wc. It's the side effects
on other cores that is the problem.

> Or maybe it really is something where there is one global write queue
> per die (not per CPU), and having that write queue "active" doing
> combining will slow down every core due to some crazy synchronization
> issue?
>
> x86 people, look at what Dave Airlie did, I'll just repeat it because
> it sounds so crazy:
>
>> A customer noticed major slowdowns while logging to the console
>> with write combining enabled, on other tasks running on the same
>> CPU. (10x or greater slow down on all other cores on the same CPU
>> as is doing the logging).
>>
>> I reproduced this on a machine with dual CPUs.
>> Intel(R) Xeon(R) CPU E5-2609 v3 @ 1.90GHz (6 core)
>>
>> I wrote a test that just mmaps the pci bar and writes to it in
>> a loop, while this was running in the background one a single
>> core with (taskset -c 1), building a kernel up to init/version.o
>> (taskset -c 8) went from 13s to 133s or so. I've yet to explain
>> why this occurs or what is going wrong I haven't managed to find
>> a perf command that in any way gives insight into this.
>
> So basically the UC vs WC thing seems to slow down somebody *else* (in
> this case a kernel compile) on another core entirely, by a factor of
> 10x. Maybe the WC writer itself is much faster, but _others_ are
> slowed down enormously.
>
> Whaa? That just seems incredible.

Yes I've been staring at this for a while now trying to narrow it down, I've
been a bit slow on testing it on a wider range of Intel CPUs, I've
only really managed
to play on that particular machine,

I've attached two test files. compile both of them (I just used make
write_resource burn-cycles).

On my test CPU core 1/8 are on same die.

time taskset -c 1 ./burn-cycles
takes about 6 seconds

taskset -c 8 ./write_resource wc
taskset -c 1 ./burn-cycles
takes about 1 minute.

Now I've noticed write_resource wc or not wc doesn't seem to make a
difference, so
I think it matters that efifb has used _wc for the memory area already
and set PAT on it for wc,
and we always get wc on that BAR.

From the other person seeing it:
"I done a similar test some time ago, the result was the same.
I ran some benchmarks, and it seems that when data set fits in L1
cache there is no significant performance degradation."

Dave.

--94eb2c03fcdc3275a305549d9601
Content-Type: text/x-csrc; charset="US-ASCII"; name="write_resource.c"
Content-Disposition: attachment; filename="write_resource.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j5a1myt20

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPHVuaXN0ZC5o
PgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CgppbnQgbWFpbihpbnQg
YXJnYywgY2hhciAqKmFyZ3YpCnsKCWludCBpLCBqOwoJY2hhciAqcmVzbmFtZTsKCglpZiAoYXJn
YyA+IDEgJiYgIXN0cmNtcChhcmd2WzFdLCAid2MiKSkKCQlyZXNuYW1lID0gIi9zeXMvYnVzL3Bj
aS9kZXZpY2VzLzAwMDA6MDE6MDAuMS9yZXNvdXJjZTBfd2MiOwoJZWxzZQoJCXJlc25hbWUgPSAi
L3N5cy9idXMvcGNpL2RldmljZXMvMDAwMDowMTowMC4xL3Jlc291cmNlMCI7CgoJaW50IGZkID0g
b3BlbihyZXNuYW1lLCBPX1JEV1IpOwoJaWYgKGZkID09IC0xKQoJCXJldHVybiAtMTsKCgl2b2lk
ICpwdHIgPSBtbWFwKE5VTEwsIDY0KjEwMjQsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfU0hB
UkVELCBmZCwgMCk7CglpZiAoIXB0cikKCQlyZXR1cm4gLTE7CgoJdm9sYXRpbGUgdWludDMyX3Qg
KnVwdHIgPSBwdHI7Cglmb3IgKGogPSAwOyBqIDwgMTAyNCoxMDI0OyBqKyspCglmb3IgKGkgPSAw
OyBpIDwgMTYqMTAyNDsgaSsrKSB7CgkJdXB0cltpXSA9IDA7Cgl9CgltdW5tYXAocHRyLCA2NCox
MDI0KTsKCWNsb3NlKGZkKTsKfQo=
--94eb2c03fcdc3275a305549d9601
Content-Type: text/x-csrc; charset="US-ASCII"; name="burn-cycles.c"
Content-Disposition: attachment; filename="burn-cycles.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j5a1mytp1

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2RlZmluZSBTSVpFIDEwMjQq
MTAyNAoKaW50IG1haW4odm9pZCkgewoJdm9sYXRpbGUgaW50IGksajsKCXZvbGF0aWxlIHVpbnQz
Ml90IHhbU0laRV07Cglmb3IgKGogPSAwOyBqIDwgMTAwMDsgaisrKQoJZm9yIChpID0gMDsgaSA8
IFNJWkU7IGkrKykgeFtpXSA9IDE7Cgp9Cg==
--94eb2c03fcdc3275a305549d9601--
