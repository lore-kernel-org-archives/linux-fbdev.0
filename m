From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 24 Jun 2010 20:17:21 +0000
Subject: Re: [PATCH] fbdev: section cleanup in viafb driver
Message-Id: <20100624141721.7fb644d7@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1276768884-19958-1-git-send-email-henne@nachtwindheim.de>
In-Reply-To: <1276768884-19958-1-git-send-email-henne@nachtwindheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Kretzschmar <henne@nachtwindheim.de>
Cc: JosephChan@via.com.tw, ScottFang@viatech.com.cn, FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 17 Jun 2010 12:01:24 +0200
Henrik Kretzschmar <henne@nachtwindheim.de> wrote:

> This patch moves two functions from .devexit to .text,
> which are called on the probe error path.
> Also a function which is called by probe is moved
> from .text to .devinit.

Sorry, it took me a while to take a look at this.  The changes make
sense, thanks.  I have a few viafb bits and pieces, will collect them
into my tree shortly.

Thanks,

jon
