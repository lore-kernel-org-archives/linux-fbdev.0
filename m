From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2 v2] Add DIU platform code for
	MPC8610HPCD
Date: Thu, 20 Mar 2008 15:33:04 -0700
Message-ID: <20080320153304.cdc1817d.akpm@linux-foundation.org>
References: <12059526271941-git-send-email-yorksun@freescale.com>
	<12059526274026-git-send-email-yorksun@freescale.com>
	<12059526271964-git-send-email-yorksun@freescale.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JcTKU-0005q7-EY for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 20 Mar 2008 15:33:46 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JcTKU-0005tw-6V
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 20 Mar 2008 15:33:46 -0700
In-Reply-To: <12059526271964-git-send-email-yorksun@freescale.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, galak@kernel.crashing.org, linuxppc-dev@ozlabs.org, Andy Whitcroft <apw@shadowen.org>, yorksun@freescale.com

On Wed, 19 Mar 2008 13:50:27 -0500
York Sun <yorksun@freescale.com> wrote:

> Add platform code to support Freescale DIU. The platform code includes
> framebuffer memory allocation, pixel format, monitor port, etc.
>
> ...
>
> +unsigned int mpc8610hpcd_get_pixel_format
> +	(unsigned int bits_per_pixel, int monitor_port)

Again, please do

unsigned int mpc8610hpcd_get_pixel_format(unsigned int bits_per_pixel,
					int monitor_port)

(and anywhere else where this was done)

> +int __init preallocate_diu_videomemory(void);

Nope, please don't put extern declarations in .c files.  Find a suitable
header for it - one which is included by the defining file and by all users
of the symbol.

Andy, checkpatch missed this.

>  }
>  #endif
> +


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
