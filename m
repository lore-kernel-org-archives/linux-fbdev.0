From: James Simmons <jsimmons@infradead.org>
Date: Wed, 07 Sep 2011 15:40:23 +0000
Subject: Re: [RFC] fbdev: remove display subsystem
Message-Id: <alpine.LFD.2.00.1109071637220.29700@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1315013768-3235-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1315013768-3235-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>


> This four year old subsystem does not have a single in-tree user
> not even in staging and as far as I know also none out-of-tree.
> I think that justifies removing it which cleans the config up.

The idea was to provide a frame work for text lcd panels, like for example 
the CrystalFontz. Yes no one was interested so I guess having people write 
there own console driver will do.

> Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: James Simmons <jsimmons@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Ack-By: James Simmons <jsimmons@infradead.org>

