From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: ioremap problem on highmem
Date: Mon, 13 Oct 2003 21:51:43 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031014045143.53369.qmail@web14912.mail.yahoo.com>
References: <20031014015656.GE454@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9H9s-0006hf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 13 Oct 2003 21:51:44 -0700
Received: from web14912.mail.yahoo.com ([216.136.225.248])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A9H9s-0004xM-2F
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Oct 2003 21:51:44 -0700
In-Reply-To: <20031014015656.GE454@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

--- Otto Solares <solca@guug.org> wrote:

I almost have the DRI changes done. 

I haven't tried adjusting the DRI Creator3D driver for my changes since I don't
have Sparc hardware.  Does sparc use the same kind of PCI ID probing that x86
does in a kernel module? Which 3D hardware do you have?

I'll check the DRI changes in as soon as they work; they are pretty minor. Then
I can get back to working on standalone Mesa. The whole purpose in doing this
is to fix things so that standalone Mesa doesn't need a config file.

Dummy con is spac equivalent of VGA con on X86.

> Without fbcon, where the printk goes?
How does klogd get the printk's? I think it reads them from /proc/kmsg. The
terminal program can get them the same way.

> Hey, this sound too cool to be true ;) any code yet? i would like to develop
> on such beast.
Want to write the terminal program? or work on the user libs? Go ahead and
start coding. See the drmtest program in the mesa tree.



=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
