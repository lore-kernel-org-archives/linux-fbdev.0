From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: Radeon 9000 on a linux 2.4.18 kernel.
Date: Fri, 24 Jan 2003 10:39:46 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030124093946.GA2018@iliana>
References: <20030124093155.GA1998@iliana> <Pine.GSO.4.21.0301241033510.7472-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254] helo=mel-rto2.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18c0Jd-0002CK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jan 2003 01:40:01 -0800
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0301241033510.7472-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Jan 24, 2003 at 10:34:10AM +0100, Geert Uytterhoeven wrote:
> On Fri, 24 Jan 2003, Sven Luther wrote:
> > On Fri, Jan 24, 2003 at 10:23:19AM +0100, Geert Uytterhoeven wrote:
> > > On Fri, 24 Jan 2003, Sven Luther wrote:
> > > >   2) Does anyone know how to check the pci ids of such a card from OF ?
> > > 
> > > dev /<path_to_device> (use `dev' and `ls' to find out)
> > > .properties
> > 
> > Ok, thanks, will try, it is much easier (i guess) than blindly typing
> > stuff in the the display less linux, and moving the disk (and the pci
> > scsi card) between boxes. I already broke a pin of the vga connector
> > attached to my monitor by doing this and had to buy a new monitor.
> 
> Serial console is still not working?

Yes, for boot log output, but it hangs after i get the first debian
screen. I guess it is a problem with the the debian boot floppies i use,
i think i should create a root partition with a serial console enabling
inittab, or something such, i didn't had time to work much at this right
now though.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
