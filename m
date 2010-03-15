From: James Simmons <jsimmons@infradead.org>
Date: Mon, 15 Mar 2010 11:55:45 +0000
Subject: 
Message-Id: <alpine.LFD.2.00.1003151154420.16108@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Sun, 14 Mar 2010 22:53:29 +0100

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> There are two new options inside the CONFIG_FB section which do not
> depend on the CONFIG_FB. This break Kconfig menu layout.
> 
> Fix it and reduce few conditions for sparc frame buffers
> as the FB_SBUS = ((FB = y) && SPARC).
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Acked-by: David S. Miller <davem@davemloft.net>

