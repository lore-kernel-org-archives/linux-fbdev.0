From: Otto Solares <solca@guug.org>
Subject: Re: ioremap problem on highmem
Date: Mon, 13 Oct 2003 18:14:45 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031014001445.GC454@guug.org>
References: <20031013191831.GB454@guug.org> <20031013203058.20364.qmail@web14915.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9Cro-0001PK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 13 Oct 2003 17:16:48 -0700
Received: from opensource-ca.org ([168.234.203.30] helo=guug.galileo.edu)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A9Crn-00066G-Jn
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Oct 2003 17:16:47 -0700
Content-Disposition: inline
In-Reply-To: <20031013203058.20364.qmail@web14915.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Good catch! hopefully someone fix the real problem so we don't
have to use workarounds.

-solca

On Mon, Oct 13, 2003 at 01:30:58PM -0700, Jon Smirl wrote:
> This is a better work around:
> 
> kernel /vmlinuz-2.6.0-test7 ro root=/dev/hda5 acpi=ht hdd=ide-scsi
> reserve=FE000000-100000000
> 
> This reserves a block of address space for the Radeon card and then pushes the
> rest of RAM as highmem.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
