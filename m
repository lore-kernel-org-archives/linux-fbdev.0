From: Tom Li <tomli@tomli.me>
Date: Mon, 01 Apr 2019 17:41:04 +0000
Subject: Re: [PATCH v2 7/7] MAINTAINERS: sm712fb: list myself as one maintainer.
Message-Id: <20190401174103.GF15736@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-8-tomli@tomli.me>
 <20190331190801.hxl57om56jskku5s@debian>
In-Reply-To: <20190331190801.hxl57om56jskku5s@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Sun, Mar 31, 2019 at 08:08:01PM +0100, Sudip Mukherjee wrote:
> Technically I donot have any problem with this, you seem to know more
> about SM712 than I know. But Teddy Wang is also an existing maintainer
> and I think there should be an ack from him before this is accepted.

Okay, I'll write a personal mail to Teddy. I think it could be a separate
patch to allow more time for communication, but the problem is that, if
the MAINTAINERS and the new changes are not merged at the same time, users
who have problems may unable to see my name and E-mail address for reporting
problems.

I think I can send PATCH v3 early for your review, meanwhile I can write
a personal E-mail to Teddy.

> On Fri, Mar 22, 2019 at 01:17:59PM +0800, Yifeng Li wrote:
> >  SILICON MOTION SM712 FRAME BUFFER DRIVER
> > +M:	Tom Li <tomli@tomli.me>
> 
> Sorry, I am confused. Is your name "Tom Li"? Then why is your
> Signed-off-by: and From: name different?

Sorry for the confusion.

"Tom Li" is my common name. I use this name both in offline and online
activities, and I've used it to contribute various patches to free and
open source projects and mailing list discussions as well. But the
"Signed-off-by" name is the legal name. Linux Kernel's "Developer's
Certificate of Origin" requires the use of legal name in sign-offs.

I think I should write my name as `Yifeng "Tom" Li` in MAINTAINERS to
avoid the confusion.

Thanks for your code review, I've noted your suggestions and I'll
send PATCH v3 soon.

Thanks,
Tom Li
