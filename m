From: Ani Joshi <ajoshi@unixbox.com>
Subject: Re: Radeon 9000 on a linux 2.4.18 kernel.
Date: Fri, 24 Jan 2003 11:09:46 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.50.0301241108120.74886-100000@shell.unixbox.com>
References: <20030124090423.GA1690@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from unixbox.com
	([207.211.45.65] helo=shell.unixbox.com ident=root)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18c9DK-0002uh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jan 2003 11:10:06 -0800
In-Reply-To: <20030124090423.GA1690@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net


Try patching your 2.4.18 with

http://gate.crashing.org/~ajoshi/radeonfb-0.1.6.diff.gz

(I forget which kernel I made this diff against, but it shouldn't complain
much.)


ani



On Fri, 24 Jan 2003, Sven Luther wrote:

> Hello, ...
>
> I am trying to use a Radeon 9000 on my pegasos board, and had the same
> success with it as with the matrox millenium II i used previously. Well,
> it is even worse, since radeonfb doesn't even output a bit in the boot
> log.
>
> After a bit of thinking, i realize that this is quite normal, sine i
> have to use a 2.4.18 kernel, which knows nothing of the Radeon 9000,
> since it did not exist at that time.
>
> So, my questions are :
>
>   1) is it ok to just add the Radeon 9000 pci ids and whatever to the
>   2.4.28 kernel and hope it works. (Maybe not, but then the Radeon 9000
>   and the Radeon 8500 are supposed to be really similar).
>
>   2) Does anyone know how to check the pci ids of such a card from OF ?
>
>   3) Are the 2.5.x kernel working on powerpc, and if yes, is the
>   radeonfb driver ported ?
>
> Friendly,
>
> Sven Luther
>
>
>
>
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
