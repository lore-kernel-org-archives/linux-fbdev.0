From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Date: Sun, 20 Dec 2009 01:02:02 +0000
Subject: Re: drivers/gpu/drm/radeon/radeon_test.c:45: undefined reference to
Message-Id: <alpine.LNX.2.01.0912191405460.12202@filesrv1.baby-dragons.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="566704117-1884123072-1261264791=:12202"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LNX.2.01.0912181147200.9874@filesrv1.baby-dragons.com> <c32efac40912190113i5292a395tcc257c16a4870f3b@mail.gmail.com>
In-Reply-To: <c32efac40912190113i5292a395tcc257c16a4870f3b@mail.gmail.com>
To: Dave Hylands <dhylands@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org, Linux Kernel Maillist <linux-kernel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--566704117-1884123072-1261264791=:12202
Content-Type: TEXT/PLAIN; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-ID: <alpine.LNX.2.01.0912191421091.12202@filesrv1.baby-dragons.com>

 	Hello Dave ,

On Sat, 19 Dec 2009, Dave Hylands wrote:
> Hi Jim,
> On Fri, Dec 18, 2009 at 12:54 PM, Mr. James W. Laferriere
> <babydr@baby-dragons.com> wrote:
>> =A0 =A0 =A0 =A0Hello Benjamin , =A0I am not having a good time compiling=
 2.6.32.1 .
>> First RCU 'inline' difficulties then fusion-mpt 'inline' difficulty , =
=A0Now
>> this .
>> =A0 =A0 =A0 =A0This one is not a simple as removing 'inline' from a stat=
ement .
>> =A0 =A0 =A0 =A0Would you please look into this ? =A0Anything else you ne=
ed please just
>> ask .
>> =A0 =A0 =A0 =A0Please cc: me as I am not subscribed to linux-fbdev .
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Tia , =A0JimL
>>
> ...snip...
>> drivers/built-in.o(.text+0x11345a): In function `radeon_test_moves':
>> drivers/gpu/drm/radeon/radeon_test.c:45: undefined reference to `__udivd=
i3'
>> make: *** [.tmp_vmlinux1] Error 1
>
> __udivdi3 is a gcc helper function used to do 64-bit division. This
> form of 64-bit division is not supported from within the kernel (which
> is why you get the undefined symbol).
>
> There is <asm/div64.h> which contains a macro called do_div which can
> perform a 64-bit dvision by a 32-bit divisor.
 	Thank you ,  For replying .  Now I being a kernel level nothing ,  How=20
does this help me get past the 'ld' time undefined reference ?  So we can h=
ave=20
a kernel build complete (hopefully) successfully .

 	I've another ? as well how is it that the drm/radeon_test.c is using=20
(well at least referencing) a non-kernel symbol ?  That alone is rather=20
interesting .

 	But all I had to do is Disable DRM in the kernel .  Since this system is =

a remote device without a real need for DRI/DRM support that should cure my=
=20
problem .  But someone else is going to need that support & I am sure they'=
ll=20
hit that same bug .

 		Tia ,  JimL
--=20
+------------------------------------------------------------------+
| James   W.   Laferriere | System    Techniques | Give me VMS     |
| Network&System Engineer | 3237     Holden Road |  Give me Linux  |
| babydr@baby-dragons.com | Fairbanks, AK. 99709 |   only  on  AXP |
+------------------------------------------------------------------+
--566704117-1884123072-1261264791=:12202--
