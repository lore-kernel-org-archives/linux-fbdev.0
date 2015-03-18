From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Wed, 18 Mar 2015 11:12:20 +0000
Subject: Re: [PATCH RESEND 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <CAA5enKZYqmysuFqPPptgVvyBJAzX8UYBkod1t3Atvu3Q5TUEjQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426669046-29935-1-git-send-email-lstoakes@gmail.com> <87oanqo9zi.fsf@vitty.brq.redhat.com>
In-Reply-To: <87oanqo9zi.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 18 March 2015 at 10:50, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> ERROR is reported by scripts/checkpatch.pl (spaces are missing after
> ','). This coding style problem was there before your patch but I don't
> think it makes sense to preserve it.

[snip]

> WARNING: please, no spaces at the start of a line
> #137: FILE: drivers/staging/sm750fb/sm750.c:833:

[snip]

Hi Vitaly, these style issues have vexed me and I was not sure whether
to make changes or preserve all the obvious errors so as not to blend
the two changes inappropriately, however it does indeed make sense to
fix these on the lines I'm changing, will fix these!

Best,

-- 
Lorenzo Stoakes
https:/ljs.io
