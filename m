From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Wed, 25 May 2011 16:19:17 +0000
Subject: Re: [PATCH] fbmem: fix race condition between
Message-Id: <20110525181917.12cf97b8@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306266871-12464-1-git-send-email-lxnay@sabayon.org>
	<20110524224545.08c53b1d@neptune.home>
In-Reply-To: <20110524224545.08c53b1d@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Fabio Erculiani <lxnay@sabayon.org>
Cc: linux-fbdev@vger.kernel.org, lethal@linux-sh.org, linux-kernel@vger.kernel.org

On Tue, 24 May 2011 Bruno Pr=C3=A9mont <bonbons@linux-vserver.org> wrote:
> On Tue, 24 May 2011 Fabio Erculiani <lxnay@sabayon.org> wrote:
> > register_framebuffer() acquires registration_lock, then calls
> > do_register_framebuffer() which calls fb_notifier_call_chain()
> > which calls fb_open() which calls get_fb_info() which tries
> > (at last) to acquire registration_lock again.
> > This is a workaround.
>=20
> What calls fb_open() instead of just calling fb_info->fbops->fb_open
> when it is set?
> In other words what kernel handler of fb_notifier chain does file-based
> open of the framebuffer or is the event pushed out synchronously to
> userspace?

Note that fb_info->lock is also taken on both sides:
- per definition around all fb_notifier_call_chain() calls
- as well in fb_open() to protect fb_info->fb_ops->fb_open call.

Bruno


> > Signed-off-by: Fabio Erculiani <lxnay@sabayon.org>
> > ---
> >  drivers/video/fbmem.c |   13 ++++++++++++-
> >  1 files changed, 12 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> > index 5aac00e..b9831a0 100644
> > --- a/drivers/video/fbmem.c
> > +++ b/drivers/video/fbmem.c
> > @@ -1628,6 +1628,11 @@ static int do_register_framebuffer(struct fb_inf=
o *fb_info)
> >  	event.info =3D fb_info;
> >  	if (!lock_fb_info(fb_info))
> >  		return -ENODEV;
> > +
> > +	/* FIXME: unlock registration mutex before registration
> > +	 * notification is sent, in order to avoid deadlock.
> > +	 */
> > +	mutex_unlock(&registration_lock);
> >  	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
> >  	unlock_fb_info(fb_info);
> >  	return 0;
> > @@ -1692,7 +1697,13 @@ register_framebuffer(struct fb_info *fb_info)
> > =20
> >  	mutex_lock(&registration_lock);
> >  	ret =3D do_register_framebuffer(fb_info);
> > -	mutex_unlock(&registration_lock);
> > +	if (ret !=3D 0)
> > +		/*
> > +		 * FIXME: mutex is unlocked only if ret =3D 0.
> > +		 * This is the second part of the workaround
> > +		 * that prevents deadlocking.
> > +		 */
> > +		mutex_unlock(&registration_lock);
> > =20
> >  	return ret;
> >  }
