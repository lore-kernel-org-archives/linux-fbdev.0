From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9155] New: No fan control
 with ATI Radeon display support on HP nx6125.
Date: Sat, 13 Oct 2007 10:53:15 -0700
Message-ID: <20071013105315.accef6aa.akpm__47713.3903689266$1192299600$gmane$org@linux-foundation.org>
References: <bug-9155-10286@http.bugzilla.kernel.org/>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IglB6-0002Hn-LW for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 13 Oct 2007 10:53:32 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IglB6-0001r2-BL
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 13 Oct 2007 10:53:32 -0700
In-Reply-To: <bug-9155-10286@http.bugzilla.kernel.org/>
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
To: linux-acpi@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: daniel.wuerfel@gmx.net, bugme-daemon@bugzilla.kernel.org

On Sat, 13 Oct 2007 02:37:35 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9155
> 
>            Summary: No fan control with ATI Radeon display support on HP
>                     nx6125.
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.22, 2.6.23
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: low
>           Priority: P1
>          Component: Video(Other)
>         AssignedTo: drivers_video-other@kernel-bugs.osdl.org
>         ReportedBy: daniel.wuerfel@gmx.net
> 
> 
> Most recent kernel where this bug did not occur:2.6.21
> Distribution:gentoo
> Hardware Environment:HP nx6125 BIOS version F.11
> Software Environment:Gnome 2.18, ati-driver 8.40.4
> Problem Description:If you enable "support for frame buffer devices", "Vesa vga
> graphics support" and "ati radeon display support" under "graphics support" so
> you lost fan cantrol on your hp nx6125, that means the fan doens't stop
> working.
> 
> Steps to reproduce:Enable "support for frame buffer devices", "Vesa vga
> graphics support" and "ati radeon display support" under "graphics support" on
> your hp nx6125 and after the next boot the fan will not switched off.
> 

Does anyone know whether this is likely to be a radeon driver bug or an
acpi bug or something else??

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
