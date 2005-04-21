From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives
 black screen
Date: Thu, 21 Apr 2005 09:22:15 -0700
Message-ID: <20050421092215.3e6d8be4.rddunlap@osdl.org>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>
	<200504141351.42971.adaplas@hotpop.com>
	<20050414191323.10d7d435.khali@linux-fr.org>
	<200504151107.49810.adaplas@hotpop.com>
	<a44ae5cd05041601211c292316@mail.gmail.com>
	<a44ae5cd05042022512e840cfa@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DOeSO-0001xb-M9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Apr 2005 09:23:12 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DOeRu-0007up-OC
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Apr 2005 09:23:12 -0700
In-Reply-To: <a44ae5cd05042022512e840cfa@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: miles.lane@gmail.com, adaplas@pol.net, khali@linux-fr.org, akpm@osdl.org

On Thu, 21 Apr 2005 01:51:12 -0400 Miles Lane wrote:

| Your patches seem to have fixed the Oops with I2C, but 
| nvidiafb is not working unless I specify more than vmalloc=128M
| in the append options.  That is, the default kernel options
| do not provide for a working nvidiafb display.
| 
| Here's what I get when testing 2.6.12-rc2-mm3
| (I verified that your two patches have been applied in my
| tree):
| 
| Kernel command line: BOOT_IMAGE=Linux ro root=306
| video=nvidiafb:1280x1024-16@85 vmalloc=
| 128M init=/etc/init lang=us apm=power-off nomce
| 
...
| allocation failed: out of vmalloc space - use vmalloc=<size> to increase size.
| nvidiafb: cannot ioremap FB base
| 
| When I boot, the screen stays black until XFree86 starts up.

Tony,

As I wrote to Miles a few weeks ago:
"I started looking at vmalloc() and what it calls (which is
__get_vm_area).  _get_vm_area() always allocates one extra
page (called a "guard page") between all vmalloc allocations,
so even though 128 MB is the default amount and the amount
that nvidiafb wants to use, the kernel wants to allocate
128 MB + PAGE_SIZE (4 KB on x86; are you on x86?), so even
if nvidiafb is the only caller, the vmalloc() call will
fail."

This means that the default kernel vmalloc size of 128MB
cannot be totally (fully) allocated due to this code:
	/*
	 * We always allocate a guard page.
	 */
	size += PAGE_SIZE;

IMO we (somebody) should add the guard page into the default
vmalloc size so that the full 128MB can be allocated.
I'll take a look at doing that... no promises.

---
~Randy


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
