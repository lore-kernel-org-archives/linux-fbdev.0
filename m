From: Guido Guenther <agx@sigxcpu.org>
Subject: Re: [PATCH] GeForce 5200 on rivafb
Date: Thu, 23 Dec 2004 21:48:21 +0100
Message-ID: <20041223204819.GA25233@bogon.ms20.nix>
References: <200412072347.23194.lucasvr@gobolinux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ChvL7-0007Am-Ti
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Dec 2004 11:43:05 -0800
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1ChvL7-0002WC-7L
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Dec 2004 11:43:05 -0800
Received: from localhost (localhost.localnet [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id E2D8A2BC3C
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Dec 2004 20:43:00 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
	by localhost (honk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 29906-22 for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 24 Dec 2004 20:42:50 +0100 (CET)
Received: from bogon.sigxcpu.org (unknown [82.113.119.0])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id E05582BC39
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Dec 2004 20:42:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200412072347.23194.lucasvr@gobolinux.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

On Tue, Dec 07, 2004 at 11:47:23PM -0200, Lucas Correia Villa Real wrote:
> diff -X dontdiff-2.6 -Nur 2.6.10-rc3-vanilla/drivers/video/riva/fbdev.c 2.6.10-rc3-lucasvr/drivers/video/riva/fbdev.c
> --- 2.6.10-rc3-vanilla/drivers/video/riva/fbdev.c	2004-12-07 09:58:14.000000000 -0200
> +++ 2.6.10-rc3-lucasvr/drivers/video/riva/fbdev.c	2004-12-07 22:45:52.000000000 -0200
> @@ -192,6 +192,10 @@
>  	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>  	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL,
>  	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_ULTRA,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>  	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200,
>  	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>  	{ 0, } /* terminate list */
> @@ -1876,6 +1880,8 @@
>  		case 0x0300:   /* GeForceFX 5800 */
>  		case 0x0310:   /* GeForceFX 5600 */
>  		case 0x0320:   /* GeForceFX 5200 */
> +		case 0x0321:   /* GeForceFX 5200 Ultra */
> +		case 0x0322:   /* GeForceFX 5200 */
>  		case 0x0330:   /* GeForceFX 5900 */
>  		case 0x0340:   /* GeForceFX 5700 */
>  		     arch =  NV_ARCH_30;
This last hunk is wrong, we do a (pd->device && 0x0ff0) above that, so
the 0x0321 and 0x322 parts are never possible.
 -- Guido


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
