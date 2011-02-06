From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 06 Feb 2011 23:45:20 +0000
Subject: Re: [PATCH 1/2] video, sm501: add OF binding to support SM501
Message-Id: <1297035920.14982.16.camel@pasglop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
In-Reply-To: <1291451028-22532-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiko Schocher <hs@denx.de>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org, linuxppc-dev@lists.ozlabs.org

On Sat, 2010-12-04 at 09:23 +0100, Heiko Schocher wrote:
> - add binding to OF, compatible name "smi,sm501"
> 
> - add read/write functions for using this driver
>   also on powerpc plattforms

 .../...

Who plans to merge that patch series ? I'm happy for whoever is doing
that to take the powerpc patch at the end (that adds the entry to
the .dts file) with my

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.


