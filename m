From: Richard Smith <rsmith@bitworks.com>
Subject: Telling libSDL that my fbdev can do acclerated fills
Date: Tue, 29 Jun 2004 22:56:40 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40E239F8.7070909@bitworks.com>
References: <200406301047.57423.adaplas@hotpop.com> <1088564019.1922.12.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfWDJ-0004eJ-6a
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 20:56:49 -0700
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BfWDI-0000PY-Pp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 20:56:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by bitworks.com (Postfix) with ESMTP id 75729861C8
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Jun 2004 22:56:40 -0500 (CDT)
Received: from bitworks.com ([127.0.0.1])
	by localhost (fileserver [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31324-08 for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 29 Jun 2004 22:56:37 -0500 (CDT)
Received: from [192.168.1.22] (richard.internal [192.168.1.22])
	by bitworks.com (Postfix) with ESMTP id 985BB85B93
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Jun 2004 22:56:37 -0500 (CDT)
In-Reply-To: <1088564019.1922.12.camel@gaston>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

I'm working on a app that runs on the STPC Atlas and uses libSDL with 
the stpcfb from STPC.  Kernel 2.4.x. I'm currently using 2.4.23 but any 
of later kernels will work.

The Atlas video accelerator supports hardware assisted fills.  I've been 
looking over the stpcfb code and some of the other framebuffer drivers 
and its not obvious to me how the fb system exports out what kind of 
graphics hardware assisted abilities it has.  Or even how you would call 
those abilities if you knew they were avaiable.

All I see is stuff for text related console work.

The STPC is a pretty slow device and my app needs all the speed help it 
can get. libSDL is currently doing software fills since it dosen't know 
otherwise.

I see in the libSDL source code that the FillHWRect funciton pointer for 
the fb driver is set to NULL as if its not possible to realize hardware 
assisted graphics functions via fbdev.

Is this the case or what am I missing?







-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
