From: David Miller <davem@davemloft.net>
Date: Tue, 03 Jan 2017 15:56:42 +0000
Subject: Re: [PATCH] uapi: use wildcards to list files
Message-Id: <20170103.105642.1067305724615533420.davem@davemloft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161203.192346.1198940437155108508.davem@davemloft.net>
 <1483454144-10519-1-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1483454144-10519-1-git-send-email-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nicolas.dichtel@6wind.com
Cc: linux-arch@vger.kernel.org, linux-nfs@vger.kernel.org, arnd@arndb.de, alsa-devel@alsa-project.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org, linux-raid@vger.kernel.org, airlied@linux.ie, netfilter-devel@vger.kernel.org, linux-fbdev@vger.kernel.org, xen-devel@lists.xenproject.org, fcoe-devel@open-fcoe.org, linux-mtd@lists.infradead.org, linux-media@vger.kernel.org

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Tue,  3 Jan 2017 15:35:44 +0100

> Regularly, when a new header is created in include/uapi/, the developer
> forgets to add it in the corresponding Kbuild file. This error is usually
> detected after the release is out.
> 
> In fact, all headers under include/uapi/ should be exported, so let's
> use wildcards.
> 
> After this patch, the following files, which were not exported, are now
> exported:
 ...
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Acked-by: David S. Miller <davem@davemloft.net>
