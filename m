From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 03 Nov 2016 03:53:50 +0000
Subject: Re: [PATCH] Fix loading of module radeonfb on PowerMac
Message-Id: <1478145230.6502.3.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1475928540-19647-1-git-send-email-malat@debian.org>
 <fbf3b5a3-efd9-0f85-c4fe-ae34ae1862b7@ti.com>
 <CA+7wUsy9AW6BvNd=Bmmwra-YfTMAqFwLMg7Z7ZNXpxORq9qtTg@mail.gmail.com>
In-Reply-To: <CA+7wUsy9AW6BvNd=Bmmwra-YfTMAqFwLMg7Z7ZNXpxORq9qtTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Malaterre <malat@debian.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Wed, 2016-11-02 at 11:28 +0100, Mathieu Malaterre wrote:
> 
> This has been working great so far for `radeon.ko`, so I assumed I
> could shamelessly copy the behavior over to `radeonfb.ko`.
> 
> The original reference I found was from Benjamin Herrenschmidt here:
> https://lists.freedesktop.org/archives/dri-devel/2010-August/002907.h
> tml
> 
> I am of course willing to try something else, but I would need some
> guidance.

I missed your original patch but yes, the basic idea is that we kick
out offb when the "real" driver loads.

Cheers,
Ben.

