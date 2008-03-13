From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH] atmel_lcdfb: adjust fifo size for
 at91sam9rl
Date: Thu, 13 Mar 2008 21:59:51 +0100
Message-ID: <20080313215951.3375a453@siona.local>
References: <47D5639A.3090609@atmel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JZuWb-0001Lw-Vr for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Mar 2008 13:59:42 -0700
Received: from smtpeu1.atmel.com ([195.65.72.27] helo=bagnes.atmel.com)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1JZuWa-0007mv-Ek
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Mar 2008 13:59:41 -0700
In-Reply-To: <47D5639A.3090609@atmel.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: nicolas.ferre@atmel.com
Cc: linux-fbdev-devel@lists.sourceforge.net, Patrice VILCHEZ <patrice.vilchez@atmel.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, ARM Linux Mailing List <linux-arm-kernel@lists.arm.linux.org.uk>, Sedji GAOUAOU <sedji.gaouaou@atmel.com>, Andrew Victor <linux@maxim.org.za>

On Mon, 10 Mar 2008 17:36:42 +0100
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> -#if defined(CONFIG_ARCH_AT91SAM9263)
> +#if defined(CONFIG_ARCH_AT91SAM9263) || defined(CONFIG_ARCH_AT91SAM9RL)
>  #define ATMEL_LCDC_FIFO_SIZE		2048
>  #else
>  #define ATMEL_LCDC_FIFO_SIZE		512

Hmm. Perhaps it's time to consider moving this parameter to
platform_data?

Haavard

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
