From: Daniel J Blueman <daniel.blueman@gmail.com>
Date: Sun, 08 May 2011 11:25:18 +0000
Subject: Re: [2.6.39-rc2, framebuffer] use after free oops
Message-Id: <BANLkTiksbbCqnQG6N_xe69bvWSAA8AVAbQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BANLkTi=8U3=E0=j8MJ-r70O_aO8Pxvv9Nw@mail.gmail.com>
	<BANLkTi=F8u7oZM+=W+5vzmvf1b0YiN0fQg@mail.gmail.com>
	<20110420080535.3edd11ac@pluto.restena.lu>
	<20110420105631.70695dfa@lxorguk.ukuu.org.uk>
	<BANLkTikF5YL8tJ_f5510yy1Ywm69rOUK2A@mail.gmail.com>
	<BANLkTi=x76zkTpZxaHUnSUeP+_O0SsK0Zw@mail.gmail.com>
In-Reply-To: <BANLkTi=x76zkTpZxaHUnSUeP+_O0SsK0Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@redhat.com>, Paul Mundt <lethal@linux-sh.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Anca Emanuel <anca.emanuel@gmail.com>

On 7 May 2011 23:24, Anca Emanuel <anca.emanuel@gmail.com> wrote:
> Hi, Daniel J Blueman.
>
> Did you test https://lkml.org/lkml/2011/5/5/208 ? And it works for you ?
> Then please reply with your error and an Tested-by.
>
> And CC: "Dave Airlie" <airlied@redhat.com>

Tested against 2.6.39-rc6. Instrumentation and debug catches the
(silent without debug) use-after-free case, which now doesn't show up
with this patch, so looks good. Probably good sense to get into
-stable too.

Tested-by: Daniel J Blueman <daniel.blueman@gmail.com>

Thanks,
  Daniel
-- 
Daniel J Blueman
