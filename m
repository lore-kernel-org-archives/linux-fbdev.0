From: Olaf Hering <olh@suse.de>
Subject: Re: wrong cursor position with nvidiafb
Date: Sun, 22 Jan 2006 16:38:38 +0100
Message-ID: <20060122153838.GA15532@suse.de>
References: <20060122152246.GA15053@suse.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F0hIg-0002Zu-Ms
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 22 Jan 2006 07:38:42 -0800
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1F0hIf-00082L-9m
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 22 Jan 2006 07:38:42 -0800
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id CFE8EE8A4
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 22 Jan 2006 16:38:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20060122152246.GA15053@suse.de>
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

 On Sun, Jan 22, Olaf Hering wrote:

> The cursor on my G5 is incorrectly placed at line 39, while input appears
> correctly at the  at the bottom of the screen.
> (Line after 'Starting kernel based NFS server' is corrupted)
> If the screen goes blank and I hit a key, it is placed correctly and
> everything is restored correctly.

Its the rckbd start script. When it runs, the cursor position will be
wrong.


-- 
short story of a lazy sysadmin:
 alias appserv=wotan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
