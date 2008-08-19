From: "Jorge Marques Pelizzoni" <jpeliz@icmc.usp.br>
Subject: newbie: fb specs and indirect VRAM access
Date: Tue, 19 Aug 2008 17:31:34 -0300 (BRT)
Message-ID: <47858.200.178.190.130.1219177894.squirrel@mail2.icmc.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVXs7-0003bd-8m for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 13:32:07 -0700
Received: from mail.icmc.usp.br ([143.107.231.3] helo=mail2.icmc.usp.br)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVXs4-0006r6-Pc
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 13:32:07 -0700
Received: from mail2.icmc.usp.br (mail2 [143.107.231.3])
	by mail2.icmc.usp.br (Postfix) with ESMTP id AC6B35136
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 19 Aug 2008 17:31:34 -0300 (BRT)
References: 
In-Reply-To: 
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

Hi, all!

I am considering implementing a frame buffer device for a mobile platform
(LPC2400 on uCLinux) that, as far as I can tell, seems to lack one. Well,
I am a newbie to all things frame buffer-related (though familiar with
kernel/device module implementation) and would most appreciate it if you
could answer the following questions:

1 - are there documents specifying frame buffer devices and how
applications are expected to handle them (in short, their API)?

2 - my CPU cannot address "real" VRAM directly, all control being carried
out by means of a parallel interface. I gathered that an fb user is
expected to write to (virtual) VRAM directly via a pointer provided by the
driver and never notifies the driver of changes. Have you seen such a
set-up before and do you think these requirements can be reconciled? The
only way round this I can currently see is making the driver periodically
check the virtual VRAM for changes and transmit only changed parts. All in
all, a costly operation, as everything must be carried out by the same
CPU. Could whatever is used to implement mmap be called into play (without
whatever is used to implement msync)?

Thank you very much in advance.

Cheers,

Jorge M. Pelizzoni.





-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
