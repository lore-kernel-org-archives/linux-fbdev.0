From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun, 27 Aug 2017 15:05:19 +0000
Subject: Re: [PATCH] vgacon, x86/boot: Prevent faulty bootparams.screeninfo from causing harm
Message-Id: <20170827150519.GA32693@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1503842206-30039-1-git-send-email-jschoenh@amazon.de>
In-Reply-To: <1503842206-30039-1-git-send-email-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Sun, Aug 27, 2017 at 03:56:46PM +0200, Jan H. Sch=F6nherr wrote:
> If a zero for the number of colums or rows manages to slip through,
> gotoxy() will underflow vc->vc_pos, causing the next action on the
> referenced memory to end with a page fault.
>=20
> Make the check in vgacon more pessimistic to prevent that. Also change
> a similar check in the x86 boot code with a similar problem.
>=20
> Signed-off-by: Jan H. Sch=F6nherr <jschoenh@amazon.de>
> ---
> Let me know, if I should split this into two patches.
>=20
>  arch/x86/boot/compressed/misc.c | 3 +--
>  drivers/video/console/vgacon.c  | 5 ++---
>  2 files changed, 3 insertions(+), 5 deletions(-)

Why send this patch to me?

And yes, of course you have to split this up, these two files have
nothing to do with each other...

greg k-h
