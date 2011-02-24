From: Anca Emanuel <anca.emanuel@gmail.com>
Date: Thu, 24 Feb 2011 13:20:19 +0000
Subject: Re: Linux 2.6.38-rc6
Message-Id: <AANLkTin8+F003-jFoQ0pd9OjN1oT2iqyNjd58SDJZuMK@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTi=TTZ57d1wUz1uH3R6igN8O77iDvSLMW=t86g9V@mail.gmail.com>
	<20110222140349.GA20708@kryptos.osrc.amd.com>
	<AANLkTikESHHfjBqoLFOno6qQz-NXEAo-wBY5JEeAW61N@mail.gmail.com>
	<AANLkTinh4pF7iaUGMcv_9gPy+VBD5POsTHbF_2zPJ17r@mail.gmail.com>
	<AANLkTi=Ys4mb4pc28cH4NMdtMgb2KewJbkXEGJmEP4J0@mail.gmail.com>
	<AANLkTinxHVDwSCouTaZEvR3yTJnSPAas9z6JauGDdS7=@mail.gmail.com>
	<AANLkTinD2cC9dGg2eBtZQhWvhSsuH2BcWDj8byLhWWso@mail.gmail.com>
In-Reply-To: <AANLkTinD2cC9dGg2eBtZQhWvhSsuH2BcWDj8byLhWWso@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org, Borislav Petkov <bp@amd64.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Feb 24, 2011 at 2:28 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Feb 23, 2011 at 9:16 AM, Anca Emanuel <anca.emanuel@gmail.com> wr=
ote:
>>>
>>> Looks like nouveafb took over from vesafb. Did you do anything special
>>> to trigger this?
>>
>> No. Just boot the system.
>
> Every boot?

Yes.

>
> And just out of interest, what happens if you don't have the vesafb
> driver at all?
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
>

I used 'e' option from grub, removed the 'set gfxpayload =3D $linux_gfx_mod=
e'
and it works.

dmesg: http://pastebin.com/JAZsk4vD
