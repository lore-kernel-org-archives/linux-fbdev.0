From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 02 Apr 2019 20:53:36 +0000
Subject: Re: [PATCH v2 3/7] fbdev: sm712fb: support 2D acceleration on SM712 w/ Little-Endian CPU.
Message-Id: <CADVatmO0_1mn7oQaLrQLXZ8re2R6uus9vPdXj4qZPi2CovS44g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me> <20190322051759.15007-4-tomli@tomli.me>
 <20190331180947.s44eznujdeucnl7f@debian> <20190401162618.GB15736@localhost.localdomain>
In-Reply-To: <20190401162618.GB15736@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, LFBDEV <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>

On Mon, Apr 1, 2019 at 5:26 PM Tom Li <tomli@tomli.me> wrote:
>
> On Sun, Mar 31, 2019 at 07:09:47PM +0100, Sudip Mukherjee wrote:
> > On Fri, Mar 22, 2019 at 01:17:55PM +0800, Yifeng Li wrote:
> > I didnot notice any performace improvement in my system. Infact, I have
> > never seen the performance problem that you mentioned. But, it will be
> > good to have the 2D feature back again.
>
<snip>
> But again, the 2D code is only used by Linux VT code internally, if you are
> not using VT console, the behavior cannot be tested properly. Are you testing
> it under the Linux tty console? And does your dmesg log says, "2D acceleration
> is enabled"?
>
> Running the "fbtest" testsuit is also a good way to "smoke-test" the fbdev
> code.

Yes, I do run fbtest as part of my testing.


-- 
Regards
Sudip
