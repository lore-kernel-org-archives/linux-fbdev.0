From: Daniel Drake <dsd@laptop.org>
Date: Fri, 18 Nov 2011 16:09:15 +0000
Subject: Re: Recent viafb changes break OLPC DCON freeze
Message-Id: <CAMLZHHS=x7AKbGRL3zVKO9nG=mR44_r_R9g1KsbDkoW1Ga2o7g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMLZHHQHZL9zZMsQgvXBi6MoG9_TXWqPN5D19sqeKSjsoV3unA@mail.gmail.com>
In-Reply-To: <CAMLZHHQHZL9zZMsQgvXBi6MoG9_TXWqPN5D19sqeKSjsoV3unA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Thu, Nov 17, 2011 at 8:14 PM, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> As you mentioned it, I had a look at this driver. It looks like viafb doe=
s it
> (polarity) just the other way around than geode. So it might be wort a tr=
y to
> change in
>
> drivers/video/via/share.h:
> /* 1200x900@60 Sync Polarity (DCON) */
> #define M1200X900_R60_HSP =A0 =A0 =A0 NEGATIVE
> #define M1200X900_R60_VSP =A0 =A0 =A0 NEGATIVE
>
> to
>
> /* 1200x900@60 Sync Polarity (DCON) */
> #define M1200X900_R60_HSP =A0 =A0 =A0 POSITIVE
> #define M1200X900_R60_VSP =A0 =A0 =A0 POSITIVE

That fixes the problem - thanks! Let me know if you'd like me to make
a patch with that change (I can do so on Monday).

It may still be worth you looking at the diagnosis - in particular I
think I may have found something that may clean up some of the
uncertainty in commit 32fab7bc

Thanks
Daniel
