From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] rotation.
Date: Thu, 9 Jan 2003 19:54:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0301091949560.5660-100000@phoenix.infradead.org>
References: <1042044916.1003.144.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1042044916.1003.144.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>


> However, as Geert mentioned, if you want to support rotation
> generically, then you have to do it in the fbcon level.  The driver need
> not know if the display is rotated or not.  All it needs to do is fill a
> region with color, color expand a bitmap and move blocks of data, and
> optionally 'pan' the window.  Fbcon will pass the correct (ie, oriented)
> information for the driver.

Yes. Hardware rotation shouldn't also not effect the way accel 
operatations are done. 

> This will not be too processor intensive as long as some data is
> prepared beforehand, like a rotated fontdata.

Yeap!! The only thing is we could end up with 4 times the amount of data.
 
> The main difficulty with this approach is how do you tell the console to
> rotate the display?  We cannot use fbset because the changes will not be
> visible to fbcon. 

I think it should video fbcon=rotate:90 command line for example.

> I submitted a patch before (see fbdev archives for "Console Rotation"
> thread) that rotates the console this way.  I had vga16fb, vesafb, and

I seen it and even have it still. 
