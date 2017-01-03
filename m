From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 03 Jan 2017 21:37:04 +0000
Subject: Re: [PATCH] uapi: use wildcards to list files
Message-Id: <2108827.WpE3IvfEdH@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161203.192346.1198940437155108508.davem@davemloft.net>
 <1483454144-10519-1-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1483454144-10519-1-git-send-email-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org, alsa-devel@alsa-project.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org, linux-raid@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-fbdev@vger.kernel.org, xen-devel@lists.xenproject.org, fcoe-devel@open-fcoe.org, linux-mtd@lists.infradead.org, davem@davemloft.net, linux-media@vger.kernel.org

On Tuesday, January 3, 2017 3:35:44 PM CET Nicolas Dichtel wrote:
> Regularly, when a new header is created in include/uapi/, the developer
> forgets to add it in the corresponding Kbuild file. This error is usually
> detected after the release is out.
> 
> In fact, all headers under include/uapi/ should be exported, so let's
> use wildcards.

I think the idea makes a lot of sense: if a header is in uapi, we should
really export it. However, using a wildcard expression seems a bit
backwards here, I think we should make this implicit and not have the
Kbuild file at all.

The "header-y" syntax was originally added back when the uapi headers
were mixed with the internal headers in the same directory. After
David Howells introduced the separate directory for uapi, it has
become a bit redundant.

Can you try to modify scripts/Makefile.headersinst instead so we
can simply remove the Kbuild files entirely?

	Arnd
