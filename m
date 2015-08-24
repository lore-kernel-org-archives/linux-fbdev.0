From: yalin wang <yalin.wang2010@gmail.com>
Date: Mon, 24 Aug 2015 08:31:13 +0000
Subject: Re: [RFC] fbdev/riva:change to use generice function to implement reverse_order()
Message-Id: <F9B74F97-EF3F-4051-B54B-B6CDD2946374@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <C21B8761-0447-45A6-B833-742E3B4C13DE@gmail.com> <55D5B3A9.6040901@ti.com> <867D66CD-9A3B-4536-B537-8C065C85E497@gmail.com> <55D6C812.6080400@ti.com> <4DCC50F3-9B6D-4A3A-9693-E7A7196564A8@gmail.com> <55D6DAE5.20304@ti.com> <20150822075310.GA2337@afzalpc>
In-Reply-To: <20150822075310.GA2337@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Afzal Mohammed <afzal.mohd.ma@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, adaplas@gmail.com, plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>


> On Aug 22, 2015, at 15:53, Afzal Mohammed <afzal.mohd.ma@gmail.com> wrote:
>=20
> Hi,
>=20
> On Fri, Aug 21, 2015 at 11:01:41AM +0300, Tomi Valkeinen wrote:
>=20
>>>> Possibly the patches are still good for x86 also, but that needs to be
>>>> proven.
>>>>=20
>>> not exactly, because x86_64 don=E2=80=99t have hardware instruction to =
do rbit OP,
>>> i compile by test :
>>=20
>> For old drivers i386 may be more relevant than x86_64.
>=20
> It seems asm bit reversal is supported in Kernel on arm & arm64 only,
> not sure whether any other arch even provide asm bit reversal
> instruction.

i only submit the bit reverse patch for arm / arm64 arch,
i am not sure if there are some other arch also have hard ware bit reverse =

instructions, need arch maintainers to submit if their arch also have these=
 hard
ware instructions . :)

>=20
>> These kind of optimizations should have some real world measurements,
>=20
> Not for this case, but once measured on ARM, iirc, a 32-bit asm bit
> reversal as compared to doing it in C was taking 1 cycle as opposed to
> ~225 cycles!, of course writing optimized C could have made it fare
> better, but still would reach no-way near asm bit reversal.
>=20


