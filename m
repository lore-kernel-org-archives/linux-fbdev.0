From: Daniel Drake <dsd@laptop.org>
Date: Fri, 29 Oct 2010 14:03:47 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <AANLkTikkbvhdy2g8Cv7oCmgQxSmMuGnJNTGG1RfU-xac@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On 28 October 2010 23:04, Jonathan Corbet <corbet@lwn.net> wrote:
> Could you refresh my memory on that original patch?
>
> I guess we could put something into the via-core initialization that
> says:
>
> =A0 =A0 =A0 =A0if (machine_is_olpc())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0turn_02c_to_gpio();
>
> That covers only your case, and not that of anybody else who will have
> wired up a board differently, but we can let them generalize it when
> they run into trouble :)

Thats pretty much what I posted:
http://www.spinics.net/lists/linux-fbdev/msg01681.html

I now realise that all the #ifdefs are unnecessary, the code should be
there unconditionally and the compiler will remove it on non-OLPC
kernels.

The other option we have is to detect the XO-1.5 using DMI. That's the
more conventional way of detecting a specific platform in the kernel.
Florian, what do you think?

Daniel
