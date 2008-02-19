From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10043] New: Video support
	for SiS 662/671
Date: Tue, 19 Feb 2008 15:40:18 -0800
Message-ID: <20080219154018.cdc01e05.akpm@linux-foundation.org>
References: <bug-10043-10286@http.bugzilla.kernel.org/>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JRc65-0005zB-UZ for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Feb 2008 15:42:02 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JRc64-0007Qb-Vl
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Feb 2008 15:42:01 -0800
In-Reply-To: <bug-10043-10286@http.bugzilla.kernel.org/>
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
To: axelgenus@gmail.com
Cc: Thomas Winischhofer <thomas@winischhofer.net>, linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org

On Tue, 19 Feb 2008 10:14:10 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10043
> 
>            Summary: Video support for SiS 662/671
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.23
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Video(AGP)
>         AssignedTo: airlied@linux.ie
>         ReportedBy: axelgenus@gmail.com
> 
> 
> Hardware Environment: Intel D201GLY / D201GLY2 Motherboards
> 
> Problem Description:
> These two motherboards have SiS 662/671 chipsets with integrated video
> adapters. Those adapters are not recognized correctly by the kernel.
> 
> 

Could be we just don't have the PCI IDs in there.  Could you please send
(via emailed reply-to-all) the output of `lspci -vx'?

Thanks.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
