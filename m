From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New kernel API for ROMs
Date: Sat, 07 Aug 2004 19:51:51 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1091904710.18813.1.camel@localhost.localdomain>
References: <20040807174057.35529.qmail@web14922.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040807174057.35529.qmail@web14922.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Kronos <kronos@people.it>, Geert Uytterhoeven <geert@linux-m68k.org>, DRI Devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sad, 2004-08-07 at 18:40, Jon Smirl wrote:
> We have to copy the whole thing when the driver tells us to. After we
> copy the ROM the hardware is going to use the address decoder for
> something else. There is no safe way to get back to the ROM again other
> than to unload the device driver.

Good point on mmap not working yes. We can still copy it in 4K chunks to
userspace though not keep it in kernel. The rom boot stuff in the design
is in user space.



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
