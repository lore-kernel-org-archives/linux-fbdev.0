From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Wed, 11 Mar 2015 09:39:10 +0000
Subject: Re: [PATCH 4/6] staging: sm750fb: Expose hw712_fillrect externally
Message-Id: <CAA5enKb1j1UY4wf2FcDu0m87BXA++of-0+Pm1G96UevvMU0Gfw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
	<1426037325-8392-4-git-send-email-lstoakes@gmail.com>
	<20150311093728.GD4560@sudip-PC>
In-Reply-To: <20150311093728.GD4560@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On 11 March 2015 at 09:37, Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:
> in your previous patch 3/6 you made it static now you are again
> removing the static keyword. may i ask why you changed it in 3/6 if you
> again change it back to original in this patch?

There's no good reason, it's just a mistake :) I'll fix it shortly.

> anyways, like Dan said, delete this function, its not used anywhere.
> it will not be used also, i missed removing this function from the
> vendor crude drver.

Will do!

Best,
-- 
Lorenzo Stoakes
https:/ljs.io
