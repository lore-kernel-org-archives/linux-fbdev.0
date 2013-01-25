From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Jan 2013 00:53:46 +0000
Subject: Re: [git pull] fbcon locking fixes.
Message-Id: <CA+55aFxzDv0emWgyde7iEWpgZarAGaExrKbEHFr-UcbhoeH_Cw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.00.1301250041001.25545@skynet.skynet.ie>
In-Reply-To: <alpine.DEB.2.00.1301250041001.25545@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@linux.ie>
Cc: Andrew Morton <akpm@linux-foundation.org>, DRI mailing list <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Thu, Jan 24, 2013 at 4:42 PM, Dave Airlie <airlied@linux.ie> wrote:
>
> These patches have been sailing around long enough, waiting for a maintainer
> to reappear, so I've decided enough is enough, lockdep is kinda useful to have.

Last this was tried, these patches failed miserably.

They caused instant lockdep splat and then a total lockup with efifb.
It may be that Takashi's patch helps fix that problem, but it's in no
way clear that it does, so the patch series isn't at all obviously
stable.

Yes, lockdep is indeed "kinda useful", and there clearly are locking
problems in fbdev. But I'm not seeing myself pulling these for 3.8.
They've been too problematic to pull in at this late stage.

              Linus
