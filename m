From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Feb 2011 00:54:44 +0000
Subject: Re: Linux 2.6.38-rc6
Message-Id: <AANLkTin7+AHAqKz5T-1_=N6tqPytyT4ooqyJuhHC6ET=@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTi=TTZ57d1wUz1uH3R6igN8O77iDvSLMW=t86g9V@mail.gmail.com>
 <20110222140349.GA20708@kryptos.osrc.amd.com> <AANLkTikESHHfjBqoLFOno6qQz-NXEAo-wBY5JEeAW61N@mail.gmail.com>
 <AANLkTinh4pF7iaUGMcv_9gPy+VBD5POsTHbF_2zPJ17r@mail.gmail.com>
 <AANLkTi=Ys4mb4pc28cH4NMdtMgb2KewJbkXEGJmEP4J0@mail.gmail.com>
 <AANLkTinxHVDwSCouTaZEvR3yTJnSPAas9z6JauGDdS7=@mail.gmail.com>
 <AANLkTinD2cC9dGg2eBtZQhWvhSsuH2BcWDj8byLhWWso@mail.gmail.com>
 <AANLkTin8+F003-jFoQ0pd9OjN1oT2iqyNjd58SDJZuMK@mail.gmail.com>
 <AANLkTinzse1ZfEvAuWfuZ_8VDypcnD5poU6GwOdYTgWh@mail.gmail.com> <AANLkTi=wbtcAOmYE8UF7ynPZ_nR3ZXxVRBcuMVGNK4u0@mail.gmail.com>
In-Reply-To: <AANLkTi=wbtcAOmYE8UF7ynPZ_nR3ZXxVRBcuMVGNK4u0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Anca Emanuel <anca.emanuel@gmail.com>
Cc: Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org, Borislav Petkov <bp@amd64.org>, Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Feb 24, 2011 at 4:48 PM, Anca Emanuel <anca.emanuel@gmail.com> wrot=
e:
>
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index e2bf953..e8f8925 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -1511,6 +1511,7 @@ void remove_conflicting_framebuffers(struct
> apertures_struct *a,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s vs %s - r=
emoving generic driver\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name, registe=
red_fb[i]->fix.id);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unregister_framebuffer(reg=
istered_fb[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 registered_fb[i] =3D NULL;
>
> Tested the patch, and now I get this:
> dmesg: http://pastebin.com/ieMNrA7C
>
> [ =A0 12.252328] BUG: unable to handle kernel NULL pointer dereference
> at 00000000000003b8
> [ =A0 12.252342] IP: [<ffffffff81311178>] fb_mmap+0x58/0x1d0

Ok, goodie.

Or not so goodie, but it does make it clear that yeah, the fb code
seems to be using stale pointers from that registered_fb[] array, and
the whole unregistration process is just racing with people using it.

Herton had that much bigger patch, can you test it?

                         Linus
