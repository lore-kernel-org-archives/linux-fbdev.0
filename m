From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] video: SuperH Mobile LCDC Driver V2
Date: Fri, 30 May 2008 18:28:03 +0200
Message-ID: <20080530182803.5d599d21.krzysztof.h1@poczta.fm>
References: <20080530110239.21680.46731.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080530110239.21680.46731.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, iwamatsu@nigauri.org, linux-sh@vger.kernel.org, mano@roarinelk.homelinux.net, lethal@linux-sh.org, akpm@linux-foundation.org

On Fri, 30 May 2008 20:02:39 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

> This is the SuperH Mobile LCDC frame buffer driver V2, adding
> support for the LCDC block found in SuperH Mobile processors. The
> hardware supports up to two LCD panels per LCDC block, and both RGB
> and SYS interfaces can be used to hook up LCD panels/modules.
> 
> The device driver is a regular platform driver, so LCD configuration
> and board specific hooks are passed to the driver using platform data.
> LCD modules using SYS interface often require special configuration
> using the SYS bus, and to solve this cleanly the driver provides SYS
> interface operations to the board code.
> 
> Tested on sh7723 and sh7722 processors with a SYS16A QVGA panel and
> WVGA panels using RGB16 and RGB18 interfaces.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---

Acked-by: Krzysztof Helt<krzysztof.h1@wp.pl>

Does anybody know which tag is better for a reviewed patch:
"Acked-by" or "Reviewed-by" ?

Regards,
Krzysztof


----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>> http://link.interia.pl/f1e13  

