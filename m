From: Ian Romanick <idr@us.ibm.com>
Subject: Re: Add three new IOCTLs to FB API
Date: Sun, 21 Sep 2003 23:13:14 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3F6E92FA.5090601@us.ibm.com>
References: <20030922052838.53671.qmail@web14913.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1JxF-0000dk-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Sep 2003 23:13:49 -0700
Received: from e6.ny.us.ibm.com ([32.97.182.106])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A1JxE-0004DA-UT
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Sep 2003 23:13:49 -0700
Received: from northrelay04.pok.ibm.com (northrelay04.pok.ibm.com [9.56.224.206])
	by e6.ny.us.ibm.com (8.12.10/8.12.2) with ESMTP id h8M6DHIq335144
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 02:13:17 -0400
Received: from us.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by northrelay04.pok.ibm.com (8.12.9/NCO/VER6.6) with ESMTP id h8M6DFhS179694
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 02:13:16 -0400
In-Reply-To: <20030922052838.53671.qmail@web14913.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Jon Smirl wrote:

> 1) Get location of card that is associated with this fb device. It would return
> bus,dev,func of hardware. There may be more than one piece of the same hardware
> installed.
> 
> 3) Get vendor and card PCI ID

This should also return the Subsystem vendor and ID.

> 2) Get 3D driver name. Return the name of the DRM driver that is associated
> with this fb device. For example aty128fb would return r128, radeonfb would
> return radeon. Empty string if there is none. There are eight DRM drivers and
> 15 fb ones.

Would that be just the DRM name or the client-side DRI driver name as 
well?  Don't you need both?




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
