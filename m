From: Paride Legovini <legovini@spiro.fisica.unipd.it>
Subject: Re: intelfb not working on a 945GM
Date: Sat, 20 Oct 2007 17:53:10 +0200
Message-ID: <471A2466.1020907@spiro.fisica.unipd.it>
References: <47174F1A.4050307@spiro.fisica.unipd.it>
	<200710181853.07410.jbarnes@virtuousgeek.org>
	<47189307.7030403@spiro.fisica.unipd.it>
	<200710191409.28522.jbarnes@virtuousgeek.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IjGdm-00037a-Kp for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 20 Oct 2007 08:53:30 -0700
Received: from mail231.csoft.net ([205.205.221.4] ident=_postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IjGdm-0004s5-8N
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 20 Oct 2007 08:53:30 -0700
Received: from [192.168.0.3] (ip-193-109.sn2.eutelia.it [83.211.193.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail231.csoft.net (Postfix) with ESMTP id 088E847289
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 20 Oct 2007 11:53:17 -0400 (EDT)
In-Reply-To: <200710191409.28522.jbarnes@virtuousgeek.org>
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

Jesse Barnes wrote:
> On Friday, October 19, 2007 4:20 am Paride Legovini wrote:
>> Jesse Barnes wrote:
>>> The intelfb driver doesn't support much in the way of modesetting,
>>> and in fact it can be problematic if you try to use it, X and the
>>> DRM at the same time, so I'd recommend avoiding it unless you have
>>> specific embedded requirements or something...
>> But the problem I described come out during the very first stages of
>> the boot, before drm or the X driver are loaded (and, moreover, I
>> don't start X at boot, I use startx, and then X loads the modules it
>> needs). So this doesn't seem to be the answer...
> 
> intelfb doesn't support LVDS afaik, so unless you specifically pass it a 
> mode to set your display won't work at all with it.
> 
[...]
> 
> Though again, if you have specific embedded requirements (e.g. using fb 
> applications directly in some specific environment) it might be fine 
> for you.  But even then, you may prefer something like what we have in 
> the DRM modesetting-101 tree, since it can also give you 3D 
> acceleration.

I have no embedded requirements, I just don't always need X, and I like
the framebuffer console in general. Thank you for the modesetting-101
hint, maybe I'll give it a try (I didn't ever know of its existence).

Oh, sorry for writing to you directly and not to the list, I'm too used
to lists where the Reply-To: header is set to the list's address.

p.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
