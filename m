From: Dave Airlie <airlied@gmail.com>
Date: Fri, 25 Jan 2013 01:06:24 +0000
Subject: Re: [git pull] fbcon locking fixes.
Message-Id: <CAPM=9tz6_=k1Ze5h2935-W59BCVy9KXA_z6t8inW6_-Cxw244Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.00.1301250041001.25545@skynet.skynet.ie>
	<CA+55aFxzDv0emWgyde7iEWpgZarAGaExrKbEHFr-UcbhoeH_Cw@mail.gmail.com>
In-Reply-To: <CA+55aFxzDv0emWgyde7iEWpgZarAGaExrKbEHFr-UcbhoeH_Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, DRI mailing list <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Fri, Jan 25, 2013 at 10:53 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jan 24, 2013 at 4:42 PM, Dave Airlie <airlied@linux.ie> wrote:
>>
>> These patches have been sailing around long enough, waiting for a maintainer
>> to reappear, so I've decided enough is enough, lockdep is kinda useful to have.
>
> Last this was tried, these patches failed miserably.
>
> They caused instant lockdep splat and then a total lockup with efifb.
> It may be that Takashi's patch helps fix that problem, but it's in no
> way clear that it does, so the patch series isn't at all obviously
> stable.
>
> Yes, lockdep is indeed "kinda useful", and there clearly are locking
> problems in fbdev. But I'm not seeing myself pulling these for 3.8.
> They've been too problematic to pull in at this late stage.
>

Okay I'll fix the efifb problem and then maybe queue them for -next.

Dave.
