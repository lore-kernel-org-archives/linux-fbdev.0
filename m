From: Jonathan Corbet <corbet@lwn.net>
Date: Sat, 01 May 2010 22:57:59 +0000
Subject: Re: [RFC] Second OLPC Viafb series, v2
Message-Id: <20100501165759.720dfade@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272493051-25380-1-git-send-email-corbet@lwn.net>
	<4BDC9D17.9080000@gmx.de>
In-Reply-To: <4BDC9D17.9080000@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

On Sat, 01 May 2010 23:28:55 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> The only information I can supply so far is that it happened already 
> while unregistering the first platform. The registration of it seemed to 
> be successful. I did not yet dig deep enough into the subsystem to find 
> the bug. Any ideas?

Yes, I think I know what's going on.  Platform devices call kfree() on
platform_data at release time.  That's a little aspect of the API that
I had overlooked...  suffice to say, I'd not set platform_data to
something that kfree() was expecting to see.

Best solution, probably, is to just set it to NULL prior to
unregistering the device.  Will do something along those lines shortly.

Thanks,

jon
