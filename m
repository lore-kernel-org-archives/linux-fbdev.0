From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 24 May 2019 15:08:33 +0000
Subject: Re: [PATCH] vt/fbcon: deinitialize resources in visual_init() after failed memory allocation
Message-Id: <20190524150833.GA10297@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190426145946.26537-1-ghalat@redhat.com>
 <CAKbGCscqbvOaXPTdmxatNLBygdu=WC0hVUKx0_WnqUR4+dj_zQ@mail.gmail.com>
 <20190524080602.GA19514@kroah.com>
 <CAKbGCscp6gLFEuu+xn24KM6Gy=x=pW9bnJGF_2CY3jzbnyV5_g@mail.gmail.com>
In-Reply-To: <CAKbGCscp6gLFEuu+xn24KM6Gy=x=pW9bnJGF_2CY3jzbnyV5_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Grzegorz Halat <ghalat@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jiri Slaby <jslaby@suse.com>, Oleksandr Natalenko <oleksandr@redhat.com>

On Fri, May 24, 2019 at 03:52:31PM +0200, Grzegorz Halat wrote:
> On Fri, 24 May 2019 at 10:06, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > How?  How are you triggering a memory allocation failure in a "normal"
> > system?
> > Anyway, I'll queue this up, but it really does not seem like anything
> > anyone would see "in the wild"
>=20
> I've seen this crash twice in ours customer environment under low
> memory conditions.
> There is a report in Debian bug tracker:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=804443
> and LKML bug report:
> https://lkml.org/lkml/2017/12/18/591

Ok, now queued up to go to Linus for 5.2-final.

thanks,

greg k-h
