From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Bug in vga16fb?
Date: Thu, 06 Apr 2006 21:56:42 +0800
Message-ID: <44351E1A.8050404@gmail.com>
References: <20060404204002.GB2251@localhost.localdomain> <44344950.9090703@vc.cvut.cz> <20060406073713.GA3051@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRUzP-0004Uu-Qm
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Apr 2006 06:57:35 -0700
Received: from pproxy.gmail.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FRUzN-0004MC-VV
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Apr 2006 06:57:35 -0700
Received: by pproxy.gmail.com with SMTP id o67so180155pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Apr 2006 06:57:29 -0700 (PDT)
In-Reply-To: <20060406073713.GA3051@localhost.localdomain>
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
Cc: santiago@mail.cz

Ondrej Zajicek wrote:
> On Thu, Apr 06, 2006 at 12:48:48AM +0200, Petr Vandrovec wrote:
>> Ondrej Zajicek wrote:
> 
> Even if we find some possibility to autodetect what hardware does (or in
> case of another, non-VGA hardware using CFB4 mode) there would be
> problem that driver cannot say it to userspace (or generic kernel
> functions like cfb_imageblit). Maybe there should be some flag in
> type_aux specifying whether given packed pixel mode is LSB-first or
> MSB-first (relevant only for bpp % 8 != 0) ?
> 

var->{red|green|blue|transp}.msb_right

This field is currently ignored by fbcon, but you can use this field to
inform userspace what you want.

And once a driver uses this flag, we can probably alter the drawing
functions to not ignore this flag.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
