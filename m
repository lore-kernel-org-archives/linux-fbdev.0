From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [VIDEO] vfb: only enable if explicitly
 requested when compiled in
Date: Mon, 2 Jun 2008 18:56:37 +0200
Message-ID: <20080602185637.bb1dedfb.krzysztof.h1@poczta.fm>
References: <200806011454.23123.elendil@planet.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755914AbYFBQyf@vger.kernel.org>
In-Reply-To: <200806011454.23123.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Frans Pop <elendil@planet.nl>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Antonino A. Daplas" <adaplas@gmail.com>

On Sun, 1 Jun 2008 14:54:22 +0200
Frans Pop <elendil@planet.nl> wrote:

> From: Frans Pop <elendil@planet.nl>
> 
> The Kconfig help for the vfb driver says:
>    Do NOT enable it for normal systems! To protect the innocent, it
>    has to be enabled explicitly at boot time using the kernel option
>    `video=vfb:'.
>     
> This change lets the code match the description.
>     
> Support for vfb:disable is kept for backwards compatibility; vfb:off
> works because it is tested at a higher level.
>     
> Signed-off-by: Frans Pop <elendil@planet.nl>
> CC: Antonino A. Daplas <adaplas@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> 
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>


----------------------------------------------------------------------
Podbij Dziki Zachod!Gra strategiczna online
Sprawdz >>> http://link.interia.pl/f1dff
