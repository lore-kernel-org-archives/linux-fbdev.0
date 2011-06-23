From: Anatolij Gustschin <agust@denx.de>
Date: Thu, 23 Jun 2011 11:26:04 +0000
Subject: Re: [PATCH] fsl-diu-fb: remove the ioctl interface
Message-Id: <20110623132604.1a6d0d71@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308691655-3416-1-git-send-email-timur@freescale.com>
	<20110622003853.1041385c@wker>
	<929D3CED81F34E43887A393170D66FB90484A280@GBRSUN01MS002.eu.xerox.net>
In-Reply-To: <929D3CED81F34E43887A393170D66FB90484A280@GBRSUN01MS002.eu.xerox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, lethal@linux-sh.org, Timur Tabi <timur@freescale.com>, yorksun@freescale.com

On Wed, 22 Jun 2011 11:39:49 +0100
"Jenkins, Clive" <Clive.Jenkins@xerox.com> wrote:
...
> > > Removing the ioctl interface also allows us to clean up the header
> file and
> > > remove other unusued stuff.
> > 
> > No! We are using ioctl interface of this driver in many video
> > rendering applications on overlay planes on huge number of boards.
> > So, please don't remove it.
...
> Can you make available your application code by posting a link to it?

I do not have the code of the real applications since I didn't wrote
it. All I can share is the test and sample code that I used when working
on driver fixes:

test-app: http://pastebin.com/J2RvKb6n

HTH,
Anatolij
