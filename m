From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9564] New: Uninitialzed
 variable fields cvt.h_margin and cvt.v_margin
Date: Fri, 18 Jan 2008 14:00:55 -0800
Message-ID: <20080118140055.fe862b78.akpm@linux-foundation.org>
References: <bug-9564-10286@http.bugzilla.kernel.org/>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFzGt-0001pb-Ed for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 Jan 2008 14:01:07 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFzGt-00015J-25
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 Jan 2008 14:01:07 -0800
In-Reply-To: <bug-9564-10286@http.bugzilla.kernel.org/>
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
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: marciobuss@gmail.com, bugme-daemon@bugzilla.kernel.org

On Fri, 14 Dec 2007 13:54:59 -0800 (PST)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9564
> 
>            Summary: Uninitialzed variable fields cvt.h_margin and
>                     cvt.v_margin
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.23
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Video(Other)
>         AssignedTo: drivers_video-other@kernel-bugs.osdl.org
>         ReportedBy: marciobuss@gmail.com
> 
> 
> The errors can be found at drivers/video/fbcvt.c as follows:
> 
> (1) the test "if (margin)" at line 310 evaluates to false,
> (2) this makes the test "if (cvt.flags & FB_CVT_FLAG_MARGINS)" at line 352
>     to evaluate to false as well
> (3) now cvt.h_margin is uninitialized at line 359, 368, and 370, and
>     cvt.v_margin is uninitizalied at line 371.
> 
> In other words, both cvt.v_margin and cvt.h_margin are initialized conditinally
> but used unconditionally. This bug is a false positive only if the parameter
> "margins" at line 304 is never 0. However, this would make the test at line
> 310 unnecessary -- anyone looking at the code is miled into believing that
> 0 is a legal value for "margins". This means the code does require some change
> in my humble opinion.
> 

Could someone please take a look at this?

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
