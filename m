From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 18 Nov 2011 02:14:16 +0000
Subject: Re: Recent viafb changes break OLPC DCON freeze
Message-Id: <4EC5BF78.80002@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMLZHHQHZL9zZMsQgvXBi6MoG9_TXWqPN5D19sqeKSjsoV3unA@mail.gmail.com>
In-Reply-To: <CAMLZHHQHZL9zZMsQgvXBi6MoG9_TXWqPN5D19sqeKSjsoV3unA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Daniel,

thanks a lot for your debugging. I'm busy at the moment so I'll keep it short.

On 11/17/2011 04:24 PM, Daniel Drake wrote:
> A further data point on this issue: we once hit exactly the same thing
> on XO-1 (geode lxfb). A non-OLPC commit caused the v/h sync output
> polarity to change. The display still worked correctly, but the DCON
> freeze functionality caused garbage in exactly the same way as this
> viafb issue. This suggests that the display itself isn't too fussy
> about video signal parameters, but the DCON controller is picky and
> expects certain parameters. (see commit ad913da61aeb for the lxfb
> fix).

As you mentioned it, I had a look at this driver. It looks like viafb does it
(polarity) just the other way around than geode. So it might be wort a try to
change in

drivers/video/via/share.h:
/* 1200x900@60 Sync Polarity (DCON) */
#define M1200X900_R60_HSP       NEGATIVE
#define M1200X900_R60_VSP       NEGATIVE

to

/* 1200x900@60 Sync Polarity (DCON) */
#define M1200X900_R60_HSP       POSITIVE
#define M1200X900_R60_VSP       POSITIVE

> Any thoughts?

If the above works it's just that the thing was initially entered wrong and now
we hit it as we start setting the polarity for the correct devices, similar to
the issue with the refresh rate.
If it does not work I'll have a deeper look at it as soon as possible.


Best regards,

Florian Tobias Schandinat
