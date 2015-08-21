From: yalin wang <yalin.wang2010@gmail.com>
Date: Fri, 21 Aug 2015 07:46:50 +0000
Subject: Re: [RFC] fbdev/riva:change to use generice function to implement reverse_order()
Message-Id: <4DCC50F3-9B6D-4A3A-9693-E7A7196564A8@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <C21B8761-0447-45A6-B833-742E3B4C13DE@gmail.com> <55D5B3A9.6040901@ti.com> <867D66CD-9A3B-4536-B537-8C065C85E497@gmail.com> <55D6C812.6080400@ti.com>
In-Reply-To: <55D6C812.6080400@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: adaplas@gmail.com, plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>


> On Aug 21, 2015, at 14:41, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>=20
>=20
>=20
> On 20/08/15 14:30, yalin wang wrote:
>>=20
>>> On Aug 20, 2015, at 19:02, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>>=20
>>>=20
>>> On 10/08/15 13:12, yalin wang wrote:
>>>> This change to use swab32(bitrev32()) to implement reverse_order()
>>>> function, have better performance on some platforms.
>>>=20
>>> Which platforms? Presuming you tested this, roughly how much better
>>> performance? If you didn't, how do you know it's faster?
>>=20
>> i investigate on arm64 platforms:
>=20
> Ok. So is any arm64 platform actually using these devices? If these
> devices are mostly used by 32bit x86 platforms, optimizing them for
> arm64 doesn't make any sense.
>=20
> Possibly the patches are still good for x86 also, but that needs to be
> proven.
>=20
not exactly, because x86_64 don=92t have hardware instruction to do rbit OP,
i compile by test :

use the patch:
  use swab32(bitrev32()):
  2775:       0f b6 d0                movzbl %al,%edx                      =
                                                                           =
                                                  =20
  2778:       0f b6 c4                movzbl %ah,%eax
  277b:       0f b6 92 00 00 00 00    movzbl 0x0(%rdx),%edx
  2782:       0f b6 80 00 00 00 00    movzbl 0x0(%rax),%eax
  2789:       c1 e2 08                shl    $0x8,%edx
  278c:       09 d0                   or     %edx,%eax
  278e:       0f b6 d5                movzbl %ch,%edx
  2791:       0f b6 c9                movzbl %cl,%ecx
  2794:       0f b6 89 00 00 00 00    movzbl 0x0(%rcx),%ecx
  279b:       0f b6 92 00 00 00 00    movzbl 0x0(%rdx),%edx
  27a2:       0f b7 c0                movzwl %ax,%eax
  27a5:       c1 e1 08                shl    $0x8,%ecx
  27a8:       09 ca                   or     %ecx,%edx
  27aa:       c1 e2 10                shl    $0x10,%edx
  27ad:       09 d0                   or     %edx,%eax
  27af:       45 85 ff                test   %r15d,%r15d
  27b2:       0f c8                   bswap  %eax
4 memory access instructions,



without the patch:
use
do {                            \
-       u8 *a =3D (u8 *)(l);      \
-       a[0] =3D bitrev8(a[0]);   \
-       a[1] =3D bitrev8(a[1]);   \
-       a[2] =3D bitrev8(a[2]);   \
-       a[3] =3D bitrev8(a[3]);   \
-} while(0)



    277b:       45 0f b6 80 00 00 00    movzbl 0x0(%r8),%r8d
    2782:       00=20
    2783:       c1 ee 10                shr    $0x10,%esi
    2786:       89 f2                   mov    %esi,%edx
    2788:       0f b6 f4                movzbl %ah,%esi
    278b:       c1 e8 18                shr    $0x18,%eax
    278e:       0f b6 d2                movzbl %dl,%edx
    2791:       48 98                   cltq  =20
    2793:       45 85 ed                test   %r13d,%r13d
    2796:       0f b6 92 00 00 00 00    movzbl 0x0(%rdx),%edx
    279d:       0f b6 80 00 00 00 00    movzbl 0x0(%rax),%eax
    27a4:       44 88 85 54 ff ff ff    mov    %r8b,-0xac(%rbp)
    27ab:       44 0f b6 86 00 00 00    movzbl 0x0(%rsi),%r8d
    27b2:       00=20
    27b3:       88 95 56 ff ff ff       mov    %dl,-0xaa(%rbp)
    27b9:       88 85 57 ff ff ff       mov    %al,-0xa9(%rbp)
    27bf:       44 88 85 55 ff ff ff    mov    %r8b,-0xab(%rbp)

6 memory access instructions, and generate more code that the patch .

because the original code use byte access 4 times , i don=92t
think have better performance. :)

Thanks






