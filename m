From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Mon, 23 Mar 2015 11:14:55 +0000
Subject: Re: [PATCH RESEND 2 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <CAA5enKaPnRBT=8Tkx7rm6GQYXMvA=pwxmRYpnkRU8uHok8ypUg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426864935-29350-1-git-send-email-lstoakes@gmail.com> <20150323105323.GA10964@mwanda>
In-Reply-To: <20150323105323.GA10964@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 23 March 2015 at 10:53, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Sorry I wasn't clear on this before.  Please, stop putting RESEND in the
> subject.  That's only for if you think we are screwing up or ignoring
> you.  Just put v2, and put what changed under the --- cut off.
> ---
> v2: changed the commit message
>
> https://www.google.com/#q=how+to+send+a+v2+patch
>

I have to say I'm quite massively confused on this :) and the linux
newbies link at the top of the results for that google search doesn't
seem to clear it up for me. May I be so cheeky as to ask you to help
me understand so I can do this better in future?:-

* Greg has asked me to send again because it wasn't clear which set
was applicable. This is why I appended RESEND 2 (the original RESEND
was the same deal but *also* containing fixups to apply to the latest
staging-testing) since I wasn't changing anything, just resending to
make clear which patch set is valid right now. In this case should I
simply append a version number to each patch in the series and resend?
* Which leads on to the next point of confusion - previously when I
changed *one* patch in a series then resent *all* patches in that
series with v2, I had complaints that 'this patch hasn't changed' on
the unchanged patches, leading me to think that you should only resend
patches that have actually changed (which fits the pattern of putting
a change message under the '---' - though of course you could say v2:
resend patchset or similar) - however this seems to be what causes the
confusion that leads to needing a resend in the first instance (maybe
a problem with options I'm passing to git send-email, perhaps I need
to use in-reply-to to make the v2's replies to the v1's.)
* If the former point is correct and I should only resend patches that
have actually changed, but I'm asked for a resend - what is the
correct course of action? And of course we end up with some patches at
v>1, some at v1, so should all patches then be updated to v(MAX(v)+1)?

> Otherwise this set looks ok.  Thanks!
>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
>

Thanks for that, appreciated!

Best,

-- 
Lorenzo Stoakes
https:/ljs.io
