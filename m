From: Dave Hylands <dhylands@gmail.com>
Date: Sat, 19 Dec 2009 09:13:11 +0000
Subject: Re: drivers/gpu/drm/radeon/radeon_test.c:45: undefined reference to
Message-Id: <c32efac40912190113i5292a395tcc257c16a4870f3b@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LNX.2.01.0912181147200.9874@filesrv1.baby-dragons.com>
In-Reply-To: <alpine.LNX.2.01.0912181147200.9874@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org, Linux Kernel Maillist <linux-kernel@vger.kernel.org>

Hi Jim,

On Fri, Dec 18, 2009 at 12:54 PM, Mr. James W. Laferriere
<babydr@baby-dragons.com> wrote:
> =A0 =A0 =A0 =A0Hello Benjamin , =A0I am not having a good time compiling =
2.6.32.1 .
> First RCU 'inline' difficulties then fusion-mpt 'inline' difficulty , =A0=
Now
> this .
> =A0 =A0 =A0 =A0This one is not a simple as removing 'inline' from a state=
ment .
> =A0 =A0 =A0 =A0Would you please look into this ? =A0Anything else you nee=
d please just
> ask .
> =A0 =A0 =A0 =A0Please cc: me as I am not subscribed to linux-fbdev .
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Tia , =A0JimL
>
...snip...
> drivers/built-in.o(.text+0x11345a): In function `radeon_test_moves':
> drivers/gpu/drm/radeon/radeon_test.c:45: undefined reference to `__udivdi=
3'
> make: *** [.tmp_vmlinux1] Error 1

__udivdi3 is a gcc helper function used to do 64-bit division. This
form of 64-bit division is not supported from within the kernel (which
is why you get the undefined symbol).

There is <asm/div64.h> which contains a macro called do_div which can
perform a 64-bit dvision by a 32-bit divisor.

--=20
Dave Hylands
Shuswap, BC, Canada
http://www.DaveHylands.com/
