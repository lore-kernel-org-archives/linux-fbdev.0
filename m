From: John Zielinski <grim@undead.cc>
Subject: Re: Restoring Screen when coming	back	from	KD_GRAPHICS
Date: Thu, 25 Dec 2003 11:28:36 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FEB1034.10801@undead.cc>
References: <3FC4603C.2000702@undead.cc> <1072254378.739.65.camel@gaston>	 <3FEA0E0D.3030001@undead.cc> <1072306057.15476.19.camel@gaston>	 <3FEA3BEB.2060608@undead.cc> <1072348661.15461.31.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZYM1-0000So-AG
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Dec 2003 08:28:53 -0800
Received: from mail.undead.cc ([216.126.84.18])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AZYM0-0000rr-Sp
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Dec 2003 08:28:53 -0800
In-Reply-To: <1072348661.15461.31.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

Benjamin Herrenschmidt wrote:

>I think we don't need (nor want) to go down that path. And I fail to
>see what state info would matter anyway.
>  
>
>The fbdev's can restore what they need. What I mean is they can restore the
>whole state needed for the mode, the palette and their own accel ops to
>behave properly. That's all they have to care about. If a gfx app need
>more engine state, it's up to this app to save/restore it.
>  
>

Good.  Then I don't have to worry about that then.

John




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
