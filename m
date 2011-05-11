From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Wed, 11 May 2011 14:27:43 +0000
Subject: Re: [PATCH V3] fbcon -- fix race between open and removal of
Message-Id: <20110511162743.6b363f1f@pluto.restena.lu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1304617307-7389-1-git-send-email-tim.gardner@canonical.com>
	<4DC94314.8050701@canonical.com>
	<20110510234424.5a5b7a08@neptune.home>
	<4DCA9899.6070403@canonical.com>
In-Reply-To: <4DCA9899.6070403@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tim Gardner <tim.gardner@canonical.com>
Cc: linux-fbdev@vger.kernel.org, lethal@linux-sh.org, linux-kernel@vger.kernel.org, Andy Whitcroft <andy.whitcroft@canonical.com>

On Wed, 11 May 2011 16:09:29 Tim Gardner wrote:
> On 05/10/2011 11:44 PM, Bruno Pr=C3=A9mont wrote:
> > On Tue, 10 May 2011 Tim Gardner<tim.gardner@canonical.com>  wrote:
> > This only partially protects the list and count as two concurrent
> > framebuffer registrations do still race against each other.
> > For the issue addressed by this patch I don't think it makes sense to
> > have this spinlock at all as it's only used in get_framebuffer_info()
> > and in put_framebuffer_info() and put_framebuffer_info() doesn't even
> > look at registered_fb or num_registered_fb.
> > Such a spinlock makes sense in a separate patch that really protects
> > all access to registered_fb or num_registered_fb, be it during framebuf=
fer
> > (un)registration or during access from fbcon.
> >
>=20
> Our goal was merely to stop the user space open/close races. I agree=20
> that the framebuffer registration list needs more orthogonal protection, =

> but that is going to be a much larger patch.

I know that such a protection needs a much larger patch. (that would be
for 2.6.40 or 2.6.41, I have preparing patches for that cooking)

My main issue for tis patch is that the comment reads as if spinlock was
protecting registered_fb[] and num_registered_fb. So changing the
comment would be a good thing (say it protects fb_info->ref_count).
Later patch can then protect registered_fb against concurrent
framebuffer registrations.

Bruno
