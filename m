From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: intelfb stack usage
Date: Sat, 18 Dec 2004 08:14:28 +0800
Message-ID: <200412180814.30855.adaplas@hotpop.com>
References: <41C330B6.8040504@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CfSOY-0002H4-B6
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Dec 2004 16:24:26 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CfSOX-0001LB-MN
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Dec 2004 16:24:26 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 633C712B511B
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 18 Dec 2004 00:24:03 +0000 (UTC)
In-Reply-To: <41C330B6.8040504@osdl.org>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Sylvain Meyer <sylvain.meyer@worldonline.fr>

On Saturday 18 December 2004 03:17, Randy.Dunlap wrote:
> In 2.6.10-rc3-bk6, intelfb_set_par() has the distinction of being
> the largest stack user as determined by 'make checkstack':
>
> objdump -d vmlinux $(find . -name '*.ko') | \
> perl /mnt/src/linux-2610-rc3-bk6/scripts/checkstack.pl i386
> 0x00001317 intelfb_set_par:				2404
>
> because it has this large struct on the stack:
> 	struct intelfb_hwstate hw;
> (almost 2400 bytes)
>
> Any suggestions for how to alleviate this large stack usage?
>
>  From a quick look, this is called from fb_ioctl() to fb_set_var()
> to fb_set_par().
> fb_ioctl() does acquire_console_sem(), so using kmalloc()
> here would need to use GFP_ATOMIC...
> I can do that if it's desired & acceptable.

Using kmalloc() should be acceptable.  I'll CC the author.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
