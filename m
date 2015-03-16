From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Mon, 16 Mar 2015 19:03:12 +0000
Subject: Re: [PATCH] staging/sm75fb: Declare static functions as such
Message-Id: <CAA5enKbVYqaFx77T94r3t-gEF2+Y6auQheR_a6Tn45BNzt2Aqw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426503069-27901-1-git-send-email-ricardo.ribalda@gmail.com>
In-Reply-To: <1426503069-27901-1-git-send-email-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On 16 March 2015 at 10:51, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> This patch fixes this sparse warning

Hi Ricardo,

I currently have a patch series awaiting the final ok which includes
fixes for these warnings
(http://lkml.iu.edu/hypermail/linux/kernel/1503.1/02535.html),
apologies but assuming there isn't something hideously wrong with my
series I suspect they supersedes this patch :(

It's really easy to accidentally submit a patch that has already been
covered elsewhere; I, as a rather new kernel contributor, always find
I have to search quite a bit to be *sure* that it's not been covered
already.

Additionally, your subject line is 'staging/sm75fb: Declare static
functions as such' which ought to be 'staging: sm750fb: Declare static
functions as such' - there's a typo in the device name and I think the
convention is always to use colons in subject lines.

Best,

-- 
Lorenzo Stoakes
https:/ljs.io
