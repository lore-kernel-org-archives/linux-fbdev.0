From: Otto Wyss <otto.wyss@orpatec.ch>
Subject: Re: Re: [PATCH 4/5][RFC] fbdev: Clean up framebuffer 
 initialization
Date: Sat, 04 Sep 2004 09:46:24 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <413972D0.EAC13CC4@orpatec.ch>
References: <200409041108.40276.adaplas@hotpop.com> <41393829.6020302@winischhofer.net> <200409041453.01644.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3VFt-0008VW-78
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Sep 2004 00:46:37 -0700
Received: from mail.xor.ch ([212.55.210.163])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C3VFr-0003A0-Ck
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Sep 2004 00:46:37 -0700
Received: from orpatec.ch (217.162.130.125)
          by mail.xor.ch with MERCUR Mailserver (v4.03.03 NjYtMjMxMS00NjIy)
          for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 4 Sep 2004 09:51:34 +0200
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

"Antonino A. Daplas" wrote:
> 
> Mainly cleanup, but also point #5.  The i810fb, for instance, depends on agpgart, but
> agpgart gets initialized way after fbdev.  The workaround is for i810fb to explicitly
> call intel_agp_init().  Besides the ugliness, forcibly initializing the agpgart subsystem
> out of sequence may cause problems.
> 
Sorry if I interrupt without deeper knowledge but doesn't this sound
very strange? Why is a subsystem initialized much later than the one
which depends on it? Doesn't this look like a design error?

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
