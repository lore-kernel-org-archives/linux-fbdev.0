From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 03 Apr 2019 13:53:49 +0000
Subject: Re: [PATCH v2 7/7] MAINTAINERS: sm712fb: list myself as one maintainer.
Message-Id: <9c99beba-813d-e82a-6ce5-fd1ffec45022@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me>
        <20190322051759.15007-8-tomli@tomli.me>
        <20190331190801.hxl57om56jskku5s@debian>
        <20190401174103.GF15736@localhost.localdomain>
        <CGME20190402211010epcas2p3721fd8da621ee64c2b1a373d41cc89e7@epcas2p3.samsung.com>
        <CADVatmPtQAfSC=UkYWHKUx98JK=PMcSZB29ULeQKTBLD9iPnkw@mail.gmail.com>
In-Reply-To: <CADVatmPtQAfSC=UkYWHKUx98JK=PMcSZB29ULeQKTBLD9iPnkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Tom Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel <linux-kernel@vger.kernel.org>, LFBDEV <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>


On 04/02/2019 11:09 PM, Sudip Mukherjee wrote:
> On Mon, Apr 1, 2019 at 6:41 PM Tom Li <tomli@tomli.me> wrote:
>>
>> On Sun, Mar 31, 2019 at 08:08:01PM +0100, Sudip Mukherjee wrote:
>>> Technically I donot have any problem with this, you seem to know more
>>> about SM712 than I know. But Teddy Wang is also an existing maintainer
>>> and I think there should be an ack from him before this is accepted.
>>
>> Okay, I'll write a personal mail to Teddy. I think it could be a separate
>> patch to allow more time for communication, but the problem is that, if

The first version of the patchset was posted on 2nd February and
Teddy was on Cc:. Unless there is an explicit NACK (with valid
rationale) from him lets assume that he is fine with having another
co-maintainer.

>> the MAINTAINERS and the new changes are not merged at the same time, users
>> who have problems may unable to see my name and E-mail address for reporting
>> problems.
> 
> git will not forget that you have done the changes. :)
> So anyone who has a problem only needs to do a "git blame" to see who
> has done it and the user will get your name and email to contact you.
> If that is the only reason you think your name is added as a

The original patch description suggests that there is more than
that:

"I have working on the sm712fb driver for a while and have some
familiarity with this hardware, I'll be helping working on and
testing problems of this driver, so add myself to the MAINTAINERS
file."

> maintainer then I guess that is not a valid concern and then in that
> case I am not seeing any need to add your name in maintainer.
> 
> Bartlomiej can you advise please.

2D acceleration seems to be an important contribution to the driver
(functionality wise and code wise -> it grows the driver source code
by ~25%) and it shows that Yifeng knows the driver well.

He has also access to SM720 (you have SM712 only) to verify potential
issues with the future driver changes (I assume that he don't mind
getting Cc:ed on all driver related patches, not that there should be
much of them).

Thus I think that it would be beneficial to add him as the driver
co-maintainer but I would prefer to keep the current ordering in
the MAINTAINERS file, IOW something like this:

Index: b/MAINTAINERS
=================================--- a/MAINTAINERS	2019-04-01 13:12:10.607271933 +0200
+++ b/MAINTAINERS	2019-04-03 15:39:54.404646279 +0200
@@ -14143,6 +14143,7 @@ SILICON MOTION SM712 FRAME BUFFER DRIVER
 M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
 M:	Teddy Wang <teddy.wang@siliconmotion.com>
 M:	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
+M:	Yifeng Li <tomli@tomli.me>
 L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/sm712*


Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
