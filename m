From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: Re: Multiple simultaneous FB output.
Date: Wed, 25 Aug 2004 13:42:07 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408251342.07943.lucasvr@gobolinux.org>
References: <200408232328.33371.niteowl@altern.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C00oL-0005DJ-Fz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Aug 2004 09:39:45 -0700
Received: from itapoa.terra.com.br ([200.154.55.227])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C00oI-000229-RA
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Aug 2004 09:39:45 -0700
Received: from pasto.terra.com.br (pasto.terra.com.br [200.154.55.137])
	by itapoa.terra.com.br (Postfix) with ESMTP id BB575DD4B9F
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 25 Aug 2004 13:39:38 -0300 (BRT)
Received: from ummagumma.ozzmosis.net (200-203-050-191.nhoce7002.dsl.brasiltelecom.net.br [200.203.50.191])
	(authenticated user lucasvr)
	by pasto.terra.com.br (Postfix) with ESMTP id 8032A794084
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 25 Aug 2004 13:39:38 -0300 (BRT)
In-Reply-To: <200408232328.33371.niteowl@altern.org>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I guess you can try to 'export FRAMEBUFFER=/dev/fb1' and launch your 
application from an X-terminal (which should be probably using your /dev/fb0 
interface).

I'm not sure about console focus, but since they are different drivers I don't 
think there will be problems regarding console focus.

Lucas


On Monday 23 August 2004 18:28, niteowl@altern.org wrote:
> Hi all!
> Is it possible to use multiple graphic cards (i.e. a AGP G200 and a pair of
> PCI Milennium II) and to visualize multiple fremebuffers *simultaneously*?
>
> All I want to do is to use a text console or X on the G200 (/dev/fb0) and
> to visualize some application's output on /dev/fb1 and /dev/fb2 without
> having to switch console and, above all, avoiding the system to blank
> consoles without focus.
>
> Thanks.
>
> --Niteowl
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
