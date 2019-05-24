From: Grzegorz Halat <ghalat@redhat.com>
Date: Fri, 24 May 2019 13:52:31 +0000
Subject: Re: [PATCH] vt/fbcon: deinitialize resources in visual_init() after failed memory allocation
Message-Id: <CAKbGCscp6gLFEuu+xn24KM6Gy=x=pW9bnJGF_2CY3jzbnyV5_g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190426145946.26537-1-ghalat@redhat.com> <CAKbGCscqbvOaXPTdmxatNLBygdu=WC0hVUKx0_WnqUR4+dj_zQ@mail.gmail.com>
 <20190524080602.GA19514@kroah.com>
In-Reply-To: <20190524080602.GA19514@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jiri Slaby <jslaby@suse.com>, Oleksandr Natalenko <oleksandr@redhat.com>

On Fri, 24 May 2019 at 10:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> How?  How are you triggering a memory allocation failure in a "normal"
> system?
> Anyway, I'll queue this up, but it really does not seem like anything
> anyone would see "in the wild"

I've seen this crash twice in ours customer environment under low
memory conditions.
There is a report in Debian bug tracker:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=804443
and LKML bug report:
https://lkml.org/lkml/2017/12/18/591

--
Grzegorz
