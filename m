From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 9155] New: No fan control
	with ATI Radeon display support on HP nx6125.
Date: Sat, 13 Oct 2007 20:30:20 +0200
Message-ID: <200710132030.20826.rjw@sisk.pl>
References: <bug-9155-10286@http.bugzilla.kernel.org/>
	<20071013105315.accef6aa.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IglVf-0004He-FN for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 13 Oct 2007 11:14:47 -0700
Received: from ogre.sisk.pl ([217.79.144.158])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IglVd-00027Y-V7
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 13 Oct 2007 11:14:47 -0700
In-Reply-To: <20071013105315.accef6aa.akpm@linux-foundation.org>
Content-Disposition: inline
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>, daniel.wuerfel@gmx.net, linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, Len Brown <lenb@kernel.org>

On Saturday, 13 October 2007 19:53, Andrew Morton wrote:
> On Sat, 13 Oct 2007 02:37:35 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:
> 
> > Most recent kernel where this bug did not occur:2.6.21
> > Distribution:gentoo
> > Hardware Environment:HP nx6125 BIOS version F.11
> > Software Environment:Gnome 2.18, ati-driver 8.40.4

Looks like the binary ATI driver is used.

> > Problem Description:If you enable "support for frame buffer devices", "Vesa vga
> > graphics support" and "ati radeon display support" under "graphics support" so
> > you lost fan cantrol on your hp nx6125, that means the fan doens't stop
> > working.
> > 
> > Steps to reproduce:Enable "support for frame buffer devices", "Vesa vga
> > graphics support" and "ati radeon display support" under "graphics support" on
> > your hp nx6125 and after the next boot the fan will not switched off.
> > 
> 
> Does anyone know whether this is likely to be a radeon driver bug or an
> acpi bug or something else??

It looks like a thermal issue to me, so I'd say ACPI or the ATI driver (or the
combination of the two).

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
