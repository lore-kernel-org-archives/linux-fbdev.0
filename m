From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 03 Aug 2020 08:45:07 +0000
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
Message-Id: <CAKMK7uEV+CV89-L1Y=dijOEy8DKE=juRfQDnNnbhbAJhFh1fYw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <659f8dcf-7802-1ca1-1372-eb7fefd4d8f4@kernel.org>
 <dbcf2841-7718-2ba7-11e0-efa4b9de8de1@nsfocus.com>
 <9fb43895-ca91-9b07-ebfd-808cf854ca95@nsfocus.com>
 <9386c640-34dd-0a50-5694-4f87cc600e0f@kernel.org>
 <20200803081823.GD493272@kroah.com>
In-Reply-To: <20200803081823.GD493272@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Greg KH <greg@kroah.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Kyungtae Kim <kt0755@gmail.com>, Solar Designer <solar@openwall.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, DRI devel <dri-devel@lists.freedesktop.org>, =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>, Anthony Liguori <aliguori@amazon.com>, Yang Yingliang <yangyingliang@huawei.com>, xiao.zhang@windriver.com, Jiri Slaby <jirislaby@kernel.org>, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>

On Mon, Aug 3, 2020 at 10:26 AM Greg KH <greg@kroah.com> wrote:
>
> On Mon, Aug 03, 2020 at 10:08:43AM +0200, Jiri Slaby wrote:
> > Hi,
> >
> > On 31. 07. 20, 7:22, 张云海 wrote:
> > > Remove whitespace at EOL
> >
> > I am fine with the patch. However it should be sent properly (inline
> > mail, having a PATCH subject etc. -- see
> > Documentation/process/submitting-patches.rst). git send-email after git
> > format-patch handles most of it.
> >
> > There is also question who is willing to take it?
> >
> > Bart? Greg? Should we route it via akpm, or will you Linus directly? (I
> > can sign off and resend the patch which was attached to the mail I am
> > replying to too, if need be.)
>
> I can take it, if Bart can't, just let me know.

Yeah vt stuff and console drivers != fbcon go through Greg's tree past
few years ...

Greg, should we maybe add a MAINTAINERS entry that matches on all
things console? With tty/vt you definitely have the other side of that
coin already :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
