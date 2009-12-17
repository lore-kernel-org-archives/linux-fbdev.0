From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Thu, 17 Dec 2009 22:00:16 +0000
Subject: Re: [PATCH] Revert "fbdev: atafb - add palette register check"
Message-Id: <20091217230016.86c305f8.krzysztof.h1@wp.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.00.0912171413560.17197@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.00.0912171413560.17197@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 17 Dec 2009 14:15:09 +0100 (CET)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> This reverts commit 8546e3ce6e37c359979b69862442f94e0ef0e03b, as it's a
> partial duplicate of commit 2f390380ca69e1617cdddb12d8da94f0a9f4319d ("fbdev:
> add palette register check to several drivers").
> The former went in first through the m68k tree, the latter through Andrew
> Morton.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
