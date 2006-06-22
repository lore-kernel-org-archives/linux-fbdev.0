From: Torgeir Veimo <torgeir@pobox.com>
Subject: Re: [PATCH 1/1] New Framebuffer for Intel based
 Macs [try #2] (fwd)
Date: Thu, 22 Jun 2006 09:52:51 +0100
Message-ID: <449A5A63.1080205@pobox.com>
References: <Pine.LNX.4.62.0606221038280.23155@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtKvs-0000Ph-8r for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 01:53:00 -0700
Received: from rune.pobox.com ([208.210.124.79])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FtKvr-00059d-0e
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 01:53:00 -0700
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id A750478A7E
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 22 Jun 2006 04:53:16 -0400 (EDT)
Received: from [10.0.1.1] (82-35-248-75.cable.ubr06.dals.blueyonder.co.uk
	[82.35.248.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 779227871D
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 22 Jun 2006 04:53:16 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.62.0606221038280.23155@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Geert Uytterhoeven wrote:
> ---------- Forwarded message ----------
> Date: Wed, 21 Jun 2006 14:40:24 +0200
> From: Edgar Hucek <hostmaster@ed-soft.at>
> To: LKML <linux-kernel@vger.kernel.org>
> Subject: [PATCH 1/1] New Framebuffer for Intel based Macs [try #2]
>
> This patch add a new framebuffer driver for the Intel Based macs.
> This framebuffer is needed when booting from EFI to get something
> out the box  ;)
>
> +typedef enum _MAC_TYPE {
> +	M_I17,
> +	M_I20,
> +	M_MINI,
> +	M_MACBOOK,
> +	M_NEW
> +} MAC_TYPE;
>   
This doesn't support the macbook pro?

-- 
-Torgeir


All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
