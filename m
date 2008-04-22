From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] atyfb: Fix 64 bits resources on
	32 bits archs
Date: Wed, 23 Apr 2008 08:20:06 +1000
Message-ID: <1208902806.9640.136.camel@pasglop>
References: <20080422012726.42775DE2A3@ozlabs.org>
	<480E07BC.3050107@ru.mvista.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JoQqa-00011W-VO for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 15:20:21 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1944VYmPxfdVZUx9USyELJxDZXkKH+qkLw=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JoQqZ-0006uZ-Gr
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 15:20:20 -0700
In-Reply-To: <480E07BC.3050107@ru.mvista.com>
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
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com


On Tue, 2008-04-22 at 19:43 +0400, Sergei Shtylyov wrote:
>     Not sure what that change gives us -- this function mostly treats 'addr' 
> as unsigned long (casting it to char/void *), ot compares it to 'unsigned 
> long' 'base' variable -- which should be made 'resource_size_t' in its turn 
> being assigned resource's start value.  So, this part of patch looks incomplete
> (and yet I'm not sure if SPARC really needs all that)...

I just wanted to make sure both setup functions has the same prototype. 

I think sparc doesn't need fixing in there.

Ben.


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
