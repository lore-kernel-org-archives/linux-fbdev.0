From: Dave Airlie <airlied@linux.ie>
Subject: Re: [PATCH 2.6.17-rc4-mm3] intelfb 945G/GM video fix
Date: Fri, 26 May 2006 00:34:36 +0100 (IST)
Message-ID: <Pine.LNX.4.64.0605260032200.5525@skynet.skynet.ie>
References: <06E28340-802B-4587-9A76-75A59127F7F9@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FjPLp-00034K-K8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 16:34:45 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FjPLp-0008Q6-ME
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 16:34:45 -0700
Received: from holly.csn.ul.ie ([193.1.99.76])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FjPLm-0003DH-2i
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 16:34:45 -0700
In-Reply-To: <06E28340-802B-4587-9A76-75A59127F7F9@cecropia.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Dennis Munsie <dmunsie@cecropia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Eric Hustvedt <ehustvedt@cecropia.com>, Sylvain Meyer <sylvain.meyer@worldonline.fr>


> This is a small patch that I would like others to take a look at.  We ran 
> into an issue where on the motherboard we are using, Intel D945GTP, the video 
> wouldn't come up in the proper state even with Dave Airlie's patches for 945. 
> I had created a 945 patch that I hadn't released, and that one did work.  The 
> only difference between the two was that I had a one line hack to write to 
> the DPLL register twice.  Now, this should be harmless on other chipsets, but 
> I can't be sure without testing.  I've tried asking Intel about this, but I 
> haven't gotten any information on it from them.

This just looks wrong, I've got an 945G at home, I'm just a bit swamped 
with other things, the current intelfbdev code could do with a refresh 
from my X.org driver tree, I just haven't had the time lately to pull over 
the code....

you can see my X.org driver code at:
git pull http://people.freedesktop.org/~airlied/git/xf86-video-i810/.git

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
