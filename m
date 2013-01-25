From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Jan 2013 01:57:30 +0000
Subject: Re: [git pull] fbcon locking fixes.
Message-Id: <CA+55aFy+JXjB+SXuH3sk2oDcqYtgW2qFbyyO0kf0D+qb13ThQA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.00.1301250041001.25545@skynet.skynet.ie>
	<CA+55aFxzDv0emWgyde7iEWpgZarAGaExrKbEHFr-UcbhoeH_Cw@mail.gmail.com>
	<CAPM=9tz6_=k1Ze5h2935-W59BCVy9KXA_z6t8inW6_-Cxw244Q@mail.gmail.com>
	<CAPM=9txUNG_CeK+YBhcA_47BVv4Z2GAmEC_J59cY+D9nRgv54A@mail.gmail.com>
In-Reply-To: <CAPM=9txUNG_CeK+YBhcA_47BVv4Z2GAmEC_J59cY+D9nRgv54A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: Maarten Lankhorst <m.b.lankhorst@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI mailing list <dri-devel@lists.freedesktop.org>, Andrew Morton <akpm@linux-foundation.org>

On Thu, Jan 24, 2013 at 5:45 PM, Dave Airlie <airlied@gmail.com> wrote:
>
> Okay I've just sent out another fbcon patch to fix the locking harder.
>
> There was a path going into set_con2fb_path if an fb driver was
> already registered, I just pushed the locking out further on anyone
> going in there.
>
> it boots on my EFI macbook here.

Ok, good. Sounds like we'll finally get it fixed, but I'm still too
much of a scaredy-cat to take it for now, so -next it is...

              Linus
