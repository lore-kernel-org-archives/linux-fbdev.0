From: Juston Li <juston.h.li@gmail.com>
Date: Fri, 26 Jun 2015 05:53:33 +0000
Subject: Re: [PATCH v3 11/19] staging: sm750fb: consistent spacing around operators
Message-Id: <CAFow2F9y-ux5_hoQmG-WNHCzA3aw0EB9wxJ57+zOWnYt6ds-JA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
	<1435163120-3253-11-git-send-email-juston.h.li@gmail.com>
	<20150625115618.GC13366@sudip-PC>
	<CAFow2F9=DhqioyV=tha=KBiTi0pz=Ee+NJJL2up41jUUcF66xg@mail.gmail.com>
	<20150626040543.GB3050@sudip-PC>
	<CAFow2F-Cj25rv3-5Y0ck29On=WVQVakeo5-7s_dWmnd=rj+hig@mail.gmail.com>
In-Reply-To: <CAFow2F-Cj25rv3-5Y0ck29On=WVQVakeo5-7s_dWmnd=rj+hig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Jun 25, 2015 at 9:05 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> Usually I use the checkpatch which is in linux-next. That will be the
> latest version. If you compare, last commit on checkpatch of staging
> tree was on April 16th, where as last commit in linux-next is on
> June 19th. And if you use this checkpatch you will see these warnings
> also. :)

Just wanted to clarify. So even with the linux-next checkpatch.pl, no
errors/warnings show for me. Only when I run checkpatch.pl with the
'--strict' option does it give the following checks for various operators:
CHECK: space preferred before that '|' (ctx:VxE)

Are these the warnings you are referring too? Do you want me to fix all
of these for this patch?

Regards
Juston
