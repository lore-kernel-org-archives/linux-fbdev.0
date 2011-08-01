From: Tormod Volden <lists.tormod@gmail.com>
Date: Mon, 01 Aug 2011 22:56:11 +0000
Subject: Re: Patch fixing savagefb driver typo/regression in linux-3.0.0
Message-Id: <CAArsGaZo8bL2ooPggaFsg04Jr7oQOPMvuVJ65nVqq_nh7XNLuQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Sun, Jul 31, 2011 at 12:04 PM, John Stanley wrote:
> =A0I have an old T22 Thinkpad with integrated Savage/IX-MV video. As of
> linux-3.0, the video is non-functional; the PC either hard hangs immediat=
ely
> or has totally garbled video, and then hard hangs, as soon as I attempt to
> edit a file or cat a file with more than a screen-full of text. The
> foregoing details are actually not important any more as in looking at the
> code changes I discovered a typo in
> linux-3.0.0/drivers/video/savage/savagefb.h and have applied the attached
> patch to fix the issue.

John, you are absolutely correct. My bad, this was from a commit of
mine. You may add my
 Reviewed-by: Tormod Volden <debian.tormod@gmail.com>
to your patch. I'd suggest you change the patch description (mail
subject) to "[PATCH] Fix typo in savage4 series definition" or
something similar.

The patch should also go into the stable series (by cc'ing
stable@vger.kernel.org if I remember correctly).

> PLEASE NOTE:
> =A0I realize that the patch does not quite adhere to linux kernel patch
> coding-style conventions (in particular, spaces around logical operators,
> and lines not exceeding 80 chars), but I have simply changed an
> '||' to an '&&' -- and NOT attempted to resolve pre-existing coding-style
> violations.

I also preserved the old coding style, which is the same in the xorg
driver which shares much of this code. We can always change it there
as well if somebody would like to fix it up.

>
> thanks much,
> John
>
> P.S. Many, many thanks for lifting the 800x600 resolution limit! I've been
> using a patch/hack to bump the limit to 1024x768 for an very long time...

Glad to hear that! So there are still other savagefb users around :)
My apologies to those who were affected by the typo.

Cheers,
Tormod
