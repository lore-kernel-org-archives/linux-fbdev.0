From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 11734] New: Ramdonly linux
 don't boot,
 it hangs at the very first stage of booting with some error related with
 uvesafb
Date: Fri, 10 Oct 2008 13:50:45 -0700
Message-ID: <20081010135045.8b4772f5.akpm@linux-foundation.org>
References: <bug-11734-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1KoOwm-0003xV-Gj
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Oct 2008 20:50:52 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1KoOwi-00037T-4g
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Oct 2008 20:50:52 +0000
In-Reply-To: <bug-11734-10286@http.bugzilla.kernel.org/>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: diegoocampo8@gmail.com, Michal, Januszewski <spock@gentoo.org>, bugme-daemon@bugzilla.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Fri, 10 Oct 2008 13:37:41 -0700 (PDT)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=11734
> 
>            Summary: Ramdonly linux don't boot, it hangs at the very first
>                     stage of booting with some error related with uvesafb
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.27-6
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Video(Other)
>         AssignedTo: drivers_video-other@kernel-bugs.osdl.org
>         ReportedBy: diegoocampo8@gmail.com
> 
> 
> Latest working kernel version: 2.6.24-xx
> Earliest failing kernel version: ----
> Distribution: Ubuntu Intrepid Ibex
> Hardware Environment: Samsung R70 / A009
> Software Environment: Ubuntu Intrepid Ibex Beta.
> Problem Description: First of all: I am not a linux expert so please don't ask
> me too much technical questions about the problem, but i will try to help as
> much as i can...
> I am not sure if it is related with Ubuntu or with the kernel but the problems
> take place in the very first stage of booting (maybe with the loading of the
> kernel??) and I get the following error messages:
> "606627 uvesafb: failed to execute /sbin/v86d"
> "606719 uvesafb: make sure that the v86d helper is installed and executable"
> "606814 uvesafb: Getting VBE info block failed (eax=0x4f00, err=-2)"
> "606905 uvesafb: vbe_init() failed with -22
> 
> Then the loading goes on a little bit until reaching the message: 
> "Loading hardware drivers ....... " and the laptop freezers at this point.
> 
> Like i said this is a ramdonly problem,if i restart the computer most probably
> ubuntu starts, but i think it is very annoying anyway!.
> 

hm.  firmware loader problems, perhaps?

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
