From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Linux-fbdev-devel] New kernel API for ROMs
Date: Sat, 07 Aug 2004 17:09:58 +0100
Sender: dri-devel-admin@lists.sourceforge.net
Message-ID: <1091894996.18407.122.camel@localhost.localdomain>
References: <Pine.GSO.4.58.0408071515350.3475@waterleaf.sonytel.be>
	 <20040807145929.77135.qmail@web14923.mail.yahoo.com>
	 <20040807163733.GD3714@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040807163733.GD3714@dreamland.darkstar.lan>
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
To: Kronos <kronos@people.it>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Geert Uytterhoeven <geert@linux-m68k.org>, DRI Devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sad, 2004-08-07 at 17:37, Kronos wrote:
> You can check and see if the ROM is really big and use vmalloc, if not
> then you use kmalloc (if I remember correctly my radeon has a 4KB ROM -
> vmalloc would be overkill).

You can also read it out to userspace in a loop in chunks thus needing
only a single 4K page or you could mmap it



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
--
