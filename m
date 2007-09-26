From: Torgeir Veimo <torgeir@pobox.com>
Subject: Re: Plans for 2D acceleration
Date: Wed, 26 Sep 2007 12:45:27 +0100
Message-ID: <1190807127.27064.2.camel@tveimo-laptop>
References: <46FA4579.6040905@freemail.gr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IaVKh-00030G-AL for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 04:45:35 -0700
Received: from rune.pobox.com ([208.210.124.79])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IaVKf-0005Bp-Sr
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 04:45:35 -0700
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 62E7813C4EE
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 26 Sep 2007 07:45:51 -0400 (EDT)
Received: from [10.41.51.150] (unknown [195.75.219.141])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1205513A99F
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 26 Sep 2007 07:45:50 -0400 (EDT)
In-Reply-To: <46FA4579.6040905@freemail.gr>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Wed, 2007-09-26 at 04:41 -0700, Jerald Fitzjerald wrote:
> 
> 
> Are there any plans to expose simple 2D acceleration to userland?
> I'm talking about the very basic operations:
> 
> - fill rectangle (graphics memset)
> - blit (graphics memcpy)
> 
> and possibly
> 
> - copyarea (graphics memmove)
> - waitretrace
> 
> Is there a reason we _don't_ want these exposed to userland or
> just nobody has taken the time to do it? 

You can do all of these using DirectFB. Is that not an option for you?

-- 
-Tor


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
