From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [Linux-fbdev-devel] rotation.
Date: 10 Jan 2003 18:26:51 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1042171520.933.126.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301091949560.5660-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0301091949560.5660-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Fri, 2003-01-10 at 03:54, James Simmons wrote:
> 
> > However, as Geert mentioned, if you want to support rotation
> > generically, then you have to do it in the fbcon level.  The driver need
> > not know if the display is rotated or not.  All it needs to do is fill a
> > region with color, color expand a bitmap and move blocks of data, and
> > optionally 'pan' the window.  Fbcon will pass the correct (ie, oriented)
> > information for the driver.
> 
> Yes. Hardware rotation shouldn't also not effect the way accel 
> operatations are done.
 
The main difference is if the hardware supports rotation, fbcon will
present it with "normal" data.  With the generic implementation, fbcon
will present the driver with rotated data.

So we need a driver capabilities field either in fb_info or
fb_fix_screeninfo.

> 
> > This will not be too processor intensive as long as some data is
> > prepared beforehand, like a rotated fontdata.
> 
> Yeap!! The only thing is we could end up with 4 times the amount of data.
>  

Not really.  We can dynamically rotate the fontdata using the default
display->fontdata into another buffer.  I believe I have functions that
do that in the patch I submitted.  (Sorry, I lost it when one of my
drives crashed :-(.

Tony
