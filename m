From: Josh Boyer <jwboyer@gmail.com>
Date: Fri, 25 Jan 2013 14:08:09 +0000
Subject: Re: [PATCH] fbcon: fix locking harder
Message-Id: <CA+5PVA5JTfBeO7NUp91TUxWhCEvsjR1EEiD-4Ji_UP4LbnTB1Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359078224-3327-1-git-send-email-airlied@gmail.com>
In-Reply-To: <1359078224-3327-1-git-send-email-airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.sf.net, linux-kernel@vger.kernel.org

On Thu, Jan 24, 2013 at 8:43 PM, Dave Airlie <airlied@gmail.com> wrote:
> Okay so Alan's patch handled the case where there was no registered fbcon,
> however the other path entered in set_con2fb_map pit.
>
> In there we called fbcon_takeover, but we also took the console lock in a couple
> of places. So push the console lock out to the callers of set_con2fb_map,
>
> this means fbmem and switcheroo needed to take the lock around the fb notifier
> entry points that lead to this.
>
> This should fix the efifb regression seen by Maarten.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>

Linus might not be taking this for 3.8 because of lack of testing, but
that doesn't mean the problems don't exist in 3.8 (and older).  Maybe
throw a CC for stable on the patch?  That way it works its way back when
it does get merged.

josh
