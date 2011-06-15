From: Wanlong Gao <wanlong.gao@gmail.com>
Date: Wed, 15 Jun 2011 06:22:59 +0000
Subject: Re: Possible deadlock when suspending framebuffer
Message-Id: <BANLkTimiv5T6cgRjkDfPwjh-c5AivYzhmA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308100165.2113.4.camel@Tux>
	<20110615075803.3348b4ec@pluto.restena.lu>
In-Reply-To: <20110615075803.3348b4ec@pluto.restena.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Francis Moreau <francis.moro@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Jun 15, 2011 at 1:58 PM, Bruno Pr=E9mont
<bonbons@linux-vserver.org> wrote:
>
> Hi,
>
> On Wed, 15 Jun 2011 09:09:24 Wanlong Gao <wanlong.gao@gmail.com> wrote:
> > <snip>
> > Hi Francis:
> > can you test this patch?
>
> Do you have a deadlock trace which you are trying to fix?
No, I just look at the code and try to fix this but I'm not sure.
Can you teach me how to have a deadlock trace here?
Thanks
>
> It's either the caller of unregister_framebuffer() which must be
> changed to not call unregister_framebuffer with info's lock held or
> the code reacting on the notification that must not try to acquire the
> lock again.
>
> The interesting par is if console semaphore has some relation to this
> deadlock as the order for taking both varies... It could be
> lock_fb_info(); console_lock() =A0versus console_lock(); lock_fb_info()
>
I see, thanks
> Bruno
>
>
> > Thanks
> >
><snip>
>
> Not a good idea to stop taking fb_lock here.
> Pretty all calls of fb_notifier_call_chain are protected by info's
> lock, except the one for FB_EVENT_FB_UNREGISTERED a few lines further.
Yup, thanks
>
> IMHO it wou make sense to add the lock around that last one so all
> notifier chain calls are handled the same.
>
> <snip>
>



--
Best regards
Wanlong Gao
